import 'package:flutter/material.dart';
import 'package:katalog_perpustakaan/screens/main_page.dart';

void main() {
  runApp(const KatalogBukuApp());
}

class KatalogBukuApp extends StatelessWidget {
  const KatalogBukuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Katalog Buku Digital',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Arial',
        scaffoldBackgroundColor: const Color(0xFFFFFEFA),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFFC928),
        ),
      ),
      home: const MainPage(),
    );
  }
}