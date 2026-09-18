-- ============================================================
-- REEL / Project4 - Sample data
-- Chạy sau khi đã tạo schema trong Project4.sql.
-- Database mặc định của project: project4
--
-- Tài khoản mẫu:
--   Admin: sample.admin@reel.studio / Admin@123
--   User : sample.user@reel.studio  / User@123
-- ============================================================

USE project4;

START TRANSACTION;

-- ------------------------------------------------------------
-- Users
-- ------------------------------------------------------------
INSERT INTO Users
    (id, email, password_hash, full_name, avatar_url, role, status, created_at, updated_at)
VALUES
    (1001, 'sample.admin@reel.studio', '$2b$12$NBpg8p6JiV9iWU6AXH5zeea93jUH4OJPQzqxgPN4683kUi0JnI.vi',
     'Sample Admin', NULL, 'admin', 'active', NOW(), NOW()),
    (1002, 'sample.user@reel.studio', '$2b$12$VxV/twKcMPXM3b/uDVusr.Wp7dxinyr7yaCnX/6eX9B8AnLy9wdMO',
     'Sample User', NULL, 'user', 'active', NOW(), NOW()),
    (1003, 'sample.inactive@reel.studio', '$2b$12$VxV/twKcMPXM3b/uDVusr.Wp7dxinyr7yaCnX/6eX9B8AnLy9wdMO',
     'Inactive Sample User', NULL, 'user', 'inactive', NOW(), NOW())
ON DUPLICATE KEY UPDATE
    password_hash = VALUES(password_hash),
    full_name = VALUES(full_name),
    role = VALUES(role),
    status = VALUES(status),
    updated_at = VALUES(updated_at);

-- ------------------------------------------------------------
-- Credit wallets
-- ------------------------------------------------------------
INSERT INTO CreditWallets (id, user_id, balance, updated_at)
VALUES
    (1001, 1001, 1200, NOW()),
    (1002, 1002, 742, NOW()),
    (1003, 1003, 10, NOW())
ON DUPLICATE KEY UPDATE
    balance = VALUES(balance),
    updated_at = VALUES(updated_at);

-- ------------------------------------------------------------
-- System settings mặc định để các màn hình Settings/Usage có dữ liệu.
-- ------------------------------------------------------------
INSERT INTO SystemSettings
    (id, setting_key, setting_value, value_type, updated_by, updated_at)
VALUES
    (1001, 'studio_name', 'REEL — AI Film & Photo Studio', 'string', 1001, NOW()),
    (1002, 'support_email', 'support@reel.studio', 'string', 1001, NOW()),
    (1004, 'image_credit_cost', '3', 'int', 1001, NOW()),
    (1005, 'video_credit_cost', '12', 'int', 1001, NOW()),
    (1006, 'email_payment_failed', 'true', 'bool', 1001, NOW()),
    (1007, 'notify_generation_failed', 'true', 'bool', 1001, NOW()),
    (1008, 'newsletter_enabled', 'false', 'bool', 1001, NOW()),
    (1009, 'maintenance_mode', 'false', 'bool', 1001, NOW()),
    (1010, 'registration_enabled', 'true', 'bool', 1001, NOW())
ON DUPLICATE KEY UPDATE
    setting_value = VALUES(setting_value),
    value_type = VALUES(value_type),
    updated_by = VALUES(updated_by),
    updated_at = VALUES(updated_at);

-- ------------------------------------------------------------
-- Payment packages
-- ------------------------------------------------------------
INSERT INTO PaymentPackages
    (id, name, price, currency, credit_amount, description, is_active,
     billing_period, is_featured, created_at, updated_at)
VALUES
    (1001, 'Scout', 9.00, 'USD', 100,
     'Gói khởi đầu cho người dùng cá nhân.', 1, 'monthly', 0, NOW(), NOW()),
    (1002, 'Director', 29.00, 'USD', 500,
     'Gói phổ biến cho nhu cầu tạo nội dung thường xuyên.', 1, 'monthly', 1, NOW(), NOW()),
    (1003, 'Studio', 79.00, 'USD', 1500,
     'Gói nâng cao dành cho studio và creator chuyên nghiệp.', 1, 'monthly', 0, NOW(), NOW()),
    (1004, 'Studio Annual', 790.00, 'USD', 18000,
     'Gói studio theo năm, hiện đang tạm ngừng bán để test trạng thái.', 0, 'yearly', 0, NOW(), NOW())
