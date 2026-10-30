import 'package:flutter/material.dart';
import 'package:katalog_perpustakaan/constants/warna.dart';
import 'package:katalog_perpustakaan/data/buku_data.dart';
import 'package:katalog_perpustakaan/models/buku.dart';
import 'package:katalog_perpustakaan/widgets/kartu_buku.dart';
import 'package:katalog_perpustakaan/widgets/kategori_list.dart';

class DaftarBukuScreen extends StatefulWidget {
  const DaftarBukuScreen({super.key});

  @override
  State<DaftarBukuScreen> createState() => _DaftarBukuScreenState();
}

class _DaftarBukuScreenState extends State<DaftarBukuScreen> {
  String kategoriAktif = 'Semua';

  List<Buku> get bukuTampil {
    if (kategoriAktif == 'Semua') return daftarBuku;
    return daftarBuku
        .where((buku) => buku.kategori == kategoriAktif)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final hasilBuku = bukuTampil;

    return Scaffold(
      backgroundColor: latar,
      appBar: AppBar(
        backgroundColor: latar,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'DAFTAR BUKU',
          style: TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.w900,
            fontStyle: FontStyle.italic,
            color: cokelat,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(18, 8, 18, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Pilihan kategori
              const Text(
                'CATEGORIES',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 17,
                  color: cokelat,
                ),
              ),
              const SizedBox(height: 13),
              KategoriList(
                kategoriAktif: kategoriAktif,
                onPilih: (nama) {
                  setState(() {
                    kategoriAktif = nama;
                  });
                },
              ),
              const SizedBox(height: 25),

              // Judul daftar + jumlah buku
              Row(
                children: [
                  Container(
                    width: 5,
                    height: 24,
                    decoration: BoxDecoration(
                      color: kuning,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  const SizedBox(width: 9),
                  const Expanded(
                    child: Text(
                      'SEMUA BUKU',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 17,
                        color: cokelat,
                      ),
                    ),
                  ),
                  Text(
                    '${hasilBuku.length} buku',
                    style: const TextStyle(
                      fontSize: 11,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Daftar kartu buku
              if (hasilBuku.isEmpty)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 35),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: const Column(
                    children: [
                      Icon(
                        Icons.search_off_rounded,
                        size: 45,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Belum ada buku di kategori ini.',
                        style: TextStyle(
                          color: cokelat,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                )
              else
                ...hasilBuku.map(
                  (buku) => KartuBuku(
                    buku: buku,
                    onTap: () {
                      // Menuju halaman detail (bagian anggota lain)
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}