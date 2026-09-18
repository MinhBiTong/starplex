CREATE TABLE `Users` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `email` varchar(255) UNIQUE NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `full_name` varchar(255),
  `avatar_url` varchar(500),
  `role` ENUM ('user', 'admin') NOT NULL,
  `status` ENUM ('active', 'inactive', 'banned') NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime
);

CREATE TABLE `RefreshTokens` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `token_hash` varchar(500) NOT NULL,
  `expires_at` datetime NOT NULL,
  `revoked_at` datetime,
  `created_at` datetime NOT NULL
);

CREATE TABLE `PasswordResetTokens` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `token_hash` varchar(500) NOT NULL,
  `expires_at` datetime NOT NULL,
  `used_at` datetime,
  `created_at` datetime NOT NULL
);

CREATE TABLE `Generations` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `type` ENUM ('image', 'video') NOT NULL,
  `prompt` text NOT NULL,
  `negative_prompt` text,
  `aspect_ratio` varchar(20),
  `resolution` varchar(50),
  `duration_seconds` int,
  `status` ENUM ('pending', 'processing', 'completed', 'failed') NOT NULL,
  `credit_cost` int NOT NULL,
  `error_message` text,
  `created_at` datetime NOT NULL,
  `completed_at` datetime
);

CREATE TABLE `GenerationFiles` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `generation_id` int NOT NULL,
  `file_type` ENUM ('image', 'video', 'thumbnail') NOT NULL,
  `file_url` varchar(2000) NOT NULL,
  `file_size` bigint,
  `created_at` datetime NOT NULL
);

CREATE TABLE `CreditWallets` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `user_id` int UNIQUE NOT NULL,
  `balance` int NOT NULL,
  `updated_at` datetime NOT NULL
);

CREATE TABLE `CreditTransactions` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `wallet_id` int NOT NULL,
  `type` ENUM ('purchase', 'generation', 'refund', 'bonus', 'adjustment') NOT NULL,
  `amount` int NOT NULL,
  `balance_before` int NOT NULL,
  `balance_after` int NOT NULL,
  `reference_type` varchar(50),
  `reference_id` int,
  `description` varchar(500),
  `created_at` datetime NOT NULL
);

CREATE TABLE `PaymentPackages` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `price` decimal(18,2) NOT NULL,
  `currency` varchar(10) NOT NULL,
  `credit_amount` int NOT NULL,
  `description` text,
  `is_active` bit NOT NULL,
  `billing_period` ENUM ('monthly', 'yearly', 'one_time') NOT NULL DEFAULT 'one_time',
  `is_featured` bit NOT NULL DEFAULT 0,
  `created_at` datetime NOT NULL,
  `updated_at` datetime
);

CREATE TABLE `PaymentPackageBenefits` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `package_id` int NOT NULL,
  `benefit` varchar(500) NOT NULL,
  `sort_order` int NOT NULL,
  `created_at` datetime NOT NULL
);

CREATE TABLE `Payments` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `package_id` int NOT NULL,
  `package_name` varchar(255) NOT NULL,
  `credit_amount` int NOT NULL,
  `amount` decimal(18,2) NOT NULL,
  `currency` varchar(10) NOT NULL,
  `payment_method` ENUM ('momo', 'zalopay', 'vnpay', 'bank_transfer', 'stripe', 'other') NOT NULL,
  `status` ENUM ('pending', 'completed', 'failed', 'cancelled') NOT NULL,
  `transaction_code` varchar(255),
  `provider_transaction_id` varchar(500),
  `created_at` datetime NOT NULL,
  `paid_at` datetime,
  UNIQUE KEY `uq_payments_transaction_code` (`transaction_code`)
);

CREATE TABLE `SystemSettings` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `setting_key` varchar(100) UNIQUE NOT NULL,
  `setting_value` text,
  `value_type` ENUM ('string', 'int', 'bool', 'json') NOT NULL DEFAULT 'string',
  `updated_by` int,
  `updated_at` datetime NOT NULL
);

ALTER TABLE `RefreshTokens` ADD FOREIGN KEY (`user_id`) REFERENCES `Users` (`id`);

ALTER TABLE `PasswordResetTokens` ADD FOREIGN KEY (`user_id`) REFERENCES `Users` (`id`);

ALTER TABLE `Generations` ADD FOREIGN KEY (`user_id`) REFERENCES `Users` (`id`);

ALTER TABLE `GenerationFiles` ADD FOREIGN KEY (`generation_id`) REFERENCES `Generations` (`id`);

ALTER TABLE `CreditWallets` ADD FOREIGN KEY (`user_id`) REFERENCES `Users` (`id`);

ALTER TABLE `CreditTransactions` ADD FOREIGN KEY (`user_id`) REFERENCES `Users` (`id`);

ALTER TABLE `CreditTransactions` ADD FOREIGN KEY (`wallet_id`) REFERENCES `CreditWallets` (`id`);

ALTER TABLE `PaymentPackageBenefits` ADD FOREIGN KEY (`package_id`) REFERENCES `PaymentPackages` (`id`);

ALTER TABLE `Payments` ADD FOREIGN KEY (`user_id`) REFERENCES `Users` (`id`);

ALTER TABLE `Payments` ADD FOREIGN KEY (`package_id`) REFERENCES `PaymentPackages` (`id`);
ALTER TABLE `SystemSettings` ADD FOREIGN KEY (`updated_by`) REFERENCES `Users` (`id`);

CREATE INDEX `idx_generations_user` ON `Generations` (`user_id`);
CREATE INDEX `idx_credit_transactions_user` ON `CreditTransactions` (`user_id`);
CREATE INDEX `idx_payments_user` ON `Payments` (`user_id`);
CREATE INDEX `idx_payments_status` ON `Payments` (`status`);
CREATE INDEX `idx_packages_active` ON `PaymentPackages` (`is_active`);

-- ============================================================
-- Indexes added for hot auth/token lookups (Tier 1).
-- Lookups by token_hash previously fell back to full table scans
-- once the table grew past a few thousand rows.
-- ============================================================
CREATE INDEX `idx_refresh_tokens_hash` ON `RefreshTokens` (`token_hash`);
CREATE INDEX `idx_refresh_tokens_user_active` ON `RefreshTokens` (`user_id`, `revoked_at`);
CREATE INDEX `idx_password_reset_tokens_hash` ON `PasswordResetTokens` (`token_hash`);

-- ============================================================
-- Defensive CHECK constraints (Tier 1).
-- The application layer already enforces these rules, but a
-- hard constraint guarantees integrity if a future code path
-- forgets to validate.
-- ============================================================
ALTER TABLE `CreditWallets`
  ADD CONSTRAINT `chk_credit_wallets_balance_non_negative`
  CHECK (`balance` >= 0);

ALTER TABLE `PaymentPackages`
  ADD CONSTRAINT `chk_payment_packages_price_non_negative`
  CHECK (`price` >= 0);

ALTER TABLE `PaymentPackages`
  ADD CONSTRAINT `chk_payment_packages_credit_positive`
  CHECK (`credit_amount` > 0);