ON DUPLICATE KEY UPDATE
    name = VALUES(name),
    price = VALUES(price),
    currency = VALUES(currency),
    credit_amount = VALUES(credit_amount),
    description = VALUES(description),
    is_active = VALUES(is_active),
    billing_period = VALUES(billing_period),
    is_featured = VALUES(is_featured),
    updated_at = VALUES(updated_at);

-- ------------------------------------------------------------
-- Benefits của các package
-- ------------------------------------------------------------
INSERT INTO PaymentPackageBenefits
    (id, package_id, benefit, sort_order, created_at)
VALUES
    (1001, 1001, '100 credits mỗi tháng', 1, NOW()),
    (1002, 1001, 'Tạo ảnh AI cơ bản', 2, NOW()),
    (1003, 1002, '500 credits mỗi tháng', 1, NOW()),
    (1004, 1002, 'Ưu tiên hàng đợi xử lý', 2, NOW()),
    (1005, 1002, 'Tạo ảnh độ phân giải cao', 3, NOW()),
    (1006, 1003, '1.500 credits mỗi tháng', 1, NOW()),
    (1007, 1003, 'Tạo ảnh và video nâng cao', 2, NOW()),
    (1008, 1003, 'Ưu tiên hỗ trợ kỹ thuật', 3, NOW()),
    (1009, 1004, '18.000 credits mỗi năm', 1, NOW()),
    (1010, 1004, 'Tiết kiệm khi thanh toán theo năm', 2, NOW())
ON DUPLICATE KEY UPDATE
    package_id = VALUES(package_id),
    benefit = VALUES(benefit),
    sort_order = VALUES(sort_order);

-- ------------------------------------------------------------
-- Payments
-- Các cột package_name và credit_amount là snapshot tại thời điểm mua.
-- ------------------------------------------------------------
INSERT INTO Payments
    (id, user_id, package_id, package_name, credit_amount, amount, currency,
     payment_method, status, transaction_code, provider_transaction_id,
     created_at, paid_at)
VALUES
    (1001, 1002, 1002, 'Director', 500, 29.00, 'USD',
     'bank_transfer', 'completed', 'SAMPLE-PAY-1001', 'SAMPLE-PROVIDER-1001',
     DATE_SUB(NOW(), INTERVAL 3 DAY), DATE_SUB(NOW(), INTERVAL 3 DAY)),
    (1002, 1002, 1001, 'Scout', 100, 9.00, 'USD',
     'vnpay', 'pending', 'SAMPLE-PAY-1002', NULL,
     DATE_SUB(NOW(), INTERVAL 1 HOUR), NULL),
    (1003, 1001, 1003, 'Studio', 1500, 79.00, 'USD',
     'momo', 'failed', 'SAMPLE-PAY-1003', 'SAMPLE-PROVIDER-1003',
     DATE_SUB(NOW(), INTERVAL 2 DAY), NULL)
ON DUPLICATE KEY UPDATE
    user_id = VALUES(user_id),
    package_id = VALUES(package_id),
    package_name = VALUES(package_name),
    credit_amount = VALUES(credit_amount),
    amount = VALUES(amount),
    currency = VALUES(currency),
    payment_method = VALUES(payment_method),
    status = VALUES(status),
    provider_transaction_id = VALUES(provider_transaction_id),
    paid_at = VALUES(paid_at);

-- ------------------------------------------------------------
-- Generations
-- ------------------------------------------------------------
INSERT INTO Generations
    (id, user_id, type, prompt, negative_prompt, aspect_ratio, resolution,
     duration_seconds, status, credit_cost, error_message, created_at, completed_at)
