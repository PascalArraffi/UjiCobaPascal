import 'package:flutter/material.dart';
import 'package:katalog_perpustakaan/models/buku.dart';

var daftarBuku = [
  Buku(
    judul: 'Jack and the Beanstalk',
    penulis: 'Benjamin Tabart',
    kategori: 'Petualangan Dan Fantasi',
    gambar: 'images/Buku1.jpeg',
    deskripsi:
        'Jack and the Beanstalk adalah cerita petualangan tentang Jack yang menemukan kacang ajaib dan mengalami petualangan luar biasa di atas awan.',
  ),
  Buku(
    judul: 'Intermezzo',
    penulis: 'Sally Rooney',
    kategori: 'Misteri & Thriller Psikologis',
    gambar: 'images/Buku2.jpeg',
    deskripsi:
        'Intermezzo merupakan novel karya Sally Rooney yang mengisahkan kehidupan dua saudara, hubungan mereka, dan perjalanan menghadapi kehilangan serta perubahan hidup.',
  ),
  Buku(
    judul: 'Laut Bercerita',
    penulis: 'Leila S. Chudori',
    kategori: 'Fiksi',
    gambar: 'images/Buku3.jpeg',
    deskripsi:
        'Laut Bercerita adalah novel karya Leila S. Chudori yang mengangkat kisah persahabatan, keluarga, perjuangan, dan kehilangan dalam latar sejarah Indonesia.',
  ),
  Buku(
    judul: 'Sophie World',
    penulis: 'Jostein Gaarder',
    kategori: 'Fiksi',
    gambar: 'images/Buku4.jpeg',
    deskripsi:
        'Sophie World adalah cerita tentang Sophie yang menerima pesan-pesan misterius dan mulai mengenal berbagai pemikiran serta pertanyaan mendasar tentang kehidupan.',
  ),
    Buku(
    judul: 'Harry Potter dan Batu Bertuah',
    penulis: 'J.K. Rowling',
    kategori: 'Petualangan Dan Fantasi',
    gambar: 'images/Buku5.jpeg',
    deskripsi:
        'Harry Potter dan Batu Bertuah mengisahkan Harry, anak yatim piatu yang mengetahui dirinya seorang penyihir dan mulai bersekolah di Hogwarts, tempat ia menemukan persahabatan serta rahasia besar di balik sekolah itu.',
  ),
  Buku(
    judul: 'The Hobbit',
    penulis: 'J.R.R. Tolkien',
    kategori: 'Petualangan Dan Fantasi',
    gambar: 'images/Buku6.jpeg',
    deskripsi:
        'The Hobbit bercerita tentang Bilbo Baggins, hobbit yang suka hidup tenang, tetapi tiba-tiba ikut dalam perjalanan berbahaya bersama sekelompok kurcaci untuk merebut kembali harta karun mereka dari seekor naga.',
  ),
  Buku(
    judul: 'Gone Girl',
    penulis: 'Gillian Flynn',
    kategori: 'Misteri & Thriller Psikologis',
    gambar: 'images/Buku7.jpeg',
    deskripsi:
        'Gone Girl mengisahkan hilangnya seorang istri pada hari ulang tahun pernikahannya. Suaminya menjadi tersangka utama, dan kebenaran tentang pernikahan mereka terungkap sedikit demi sedikit.',
  ),
  Buku(
    judul: 'The Silent Patient',
    penulis: 'Alex Michaelides',
    kategori: 'Misteri & Thriller Psikologis',
    gambar: 'images/Buku8.jpeg',
    deskripsi:
        'The Silent Patient bercerita tentang seorang pelukis yang diduga membunuh suaminya lalu berhenti berbicara. Seorang psikoterapis berusaha mengungkap alasan di balik diamnya.',
  ),
  Buku(
    judul: 'Bumi Manusia',
    penulis: 'Pramoedya Ananta Toer',
    kategori: 'Fiksi',
    gambar: 'images/Buku9.jpeg',
    deskripsi:
        'Bumi Manusia mengisahkan Minke, pemuda pribumi terpelajar pada masa kolonial Hindia Belanda, yang jatuh cinta dan menghadapi ketidakadilan terhadap bangsanya.',
  ),
];

final List<Map<String, dynamic>> daftarKategori = [
  {'nama': 'Semua', 'ikon': Icons.auto_stories},
  {
    'nama': 'Petualangan Dan Fantasi',
    'ikon': Icons.explore_outlined,
  },
  {
    'nama': 'Misteri & Thriller Psikologis',
    'ikon': Icons.psychology_outlined,
  },
  {'nama': 'Fiksi', 'ikon': Icons.menu_book_outlined},
];