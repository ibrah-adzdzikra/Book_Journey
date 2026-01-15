# 📘 Book Journey

Aplikasi manajemen bacaan pribadi berbasis Flutter yang membantu pengguna mencatat, mengelola, dan melacak buku-buku yang sedang dibaca, sudah selesai, atau ingin dibaca. Dilengkapi fitur cuaca real-time berdasarkan lokasi dan daftar toko buku terdekat di Jakarta!

Dibuat sebagai tugas akhir mata kuliah **Pemrograman Mobile (KBPR303)** – Universitas Ary Ginanjar.

---

## 👥 Anggota Tim
- **Muhammad Ibrah Adz-dzikra** — 2310120010  
- **Ghifari Alif Auladi** — 2310130006  

Prodi Ilmu Komputer  
Universitas Ary Ginanjar

---

## ✨ Fitur Utama
- ✅ **Manajemen Buku Lokal**: Tambah, lihat, dan hapus buku dengan status: *Reading / Finished / To Read*
- ☀️ **Cuaca Real-Time**: Menampilkan suhu saat ini berdasarkan lokasi GPS pengguna
- 📍 **Toko Buku Terdekat**: Daftar toko buku populer di Jakarta + navigasi langsung ke Google Maps
- 🔒 **Login Sederhana**: Autentikasi dummy (`user` / `123`)
- 🌙 **Dark/Light Mode**: Tema UI yang dapat disesuaikan & disimpan secara persisten
- 💾 **Penyimpanan Offline**: Data buku disimpan di SQLite, preferensi tema & login di `SharedPreferences`

---

## 🛠️ Teknologi yang Digunakan
- **Framework**: [Flutter](https://flutter.dev) (Dart)
- **State Management**: [Provider](https://pub.dev/packages/provider)
- **Database Lokal**: [sqflite](https://pub.dev/packages/sqflite) (SQLite)
- **Penyimpanan Persisten**: [shared_preferences](https://pub.dev/packages/shared_preferences)
- **API Eksternal**: [Open-Meteo Weather API](https://open-meteo.com/)
- **Lokasi**: [geolocator](https://pub.dev/packages/geolocator)
- **Navigasi**: Named Routes + Bottom Navigation Bar
- **Desain**: Material 3, responsif, dark/light mode

---

## 📱 Tampilan Aplikasi
*(Opsional: tambahkan screenshot di sini setelah deploy)*  
Contoh alur:
1. Login → masuk ke halaman utama  
2. Tab **My Books**: kelola koleksi buku  
3. Tab **Explore**: cek cuaca & eksplor toko buku

---

## ▶️ Cara Menjalankan
1. Clone repositori ini:
   ```bash
   git clone https://github.com/namakamu/book_journey.git