# myportofolio_mobile
A new Flutter project.

### Tugas 8

1. - Navigator.push() : membuka page baru tanpa menghapus page sebelumnya.
- Navigator.pushReplacement() : membuka page baru dan menggantikan/menghapus page sebelumnya.
- Navigator.pop() : close page saat ini dan kembali ke page sebelumnya.
- Formulir dari kartu aksi dibuka dengan menggunakan Navigator.push() sedangkan untuk opsi home menggunakan Navigator.pushReplacement() untuk pengguna kembali ke page utama.

2. Scaffold membuat struktur dasar sebuh page, AppBar menampilkan bagian atas pada page, dan Drawer membuat menu navigasi. Ketiganya mengkoordinasikan tampilan serta navigasi untuk tetap kosisten. Contoh, page add experience itu menggunakan AppBar serta Drawer.

3. Kegunaan tata letak atau padding untuk mengatur jarak antar input sehingga formulirnya lebih rapi serta mudah di baca. Collumn mengatur input secara vertikal, sedangkan Singlechildscrollview untuk pengguna bisa menggulir layar page ketika layar tidak cukup besar.

4. GlobalKey<FromState> untuk bisa mengakses serta mengelolo formulir. Validate() running atau menjalankan validasi saat button di tekan. Contoh, saat input nama perusahaan kosong atau hanya spasi maka akan ditolak karena wajib di isi

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
