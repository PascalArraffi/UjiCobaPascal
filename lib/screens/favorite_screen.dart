
import 'package:flutter/material.dart';
import 'package:katalog_perpustakaan/constants/warna.dart';
import 'package:katalog_perpustakaan/data/buku_data.dart';
import 'package:katalog_perpustakaan/models/buku.dart';

class FavoriteScreen extends StatefulWidget {
  final void Function(Buku buku) onBukaDetail;
  final void Function(Buku buku) onHapusFavorit;

  const FavoriteScreen({
    super.key,
    required this.onBukaDetail,
    required this.onHapusFavorit,
  });

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final TextEditingController searchController =
      TextEditingController();

  String kataPencarian = '';

  List<Buku> get bukuFavorit {
    return daftarBuku.where((buku) {
      return buku.favorit &&
          buku.judul.toLowerCase().contains(
            kataPencarian.toLowerCase(),
          );
    }).toList();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hasilBuku = bukuFavorit;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(18, 15, 18, 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Judul halaman
          const Text(
            'BUKU FAVORIT',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: cokelat,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            'Kumpulan buku yang kamu sukai dan simpan.',
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey,
            ),
          ),

          const SizedBox(height: 20),

          // Search buku favorit
          TextField(
            controller: searchController,
            onChanged: (value) {
              setState(() {
                kataPencarian = value;
              });
            },
            decoration: InputDecoration(
              hintText: 'Cari nama buku favorit...',
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

          // Jumlah buku favorit
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'DAFTAR FAVORIT',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  color: cokelat,
                ),
              ),
              Text(
                '${hasilBuku.length} Buku',
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          // Kondisi jika daftar kosong
          if (hasilBuku.isEmpty)
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 45,
                ),
                child: Column(
                  children: [
                    Icon(
                      kataPencarian.isNotEmpty
                          ? Icons.search_off
                          : Icons.star_border_rounded,
                      size: 75,
                      color: Colors.grey.shade400,
                    ),
                    const SizedBox(height: 14),
                    Text(
                      kataPencarian.isNotEmpty
                          ? 'Buku tidak ditemukan.'
                          : 'Belum ada buku favorit.',
                      style: const TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      kataPencarian.isNotEmpty
                          ? 'Coba gunakan nama buku yang berbeda.'
                          : 'Tambahkan buku melalui ikon bintang di halaman detail.',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            )

          // Menampilkan daftar buku favorit
          else
            ...hasilBuku.map(
              (buku) => Container(
                margin: const EdgeInsets.only(bottom: 14),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: const Color(0xFFF0E9DC),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: cokelat.withValues(alpha: 0.05),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Cover buku
                    InkWell(
                      onTap: () => widget.onBukaDetail(buku),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          buku.gambar,
                          width: 85,
                          height: 112,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) {
                            return Container(
                              width: 85,
                              height: 112,
                              color: const Color(0xFFFFF3C4),
                              child: const Icon(
                                Icons.menu_book,
                                color: cokelat,
                                size: 35,
                              ),
                            );
                          },
                        ),
                      ),
                    ),

                    const SizedBox(width: 13),

                    // Informasi buku
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            buku.judul,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 14,
                              height: 1.3,
                              fontWeight: FontWeight.w800,
                              color: cokelat,
                            ),
                          ),

                          const SizedBox(height: 6),

                          Text(
                            buku.penulis,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 11,
                              color: Color(0xFF77716A),
                            ),
                          ),

                          const SizedBox(height: 8),

                          Text(
                            buku.kategori,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 10,
                              color: cokelat,
                              fontWeight: FontWeight.w600,
                            ),
                          ),

                          const SizedBox(height: 12),

                          Row(
                            children: [
                              // Buka detail buku
                              Expanded(
                                child: OutlinedButton(
                                  onPressed: () {
                                    widget.onBukaDetail(buku);
                                  },
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: cokelat,
                                    side: BorderSide(
                                      color: cokelat.withValues(
                                        alpha: 0.3,
                                      ),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                    ),
                                    minimumSize: const Size(0, 34),
                                  ),
                                  child: const Text(
                                    'Detail',
                                    style: TextStyle(fontSize: 11),
                                  ),
                                ),
                              ),

                              const SizedBox(width: 8),

                              // Hapus dari favorit
                              IconButton(
                                tooltip: 'Hapus dari Favorit',
                                onPressed: () {
                                  widget.onHapusFavorit(buku);
                                },
                                icon: const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
