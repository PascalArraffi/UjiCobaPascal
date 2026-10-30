import 'package:flutter/material.dart';
import 'package:katalog_perpustakaan/constants/warna.dart';
import 'package:katalog_perpustakaan/data/buku_data.dart';

class PersonalScreen extends StatelessWidget {
  const PersonalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final jumlahPinjaman =
        daftarBuku.where((buku) => buku.dipinjam).length;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const SizedBox(height: 20),
          Container(
            width: 100,
            height: 100,
            decoration: const BoxDecoration(
              color: kuning,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.person,
              size: 60,
              color: cokelat,
            ),
          ),
          const SizedBox(height: 15),
          const Text(
            'Pengguna Katalog Buku',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: cokelat,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Selamat datang di Enjoy Reading!',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 25),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.bookmark_added_outlined,
                  color: cokelat,
                  size: 35,
                ),
                const SizedBox(width: 15),
                const Expanded(
                  child: Text(
                    'Total Buku Dipinjam',
                    style: TextStyle(
                      color: cokelat,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Text(
                  '$jumlahPinjaman',
                  style: const TextStyle(
                    color: cokelat,
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          ListTile(
            tileColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            leading: const Icon(
              Icons.info_outline,
              color: cokelat,
            ),
            title: const Text(
              'Tentang Aplikasi',
              style: TextStyle(color: cokelat),
            ),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              showAboutDialog(
                context: context,
                applicationName: 'Katalog Buku Digital',
                applicationVersion: '1.0.0',
                applicationIcon: const Icon(
                  Icons.menu_book,
                  color: cokelat,
                  size: 35,
                ),
                children: const [
                  Text(
                    'Aplikasi untuk melihat katalog buku, '
                    'mencari buku, melihat detail, dan '
                    'mengelola peminjaman buku.',
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}