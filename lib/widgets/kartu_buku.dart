import 'package:flutter/material.dart';
import 'package:katalog_perpustakaan/constants/warna.dart';
import 'package:katalog_perpustakaan/models/buku.dart';

class KartuBuku extends StatelessWidget {
  final Buku buku;
  final VoidCallback onTap;
  final VoidCallback? onPinjam;

  const KartuBuku({
    super.key,
    required this.buku,
    required this.onTap,
     this.onPinjam,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
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
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                buku.gambar,
                width: 88,
                height: 116,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) {
                  return Container(
                    width: 88,
                    height: 116,
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
            const SizedBox(width: 13),
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
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF5D6),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      buku.kategori,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 10,
                        height: 1.2,
                        fontWeight: FontWeight.w600,
                        color: cokelat,
                      ),
                    ),
                  ),
                                    if (onPinjam != null) ...[
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerRight,
                      child: SizedBox(
                        height: 34,
                        child: ElevatedButton(
                          onPressed: onPinjam,
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                buku.dipinjam ? cokelat : kuning,
                            foregroundColor:
                                buku.dipinjam ? Colors.white : cokelat,
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 13,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            buku.dipinjam ? 'Return' : 'Borrow it',
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}