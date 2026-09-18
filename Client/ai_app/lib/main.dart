import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'core/app_fonts.dart';

import 'core/app_colors.dart';
import 'core/auth_session.dart';
import 'core/locale_controller.dart';
import 'core/payment_callback_handler.dart';
import 'l10n/generated/app_localizations.dart';
import 'screens/admin_dashboard_screen.dart';
import 'screens/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Allow Google Fonts to fetch any missing variants (e.g. Inter-Italic) at
  // runtime. Without this the web build falls back to a 400 and the chosen
  // font variant is dropped silently. Native platforms use the pre-bundled
  // assets whenever available.
  GoogleFonts.config.allowRuntimeFetching = true;
  await LocaleController.instance.bootstrap();
  runApp(const ReelApp());
}

ThemeData reelTheme() => ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: AppColors.ink,
  fontFamily: AppFonts.inter().fontFamily,
  colorScheme: ColorScheme.dark(
    primary: AppColors.azure,
    secondary: AppColors.indigo,
    surface: AppColors.surface,
  ),
  textTheme: TextTheme(
    displayLarge: AppFonts.spaceGrotesk(
      color: AppColors.mist,
      fontWeight: FontWeight.w700,
    ),
    displayMedium: AppFonts.spaceGrotesk(
      color: AppColors.mist,
      fontWeight: FontWeight.w600,
    ),
    headlineMedium: AppFonts.spaceGrotesk(
      color: AppColors.mist,
      fontWeight: FontWeight.w600,
    ),
    bodyLarge: AppFonts.inter(color: AppColors.mist),
    bodyMedium: AppFonts.inter(color: AppColors.parchmentDim),
    labelLarge: AppFonts.inter(fontWeight: FontWeight.w600),
  ),
  inputDecorationTheme: InputDecorationTheme(
    labelStyle: AppFonts.inter(color: AppColors.parchmentDim),
    hintStyle: AppFonts.inter(color: AppColors.muted),
  ),
);

class ReelApp extends StatefulWidget {
  const ReelApp({super.key});
  @override
  State<ReelApp> createState() => _ReelAppState();
}

class _ReelAppState extends State<ReelApp> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: LocaleController.instance,
      builder: (context, _) {
        final controller = LocaleController.instance;
        return MaterialApp(
          navigatorKey: _navigatorKey,
          // AppLocalizations ships a `localizationsDelegates` getter that
          // already bundles the Global delegates — we forward it directly so
          // adding/removing locales stays in sync with the ARB files.
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales:
              LocaleController.supported.map((o) => o.locale).toList(),
          locale: controller.locale,
          title: 'REEL — AI Film & Photo Studio',
          debugShowCheckedModeBanner: false,
          theme: reelTheme(),
          home: const _SessionGate(),
          onGenerateRoute: (settings) {
            final uri = Uri.tryParse(settings.name ?? '');
            if (uri != null && PaymentCallbackHandler.isPaymentCallback(uri)) {
              return MaterialPageRoute(
                builder: (_) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    final navigatorContext = _navigatorKey.currentContext;
                    if (navigatorContext != null) {
                      PaymentCallbackHandler.handleCallback(
                        navigatorContext,
                        uri,
                      );
                    }
                  });
                  return const ReelHomePage();
                },
              );
            }
            return null;
          },
        );
      },
    );
  }
}

class _SessionGate extends StatefulWidget {
  const _SessionGate();
  @override
  State<_SessionGate> createState() => _SessionGateState();
}

class _SessionGateState extends State<_SessionGate> {
  late final Future<bool> _restoreFuture = AuthSession.restore();
  @override
  Widget build(BuildContext context) => FutureBuilder<bool>(
    future: _restoreFuture,
    builder: (_, snapshot) {
      if (!snapshot.hasData) return const ReelHomePage();
      return snapshot.data == true && AuthSession.role == 'admin'
          ? const AdminDashboardScreen()
          : const ReelHomePage();
    },
  );
}
