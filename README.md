# myportofolio_mobile
A new Flutter project.

### Tugas 7

1. Widget tree merupakan sebuah struktur atau hierarki untuk menggambarkan hubungan antar widget dalam flutter. Hubungan antar parent dengan child, parent bertanggung jawab mengatur atau membungkus widget child.

2. Widget yang di gunakan dalam MyPortofolio:
- MaterialApp: Widget utama yang memberikan konfigurasi dasar dalam aplikasi material design.
- Scaffold: Menyediakan struktur dasar sebuah halaman.
- AppBar: Menampilkan header atau judul halaman.
- SingleChildScrollView: Membuat halaman digulir ketika kontennya melebihi ukuran layar.
- Column: Membuat widget secara vertikal.
- GridView.count: Menampilkan kumpulan widget dalam bentuk grid dengan jumlah kolom tertentu.
- Container: Membungkus widget dan mengatur ukuran dan jarak (dekorasi).
- Text: Menampilkan teks.
- Icon: Menampilkan ikon.
- InkWell: Memberikan interaksi ketika pengguna menekan sebuah widget.
- Card: Konten yang di tampilkan dalam bentuk kartu.
- SnackBar: Menampilkan pesan 'sementara' di bawah layar.

3. MaterialApp adalah widget yang menyediakan konfigurasi dasar aplikasi dengan material design. MaterialApp digunakan sebagai root untuk widget mengatur kebutuhan aplikasi, seperti tema, navigasi dan halaman utama.

4. StatelessWidget adalah widget yang tidak memiliki state yang dapat berubah selama widget digunakan penggunaan (statis), sedangkan StatefullWidget adalah widget yang memiliki state yang dapat berubah selama aplikasi berjalan penggunaan memperbarui tampilan.

5. BuildContext adalah pengagambaran lokasi widget dalam widget tree, BuildContext memiliki peran penting untuk widget dapat mengakses informasi dari widget lain yang memiliki hirerarki di atasnya.

6. HotReload bisa menerapkan perubahan kode ke aplikasi yang masih/sedang berjalan, sedangkan HotRestart harus memulai ulang dan menghapus state yang sedang berjalan atau running, tapi tidak tidak fullrestart atau kompilasi ulang. Full restart digunakan ketika perubahan tidak bisa digunakan melalui HotReload atau HotRestart.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
