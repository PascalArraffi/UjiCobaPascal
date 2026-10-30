import 'package:flutter/material.dart';
import 'package:katalog_perpustakaan/constants/warna.dart';
import 'package:katalog_perpustakaan/models/buku.dart';

class DetailBukuPage extends StatefulWidget {
  final Buku buku;
  final VoidCallback saatPinjam;

  const DetailBukuPage({
    super.key,
    required this.buku,
    required this.saatPinjam,
  });

  @override
  State<DetailBukuPage> createState() => _DetailBukuPageState();
}

class _DetailBukuPageState extends State<DetailBukuPage> {
  @override
  Widget build(BuildContext context) {
    final buku = widget.buku;

    return Scaffold(
      backgroundColor: latar,
      appBar: AppBar(
        backgroundColor: latar,
        foregroundColor: cokelat,
        title: const Text(
          'Detail Buku',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF5D6),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    buku.gambar,
                    height: 260,
                    width: 190,
                    fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) {
                      return const SizedBox(
                        height: 260,
                        width: 190,
                        child: Icon(
                          Icons.menu_book,
                          size: 80,
                          color: cokelat,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 25),
            Text(
              buku.judul,
              style: const TextStyle(
                color: cokelat,
                fontSize: 25,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Penulis: ${buku.penulis}',
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 7,
              ),
              decoration: BoxDecoration(
                color: kuning.withValues(alpha: 0.35),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                buku.kategori,
                style: const TextStyle(
                  color: cokelat,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 25),
            const Text(
              'Deskripsi Buku',
              style: TextStyle(
                color: cokelat,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              buku.deskripsi,
              style: const TextStyle(
                color: Color(0xFF555555),
                fontSize: 14,
                height: 1.7,
              ),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 22),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(13),
              decoration: BoxDecoration(
                color: buku.dipinjam
                    ? const Color(0xFFFFE8E8)
                    : const Color(0xFFE8F5E9),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(
                    buku.dipinjam
                        ? Icons.bookmark
                        : Icons.check_circle_outline,
                    color: buku.dipinjam ? Colors.red : Colors.green,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      buku.dipinjam
                          ? 'Buku sedang dipinjam'
                          : 'Buku tersedia untuk dipinjam',
                      style: TextStyle(
                        color: buku.dipinjam
                            ? Colors.red.shade800
                            : Colors.green.shade800,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton.icon(
                onPressed: () {
                  widget.saatPinjam();
                  setState(() {});
                },
                icon: Icon(
                  buku.dipinjam
                      ? Icons.assignment_return
                      : Icons.bookmark_add_outlined,
                ),
                label: Text(
                  buku.dipinjam ? 'Kembalikan Buku' : 'Pinjam Buku',
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: kuning,
                  foregroundColor: cokelat,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}