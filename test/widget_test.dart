import 'package:flutter_test/flutter_test.dart';
import 'package:myportofolio_mobile/main.dart';
import 'package:myportofolio_mobile/services/api_client.dart';

// API tiruan agar test logout tidak membutuhkan koneksi Django.
class FakeApiClient extends ApiClient {
  @override
  Future<void> logout({required String token}) async {
    // Simulasikan logout berhasil tanpa HTTP request.
  }
}

void main() {
  testWidgets('MyPortfolio homepage displays correctly', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(MyApp(apiClient: FakeApiClient()));

    expect(find.text('MyPortfolio'), findsOneWidget);

    expect(find.text('NPM'), findsOneWidget);
    expect(find.text('2506546932'), findsOneWidget);
    expect(find.text('Name'), findsOneWidget);
    expect(find.text('Lynorexly Imanuel Tatipikalawan'), findsOneWidget);
    expect(find.text('Class'), findsOneWidget);
    expect(find.text('PBP'), findsOneWidget);

    expect(find.text('Lihat Proyek'), findsOneWidget);
    expect(find.text('Tambah Proyek'), findsOneWidget);
    expect(find.text('Logout'), findsOneWidget);
  });

  testWidgets('Lihat Proyek button navigates to ProjectListScreen', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(MyApp(apiClient: FakeApiClient()));

    await tester.tap(find.text('Lihat Proyek'));

    // Menunggu proses navigasi selesai.
    await tester.pumpAndSettle();

    // Memastikan halaman daftar proyek terbuka.
    expect(find.text('My Projects'), findsOneWidget);
  });

  testWidgets('Tambah Proyek button navigates to ProjectFormPage', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MyApp(apiClient: FakeApiClient(), initialToken: 'test-token'),
    );

    await tester.tap(find.text('Tambah Proyek'));
    await tester.pumpAndSettle();

    expect(find.text('Add New Project'), findsOneWidget);
    expect(find.text('Nama Proyek'), findsNWidgets(2));
    expect(find.text('Deskripsi'), findsOneWidget);
  });

  testWidgets('Logout button displays success SnackBar', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MyApp(apiClient: FakeApiClient(), initialToken: 'test-token'),
    );

    await tester.ensureVisible(find.text('Logout'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Logout'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.text('Berhasil logout!'), findsOneWidget);
  });
}