VALUES
    (1001, 1002, 'image',
     'A cinematic neon-lit street in Hanoi at night, professional film still',
     'blurry, low quality, distorted', '16:9', '1024x576', NULL,
     'completed', 3, NULL, DATE_SUB(NOW(), INTERVAL 2 HOUR), DATE_SUB(NOW(), INTERVAL 2 HOUR)),
    (1002, 1002, 'image',
     'A futuristic film studio with warm golden light',
     NULL, '16:9', '1024x576', NULL,
     'failed', 3, 'Sample generation failure for dashboard testing.', DATE_SUB(NOW(), INTERVAL 1 HOUR), NULL),
    (1003, 1001, 'image',
     'A Vietnamese mountain landscape at sunrise, cinematic composition',
     NULL, '16:9', '1024x576', NULL,
     'completed', 3, NULL, DATE_SUB(NOW(), INTERVAL 5 DAY), DATE_SUB(NOW(), INTERVAL 5 DAY))
ON DUPLICATE KEY UPDATE
    user_id = VALUES(user_id),
    type = VALUES(type),
    prompt = VALUES(prompt),
    negative_prompt = VALUES(negative_prompt),
    aspect_ratio = VALUES(aspect_ratio),
    resolution = VALUES(resolution),
    duration_seconds = VALUES(duration_seconds),
    status = VALUES(status),
    credit_cost = VALUES(credit_cost),
    error_message = VALUES(error_message),
    completed_at = VALUES(completed_at);

-- ------------------------------------------------------------
-- Files mẫu cho các generation đã hoàn thành.
-- Đây là URL placeholder, không phải file thật trong storage.
-- ------------------------------------------------------------
INSERT INTO GenerationFiles
    (id, generation_id, file_type, file_url, file_size, created_at)
VALUES
    (1001, 1001, 'image',
     'https://placehold.co/1024x576/png?text=Sample+Generation+1001', 0, DATE_SUB(NOW(), INTERVAL 2 HOUR)),
    (1002, 1003, 'image',
     'https://placehold.co/1024x576/png?text=Sample+Generation+1003', 0, DATE_SUB(NOW(), INTERVAL 5 DAY))
ON DUPLICATE KEY UPDATE
    generation_id = VALUES(generation_id),
    file_type = VALUES(file_type),
    file_url = VALUES(file_url),
    file_size = VALUES(file_size);

-- ------------------------------------------------------------
-- Credit transactions
-- Số dư cuối của wallet 1002: 242 + 500 - 3 + 3 = 742.
-- ------------------------------------------------------------
INSERT INTO CreditTransactions
    (id, user_id, wallet_id, type, amount, balance_before, balance_after,
     reference_type, reference_id, description, created_at)
VALUES
    (1001, 1002, 1002, 'purchase', 500, 242, 742,
     'payment', 1001, 'Mua gói Director - dữ liệu mẫu', DATE_SUB(NOW(), INTERVAL 3 DAY)),
    (1002, 1002, 1002, 'generation', -3, 742, 739,
     'generation', 1001, 'Trừ credit khi tạo ảnh - dữ liệu mẫu', DATE_SUB(NOW(), INTERVAL 2 HOUR)),
    (1003, 1002, 1002, 'refund', 3, 739, 742,
     'generation', 1002, 'Hoàn credit cho generation lỗi - dữ liệu mẫu', DATE_SUB(NOW(), INTERVAL 1 HOUR)),
    (1004, 1001, 1001, 'bonus', 200, 1000, 1200,
     'admin', 1001, 'Credit thưởng cho admin - dữ liệu mẫu', DATE_SUB(NOW(), INTERVAL 5 DAY))
ON DUPLICATE KEY UPDATE
    user_id = VALUES(user_id),
    wallet_id = VALUES(wallet_id),
    type = VALUES(type),
    amount = VALUES(amount),
    balance_before = VALUES(balance_before),
    balance_after = VALUES(balance_after),
    reference_type = VALUES(reference_type),
    reference_id = VALUES(reference_id),
    description = VALUES(description);

COMMIT;

-- Kiểm tra nhanh sau khi insert:
-- SELECT id, email, role, status FROM Users WHERE id BETWEEN 1001 AND 1003;
-- SELECT id, name, price, credit_amount, is_active, billing_period FROM PaymentPackages WHERE id BETWEEN 1001 AND 1004;
-- SELECT id, user_id, package_name, status, transaction_code FROM Payments WHERE id BETWEEN 1001 AND 1003;
-- SELECT id, user_id, balance FROM CreditWallets WHERE id BETWEEN 1001 AND 1003;
