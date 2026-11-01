
import 'package:flutter/material.dart';
import 'package:katalog_perpustakaan/constants/warna.dart';
import 'package:katalog_perpustakaan/data/buku_data.dart';
import 'package:katalog_perpustakaan/models/buku.dart';
import 'package:katalog_perpustakaan/screens/borrow_screen.dart';
import 'package:katalog_perpustakaan/screens/detail_screen.dart';
import 'package:katalog_perpustakaan/screens/favorite_screen.dart';
import 'package:katalog_perpustakaan/screens/home_screen.dart';
import 'package:katalog_perpustakaan/screens/personal_screen.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int halamanAktif = 0;

  // Mengubah status peminjaman buku
  void ubahPeminjaman(Buku buku) {
    setState(() {
      buku.dipinjam = !buku.dipinjam;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          buku.dipinjam
              ? '${buku.judul} berhasil dipinjam.'
              : '${buku.judul} berhasil dikembalikan.',
        ),
        backgroundColor: cokelat,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // Membuka halaman detail buku
  void bukaDetailBuku(Buku buku) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DetailBukuPage(
          buku: buku,
          saatPinjam: () => ubahPeminjaman(buku),
        ),
      ),
    ).then((_) {
      if (mounted) {
        setState(() {});
      }
    });
  }

  // Menghapus buku dari daftar favorit
  void hapusFavorit(Buku buku) {
    setState(() {
      buku.favorit = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${buku.judul} berhasil dihapus dari Favorit.',
        ),
        backgroundColor: cokelat,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  // Berpindah antarhalaman navigasi
  void pindahHalaman(int index) {
    setState(() {
      halamanAktif = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final judulHalaman = [
      'ENJOY READING',
      'BUKU PINJAMAN',
      'PERSONAL',
      'FAVORITE',
    ];

    return Scaffold(
      backgroundColor: latar,

      // AppBar
      appBar: AppBar(
        backgroundColor: latar,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        title: Text(
          judulHalaman[halamanAktif],
          style: const TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.w900,
            fontStyle: FontStyle.italic,
            color: cokelat,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Belum ada notifikasi.'),
                ),
              );
            },
            icon: const Icon(
              Icons.notifications_none,
              color: cokelat,
            ),
          ),
        ],
      ),

      // Konten halaman
      body: SafeArea(
        child: IndexedStack(
          index: halamanAktif,
          children: [
            HomeScreen(
              onBukaDetail: bukaDetailBuku,
              onUbahPinjam: ubahPeminjaman,
              onPindahHalaman: pindahHalaman,
            ),

            BorrowScreen(
              onBukaDetail: bukaDetailBuku,
              onUbahPinjam: ubahPeminjaman,
              onCariBuku: () => pindahHalaman(0),
            ),

            const PersonalScreen(),

            FavoriteScreen(
              onBukaDetail: bukaDetailBuku,
              onHapusFavorit: hapusFavorit,
            ),
          ],
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: halamanAktif,
        onTap: pindahHalaman,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: cokelat,
        unselectedItemColor: Colors.grey,
        selectedFontSize: 11,
        unselectedFontSize: 10,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.book_outlined),
            activeIcon: Icon(Icons.book),
            label: 'Borrow',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Personal',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.star_border),
            activeIcon: Icon(Icons.star),
            label: 'Favorite',
          ),
        ],
      ),
    );
  }
}
