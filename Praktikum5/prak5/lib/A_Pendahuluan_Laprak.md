# A. Pendahuluan

## Konteks Topik

Dalam perkembangan teknologi informasi yang semakin pesat, aplikasi mobile menjadi bagian integral dari kehidupan masyarakat modern. Penggunaan aplikasi mobile tidak hanya terbatas pada penggunaan pribadi, melainkan telah menjadi kebutuhan sehari-hari untuk berbagai aspek kehidupan, termasuk pengelolaan keuangan pribadi. Namun, pengembangan aplikasi mobile yang baik memerlukan perhatian khusus terhadap arsitektur navigasi agar aplikasi tetap terorganisir, mudah dipelihara, dan dapat diskalakan dengan baik.

Salah satu tantangan utama dalam pengembangan aplikasi mobile berbasis Flutter adalah bagaimana mengelola navigasi antar halaman secara terpusat dan terstruktur. Seiring dengan bertambahnya fitur dan layar dalam suatu aplikasi, navigasi yang tidak teratur dapat menyebabkan kode yang sulit dibaca, sulit dimodifikasi, dan rentan terhadap kesalahan (spaghetti code). Oleh karena itu, pemahaman dan penerapan teknik navigasi yang tepat menjadi sangat penting dalam setiap proyek pengembangan aplikasi mobile.

## Masalah/ Kebutuhan

Pengelolaan keuangan pribadi menjadi semakin penting di era digital saat ini. Aplikasi yang dirancang untuk membantu pengguna mengelola transaksi, melihat saldo, serta riwayat keuangan memerlukan antarmuka yang intuitif dan navigasi yang mudah digunakan. Namun, banyak aplikasi yang masih menggunakan navigasi langsung dengan `Navigator.push()` yang bersifat imperatif, sehingga mempersulit pengelolaan kode ketika aplikasi berkembang.

Selain itu, penggunaan BottomNavigationBar sebagai menu navigasi utama di bagian bawah layar telah menjadi standar di hampir semua aplikasi modern. Namun, implementasi BottomNavigationBar yang tepat memerlukan struktur yang tepat agar dapat mengelola tampilan antar halaman dengan baik tanpa menyebabkan kebingungan pengguna.

## Metode/ Teknologi yang Digunakan

Untuk mengatasi masalah tersebut, praktikum ini menggunakan pendekatan navigasi berbasis **Named Routes** pada framework Flutter. Dengan teknik ini, setiap halaman dalam aplikasi diberikan nama rute yang terdefinisi, sehingga memungkinkan navigasi yang lebih terpusat dan mudah dimodifikasi. Selain itu, penggunaan **BottomNavigationBar** sebagai menu navigasi bawah menjadi salah satu implementasi terbaik untuk aplikasi mobile yang memiliki beberapa halaman utama.

## Penerapan Umum

Penerapan arsitektur navigasi berbasis Named Routes dan BottomNavigationBar menjadi sangat umum dalam pengembangan aplikasi mobile modern. Teknik ini telah digunakan secara luas dalam berbagai aplikasi di Play Store dan App Store, termasuk aplikasi keuangan, media sosial, e-commerce, dan lainnya. Penerapan yang baik dari kedua teknik ini memungkinkan pengembang untuk membangun aplikasi yang lebih terstruktur, lebih mudah dipelihara, dan lebih skalabel.

## Konteks Praktikum

Praktikum ini dilakukan sebagai bagian dari mata kuliah Aplikasi Mobile menggunakan framework Flutter. Melalui praktikum ini, mahasiswa diharapkan dapat memahami dan menerapkan teknik navigasi berbasis Named Routes serta implementasi BottomNavigationBar dalam membangun aplikasi mobile. Praktikum ini juga menjadi dasar untuk mengembangkan aplikasi keuangan sederhana yang mengintegrasikan beberapa halaman utama dalam satu aplikasi.

---

**Sumber yang digunakan:**
- Modul Praktikum V: Arsitektur Navigasi - Named Routes & Bottom Navigation Bar
- Source code aplikasi Expense Tracker Final yang telah dikembangkan