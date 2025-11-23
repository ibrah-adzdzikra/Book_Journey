# Book Journey – Aplikasi Pelacak Buku

## Anggota Tim
- Nama: [Muhammad Ibrah Adzdzikra]  
  NIM: [2310120010]

## Pembagian Tugas
- Semua fitur dikerjakan sendiri oleh [ibrah].

## Penjelasan Fitur

### 🔐 Login Page
- Menggunakan username `user` dan password `123` sebagai data dummy.
- Status login disimpan di `SharedPreferences`.
- Jika belum login, tidak bisa mengakses halaman utama.

### 🌓 Light/Dark Mode
- Tema disimpan di `SharedPreferences`.
- Pengguna bisa toggle antara light/dark mode melalui ikon di pojok kanan atas.
- Perubahan langsung diterapkan tanpa restart aplikasi.

### 🗃️ SQLite & SharedPreferences
- **SQLite**: Menyimpan data buku (judul, penulis, status). Semua operasi CRUD dilakukan melalui `DatabaseHelper`.
- **SharedPreferences**: Digunakan untuk menyimpan:
  - Status login (`isLoggedIn`)
  - Preferensi tema (`isDarkMode`)

### 📋 List In-Memory untuk UI
- Data dari SQLite dimuat ke `List<Book>` saat halaman utama dibuka.
- Semua tampilan UI (seperti `ListView`) menggunakan list ini.
- Setiap operasi (tambah/hapus) memperbarui list **dan** database secara bersamaan.

### 📱 Cara Menggunakan Aplikasi
1. Login dengan username `user` dan password `123`.
2. Di halaman utama, lihat daftar buku.
3. Tekan tombol **+** untuk menambah buku.
4. Geser ke kiri atau tekan ikon **hapus** untuk menghapus.
5. Ganti tema dengan ikon matahari/bulan di pojok kanan atas.
6. Logout dengan ikon **logout**.

## Screenshot

1. `login_page.jpg` – Halaman login
2. `home_light.jpg` – Home page dalam light mode
3. `home_dark.jpg` – Home page dalam dark mode
4. `add_book.jpg` – Halaman tambah buku
5. `after_theme_change.jpg` – Tampilan setelah ganti tema

> **Catatan**: Pastikan semua screenshot ada di repo GitHub sebelum dikumpulkan.