import 'package:flutter/material.dart';
import 'package:katalog_perpustakaan/constants/warna.dart';

class MenuItem extends StatelessWidget {
  final IconData ikon;
  final String label;
  final VoidCallback onTap;

  const MenuItem({
    super.key,
    required this.ikon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 3,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: const Color(0xFFF0E9DC),
          ),
        ),
        child: Column(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: const Color(0xFFFFF3C4),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                ikon,
                size: 23,
                color: cokelat,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: cokelat,
              ),
            ),
          ],
        ),
      ),
    );
  }
}