import 'package:flutter/material.dart';
import 'package:katalog_perpustakaan/constants/warna.dart';
import 'package:katalog_perpustakaan/data/buku_data.dart';
import 'package:katalog_perpustakaan/models/buku.dart';
import 'package:katalog_perpustakaan/widgets/kartu_buku.dart';

class BorrowScreen extends StatelessWidget {
  final void Function(Buku buku) onBukaDetail;
  final void Function(Buku buku) onUbahPinjam;
  final VoidCallback onCariBuku;

  const BorrowScreen({
    super.key,
    required this.onBukaDetail,
    required this.onUbahPinjam,
    required this.onCariBuku,
  });

  @override
  Widget build(BuildContext context) {
    final bukuDipinjam =
        daftarBuku.where((buku) => buku.dipinjam).toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: kuning,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Buku yang Kamu Pinjam',
                  style: TextStyle(
                    color: cokelat,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${bukuDipinjam.length} buku sedang dipinjam',
                  style: const TextStyle(
                    color: cokelat,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'DAFTAR PEMINJAMAN',
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 17,
              color: cokelat,
            ),
          ),
          const SizedBox(height: 12),
          if (bukuDipinjam.isEmpty)
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 35),
                child: Column(
                  children: [
                    const Icon(
                      Icons.menu_book_outlined,
                      size: 65,
                      color: Colors.grey,
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Belum ada buku yang dipinjam.',
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 15),
                    ElevatedButton(
                      onPressed: onCariBuku,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kuning,
                        foregroundColor: cokelat,
                      ),
                      child: const Text('Cari Buku'),
                    ),
                  ],
                ),
              ),
            )
          else
            ...bukuDipinjam.map(
              (buku) => KartuBuku(
                buku: buku,
                onTap: () => onBukaDetail(buku),
                onPinjam: () => onUbahPinjam(buku),
              ),
            ),
        ],
      ),
    );
  }
}