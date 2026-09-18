import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ai_app/l10n/generated/app_localizations.dart';
import 'package:ai_app/screens/auth_screen.dart';
import 'package:ai_app/screens/admin_dashboard_screen.dart';
import 'package:ai_app/screens/home_screen.dart';
import 'package:ai_app/screens/production_terms_screen.dart';
import 'package:ai_app/widgets/flagship_ui.dart';

/// Pumps [home] inside a MaterialApp wired with the app's l10n delegates,
/// so screens can resolve AppLocalizations during tests.
Future<void> pumpApp(WidgetTester tester, Widget home) async {
  await tester.pumpWidget(
    MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: home,
    ),
  );
}

void main() {
  testWidgets('primary button surface fills a bounded parent', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Center(
          child: SizedBox(
            width: 360,
            child: ReelButton(label: 'VÀO ROLL ►', onPressed: () {}),
          ),
        ),
      ),
    );

    final surface = find.descendant(
      of: find.byType(ReelButton),
      matching: find.byType(Ink),
    );
    expect(tester.getSize(surface).width, 360);
    expect(tester.takeException(), isNull);
  });

  testWidgets('admin dashboard adapts across common viewport widths', (
    tester,
  ) async {
    const sizes = [
      Size(320, 800),
      Size(360, 800),
      Size(600, 800),
      Size(1280, 800),
    ];

    for (final size in sizes) {
      await tester.binding.setSurfaceSize(size);
      await pumpApp(tester, const AdminDashboardScreen());
      await tester.pump();
      // Admin views fire real dio requests in initState; advance fake time
      // past the client's connect timeout so those timers fire and settle
      // instead of leaking past the end of the test.
      await tester.pump(const Duration(seconds: 35));
      expect(tester.takeException(), isNull, reason: 'Admin overflow at $size');
    }
  });

  testWidgets('admin dashboard mobile navigation keeps every view usable', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(320, 800));
    await pumpApp(tester, const AdminDashboardScreen());
    await tester.pump();

    const destinations = [
      'Overview',
      'Users',
      'Moderation',
      'Revenue',
      'System',
    ];

    for (final destination in destinations) {
      await tester.tap(find.byTooltip('Open menu'));
      await tester.pumpAndSettle();
      await tester.tap(find.text(destination));
      await tester.pumpAndSettle();
      expect(
        tester.takeException(),
        isNull,
        reason: 'Admin overflow in $destination',
      );
    }
  });

  testWidgets('auth screen adapts and switches modes on mobile', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(320, 800));
    await pumpApp(tester, const AuthScreen());
    await tester.pump();
    expect(tester.takeException(), isNull);

    // đăng nhập → đăng ký qua link dưới form
    await tester.ensureVisible(find.textContaining('Sign up now'));
    await tester.tap(find.textContaining('Sign up now'));
    await tester.pumpAndSettle();
    expect(find.text('Welcome back'), findsNothing);
    expect(find.byType(ProductionTermsScreen), findsNothing);

    // mở điều khoản từ checkbox
    await tester.ensureVisible(find.text('Production Terms'));
    await tester.tap(find.text('Production Terms'));
    await tester.pumpAndSettle();
    expect(find.byType(ProductionTermsScreen), findsOneWidget);
    await tester.ensureVisible(find.text('BACK'));
    await tester.tap(find.text('BACK'));
    await tester.pumpAndSettle();
    expect(find.byType(AuthScreen), findsOneWidget);

    // đăng ký → đăng nhập → quên mật khẩu
    await tester.ensureVisible(find.textContaining('Sign in'));
    await tester.tap(find.textContaining('Sign in'));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.textContaining('Forgot password?'));
    await tester.tap(find.textContaining('Forgot password?'));
    await tester.pumpAndSettle();
    expect(find.byType(AuthScreen), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('home sign in button opens auth screen', (tester) async {
    await tester.binding.setSurfaceSize(const Size(800, 800));
    await pumpApp(tester, const ReelHomePage());
    await tester.pump();
    await tester.tap(find.text('SIGN IN'));
    await tester.pumpAndSettle();
    expect(find.byType(AuthScreen), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('tool catalog dialog opens, filters and picks a preview tool', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(1280, 900));
    await pumpApp(tester, const ReelHomePage());
    await tester.pump();

    await tester.tap(find.text('See all 20 tools'));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
    expect(find.text('All AI tools'), findsOneWidget);
    // nhóm đầu hiển thị ngay; nhóm cuối nằm ngoài viewport (ListView lười)
    expect(find.text('IMAGES & DESIGN'), findsOneWidget);
    await tester.scrollUntilVisible(
      find.text('TECH & AUTOMATION'),
      200,
      scrollable: find.byType(Scrollable).last,
    );
    expect(find.text('TECH & AUTOMATION'), findsOneWidget);

    // lọc tìm kiếm — finder scoped vào dialog vì trang sau vẫn có thẻ cùng tên
    await tester.enterText(find.byType(TextField).first, 'voice');
    await tester.pump();
    final inDialog = find.descendant(
      of: find.byType(Dialog),
      matching: find.text('Voice'),
    );
    expect(inDialog, findsOneWidget);
    expect(
      find.descendant(of: find.byType(Dialog), matching: find.text('Image')),
      findsNothing,
    );

    // xoá filter, chọn "Music" (preview tool)
    await tester.enterText(find.byType(TextField).first, '');
    await tester.pump();
    await tester.scrollUntilVisible(
      find.text('BGM'),
      300,
      scrollable: find.byType(Scrollable).last,
    );
    await tester.tap(find.text('BGM'));
    await tester.pumpAndSettle();

    // dialog đóng, panel preview mở + toast sắp ra mắt
    expect(find.text('All AI tools'), findsNothing);
    expect(find.text('BGM'), findsWidgets);
    expect(find.text('BGM is coming soon — only Image & Video are live right now.'), findsOneWidget);
    expect(find.text('≈ ≈ 10 CR'), findsNothing);
    expect(tester.takeException(), isNull);
  });
}
