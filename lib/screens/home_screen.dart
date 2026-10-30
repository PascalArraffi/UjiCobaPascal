import 'package:flutter/material.dart';
import 'package:katalog_perpustakaan/constants/warna.dart';
import 'package:katalog_perpustakaan/data/buku_data.dart';
import 'package:katalog_perpustakaan/models/buku.dart';
import 'package:katalog_perpustakaan/widgets/banner_utama.dart';
import 'package:katalog_perpustakaan/widgets/kartu_buku.dart';
import 'package:katalog_perpustakaan/widgets/kategori_list.dart';
import 'package:katalog_perpustakaan/widgets/menu_item.dart';

class HomeScreen extends StatefulWidget {
  final void Function(Buku buku) onBukaDetail;
  final void Function(Buku buku) onUbahPinjam;
  final void Function(int index) onPindahHalaman;

  const HomeScreen({
    super.key,
    required this.onBukaDetail,
    required this.onUbahPinjam,
    required this.onPindahHalaman,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String kataPencarian = '';
  String kategoriAktif = 'Semua';

  final TextEditingController searchController =
      TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  List<Buku> get bukuTampil {
    return daftarBuku.where((buku) {
      final kata = kataPencarian.toLowerCase();

      final cocokPencarian =
          buku.judul.toLowerCase().contains(kata) ||
          buku.penulis.toLowerCase().contains(kata) ||
          buku.kategori.toLowerCase().contains(kata);

      final cocokKategori =
          kategoriAktif == 'Semua' || buku.kategori == kategoriAktif;

      return cocokPencarian && cocokKategori;
    }).toList();
  }

  void pilihKategori(String kategori) {
    setState(() {
      kategoriAktif = kategori;
    });
  }

  @override
  Widget build(BuildContext context) {
    final hasilBuku = bukuTampil;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(18, 8, 18, 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Kolom pencarian
          TextField(
            controller: searchController,
            onChanged: (value) {
              setState(() {
                kataPencarian = value;
              });
            },
            decoration: InputDecoration(
              hintText: 'Search for books',
              hintStyle: const TextStyle(fontSize: 12),
              prefixIcon: const Icon(
                Icons.search,
                color: cokelat,
              ),
              suffixIcon: kataPencarian.isNotEmpty
                  ? IconButton(
                      onPressed: () {
                        searchController.clear();
                        setState(() {
                          kataPencarian = '';
                        });
                      },
                      icon: const Icon(Icons.close),
                    )
                  : null,
              filled: true,
              fillColor: Colors.white,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 14),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(
                  color: Color(0xFFECE5D7),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(
                  color: Color(0xFFECE5D7),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(
                  color: kuning,
                  width: 2,
                ),
              ),
            ),
          ),
          const SizedBox(height: 22),

          // Banner utama
          const BannerUtama(),
          const SizedBox(height: 25),

          const Text(
            'JELAJAHI KATALOG',
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 16,
              color: cokelat,
            ),
          ),
          const SizedBox(height: 13),

          // Menu cepat
          Row(
            children: [
              Expanded(
                child: MenuItem(
                  ikon: Icons.library_books_outlined,
                  label: 'Book List',
                  onTap: () => pilihKategori('Semua'),
                ),
              ),
              const SizedBox(width: 9),
              Expanded(
                child: MenuItem(
                  ikon: Icons.bookmark_border,
                  label: 'Reading',
                  onTap: () => widget.onPindahHalaman(1),
                ),
              ),
              const SizedBox(width: 9),
              Expanded(
                child: MenuItem(
                  ikon: Icons.explore_outlined,
                  label: 'Space',
                  onTap: () => pilihKategori('Petualangan Dan Fantasi'),
                ),
              ),
              const SizedBox(width: 9),
              Expanded(
                child: MenuItem(
                  ikon: Icons.grid_view_rounded,
                  label: 'More',
                  onTap: () {
                    pilihKategori('Semua');
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Pilih kategori buku di bawah.'),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),

          const SizedBox(height: 27),

          // Kategori
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'CATEGORIES',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 17,
                  color: cokelat,
                ),
              ),
              Text(
                '${daftarKategori.length} kategori',
                style: const TextStyle(
                  fontSize: 11,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          const SizedBox(height: 13),

          KategoriList(
            kategoriAktif: kategoriAktif,
            onPilih: pilihKategori,
          ),

          const SizedBox(height: 25),

          // Rekomendasi
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
                  'RECOMMEND',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 17,
                    color: cokelat,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  searchController.clear();
                  setState(() {
                    kataPencarian = '';
                    kategoriAktif = 'Semua';
                  });
                },
                child: const Text(
                  'See all ›',
                  style: TextStyle(
                    color: cokelat,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

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
                    'Buku tidak ditemukan.',
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
                onTap: () => widget.onBukaDetail(buku),
                onPinjam: () => widget.onUbahPinjam(buku),
              ),
            ),
        ],
      ),
    );
  }
}