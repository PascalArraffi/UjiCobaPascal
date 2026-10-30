import 'package:flutter/material.dart';
import 'package:katalog_perpustakaan/constants/warna.dart';
import 'package:katalog_perpustakaan/data/buku_data.dart';

class KategoriList extends StatelessWidget {
  final String kategoriAktif;
  final void Function(String nama) onPilih;

  const KategoriList({
    super.key,
    required this.kategoriAktif,
    required this.onPilih,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 94,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: daftarKategori.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final kategori = daftarKategori[index];
          final nama = kategori['nama'] as String;
          final ikon = kategori['ikon'] as IconData;
          final terpilih = kategoriAktif == nama;

          return InkWell(
            onTap: () => onPilih(nama),
            borderRadius: BorderRadius.circular(17),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 112,
              padding: const EdgeInsets.all(9),
              decoration: BoxDecoration(
                color: terpilih ? kuning : const Color(0xFFFFF7E1),
                borderRadius: BorderRadius.circular(17),
                border: Border.all(
                  color: terpilih ? cokelat : const Color(0xFFF0E7D2),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    ikon,
                    color: cokelat,
                    size: 25,
                  ),
                  const SizedBox(height: 7),
                  Text(
                    nama,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: cokelat,
                      fontSize: 10,
                      height: 1.2,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}