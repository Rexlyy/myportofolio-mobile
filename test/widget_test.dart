
import 'package:flutter_test/flutter_test.dart';
import 'package:myportofolio_mobile/main.dart';

void main() {
  testWidgets('MyPortfolio homepage displays correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Memastikan judul aplikasi muncul
    expect(find.text('MyPortfolio'), findsOneWidget);

    // Memastikan informasi profil muncul
    expect(find.text('NPM'), findsOneWidget);
    expect(find.text('2506546932'), findsOneWidget);
    expect(find.text('Name'), findsOneWidget);
    expect(find.text('Lynorexly Imanuel Tatipikalawan'), findsOneWidget);
    expect(find.text('Class'), findsOneWidget);
    expect(find.text('PBP'), findsOneWidget);

    // Memastikan tiga tombol menu muncul
    expect(find.text('Lihat Proyek'), findsOneWidget);
    expect(find.text('Tambah Proyek'), findsOneWidget);
    expect(find.text('Logout'), findsOneWidget);
  });

  testWidgets('Lihat Proyek button displays SnackBar',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text('Lihat Proyek'));
    await tester.pump();

    expect(
      find.text('Kamu telah menekan tombol Lihat Proyek!'),
      findsOneWidget,
    );
  });

  testWidgets('Tambah Proyek button displays SnackBar',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text('Tambah Proyek'));
    await tester.pump();

    expect(
      find.text('Kamu telah menekan tombol Tambah Proyek!'),
      findsOneWidget,
    );
  });

  testWidgets('Logout button displays SnackBar',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text('Logout'));
    await tester.pump();

    expect(
      find.text('Kamu telah menekan tombol Logout!'),
      findsOneWidget,
    );
  });
}
