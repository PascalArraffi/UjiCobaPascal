import 'package:flutter/material.dart';
import 'package:katalog_perpustakaan/constants/warna.dart';

class BannerUtama extends StatelessWidget {
  const BannerUtama({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFFFFE17B),
            Color(0xFFFFC928),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(23),
        boxShadow: [
          BoxShadow(
            color: kuning.withValues(alpha: 0.22),
            blurRadius: 14,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          const Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Child Picture Book',
                  style: TextStyle(
                    fontSize: 20,
                    height: 1.2,
                    fontWeight: FontWeight.w900,
                    color: cokelat,
                  ),
                ),
                SizedBox(height: 9),
                Text(
                  'Temukan cerita favoritmu',
                  style: TextStyle(
                    fontSize: 12,
                    height: 1.5,
                    color: cokelat,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 2,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                'images/banner.jpeg',
                height: 130,
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) {
                  return const SizedBox(
                    height: 130,
                    child: Icon(
                      Icons.menu_book_rounded,
                      size: 60,
                      color: cokelat,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}