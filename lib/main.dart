
import 'package:flutter/material.dart';

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

class Buku {
  final String judul;
  final String penulis;
  final String kategori;
  final String gambar;
  final String deskripsi;
  bool dipinjam;

  Buku({
    required this.judul,
    required this.penulis,
    required this.kategori,
    required this.gambar,
    required this.deskripsi,
    this.dipinjam = false,
  });
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  static const Color kuning = Color(0xFFFFC928);
  static const Color cokelat = Color(0xFF493B27);
  static const Color latar = Color(0xFFFFFEFA);

  int halamanAktif = 0;
  String kataPencarian = '';
  String kategoriAktif = 'Semua';

  final TextEditingController searchController =
      TextEditingController();

  final List<Buku> daftarBuku = [
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

      final cocokKategori = kategoriAktif == 'Semua' ||
          buku.kategori == kategoriAktif;

      if (halamanAktif == 1) {
        return buku.dipinjam && cocokPencarian;
      }

      return cocokPencarian && cocokKategori;
    }).toList();
  }

  void ubahPeminjaman(Buku buku) {
    setState(() {
      buku.dipinjam = !buku.dipinjam;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          buku.dipinjam
              ? '${buku.judul} berhasil dipinjam.'
              : '${buku.judul} berhasil dikembalikan.',
        ),
        backgroundColor: cokelat,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void bukaDetailBuku(Buku buku) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DetailBukuPage(
          buku: buku,
          saatPinjam: () => ubahPeminjaman(buku),
        ),
      ),
    ).then((_) {
      if (mounted) setState(() {});
    });
  }

  void pilihKategori(String kategori) {
    setState(() {
      kategoriAktif = kategori;
      halamanAktif = 0;
    });
  }

  void pindahHalaman(int index) {
    setState(() {
      halamanAktif = index;
      if (index == 2) {
        kataPencarian = '';
        searchController.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: latar,
      appBar: AppBar(
        backgroundColor: latar,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        title: Text(
          halamanAktif == 0
              ? 'ENJOY READING'
              : halamanAktif == 1
                  ? 'BUKU PINJAMAN'
                  : 'PERSONAL',
          style: const TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.w900,
            fontStyle: FontStyle.italic,
            color: cokelat,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Belum ada notifikasi.'),
                ),
              );
            },
            icon: const Icon(
              Icons.notifications_none,
              color: cokelat,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: IndexedStack(
          index: halamanAktif,
          children: [
            halamanBeranda(),
            halamanPinjaman(),
            halamanPersonal(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: halamanAktif,
        onTap: pindahHalaman,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: cokelat,
        unselectedItemColor: Colors.grey,
        selectedFontSize: 11,
        unselectedFontSize: 10,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book_outlined),
            activeIcon: Icon(Icons.book),
            label: 'Borrow',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Personal',
          ),
        ],
      ),
    );
  }

  Widget halamanBeranda() {
    final hasilBuku = bukuTampil;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(18, 8, 18, 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
          Container(
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
          ),

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

          Row(
            children: [
              Expanded(
                child: menu(
                  Icons.library_books_outlined,
                  'Book List',
                  () {
                    setState(() {
                      halamanAktif = 0;
                      kategoriAktif = 'Semua';
                    });
                  },
                ),
              ),
              const SizedBox(width: 9),
              Expanded(
                child: menu(
                  Icons.bookmark_border,
                  'Reading',
                  () => pindahHalaman(1),
                ),
              ),
              const SizedBox(width: 9),
              Expanded(
                child: menu(
                  Icons.explore_outlined,
                  'Space',
                  () => pilihKategori('Petualangan Dan Fantasi'),
                ),
              ),
              const SizedBox(width: 9),
              Expanded(
                child: menu(
                  Icons.grid_view_rounded,
                  'More',
                  () {
                    setState(() {
                      kategoriAktif = 'Semua';
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Pilih kategori buku di bawah.',
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),

          const SizedBox(height: 27),

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

          SizedBox(
            height: 94,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: daftarKategori.length,
              separatorBuilder: (_, __) =>
                  const SizedBox(width: 10),
              itemBuilder: (context, index) {
                final kategori = daftarKategori[index];
                final nama = kategori['nama'] as String;
                final ikon = kategori['ikon'] as IconData;
                final terpilih = kategoriAktif == nama;

                return InkWell(
                  onTap: () => pilihKategori(nama),
                  borderRadius: BorderRadius.circular(17),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 112,
                    padding: const EdgeInsets.all(9),
                    decoration: BoxDecoration(
                      color: terpilih
                          ? kuning
                          : const Color(0xFFFFF7E1),
                      borderRadius: BorderRadius.circular(17),
                      border: Border.all(
                        color: terpilih
                            ? cokelat
                            : const Color(0xFFF0E7D2),
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
          ),

          const SizedBox(height: 25),

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
            ...hasilBuku.map((buku) => kartuBuku(buku)),
        ],
      ),
    );
  }

  Widget kartuBuku(Buku buku) {
    return InkWell(
      onTap: () => bukaDetailBuku(buku),
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
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: SizedBox(
                      height: 34,
                      child: ElevatedButton(
                        onPressed: () => ubahPeminjaman(buku),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              buku.dipinjam ? cokelat : kuning,
                          foregroundColor:
                              buku.dipinjam
                                  ? Colors.white
                                  : cokelat,
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
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget halamanPinjaman() {
    final bukuDipinjam =
        daftarBuku.where((buku) => buku.dipinjam).toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: kuning,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Buku yang Kamu Pinjam',
                  style: TextStyle(
                    color: cokelat,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${bukuDipinjam.length} buku sedang dipinjam',
                  style: const TextStyle(
                    color: cokelat,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'DAFTAR PEMINJAMAN',
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 17,
              color: cokelat,
            ),
          ),
          const SizedBox(height: 12),
          if (bukuDipinjam.isEmpty)
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 35),
                child: Column(
                  children: [
                    const Icon(
                      Icons.menu_book_outlined,
                      size: 65,
                      color: Colors.grey,
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Belum ada buku yang dipinjam.',
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 15),
                    ElevatedButton(
                      onPressed: () => pindahHalaman(0),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kuning,
                        foregroundColor: cokelat,
                      ),
                      child: const Text('Cari Buku'),
                    ),
                  ],
                ),
              ),
            )
          else
            ...bukuDipinjam.map((buku) => kartuBuku(buku)),
        ],
      ),
    );
  }

  Widget halamanPersonal() {
    final jumlahPinjaman =
        daftarBuku.where((buku) => buku.dipinjam).length;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const SizedBox(height: 20),
          Container(
            width: 100,
            height: 100,
            decoration: const BoxDecoration(
              color: kuning,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.person,
              size: 60,
              color: cokelat,
            ),
          ),
          const SizedBox(height: 15),
          const Text(
            'Pengguna Katalog Buku',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: cokelat,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Selamat datang di Enjoy Reading!',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 25),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.bookmark_added_outlined,
                  color: cokelat,
                  size: 35,
                ),
                const SizedBox(width: 15),
                const Expanded(
                  child: Text(
                    'Total Buku Dipinjam',
                    style: TextStyle(
                      color: cokelat,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Text(
                  '$jumlahPinjaman',
                  style: const TextStyle(
                    color: cokelat,
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          ListTile(
            tileColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            leading: const Icon(
              Icons.info_outline,
              color: cokelat,
            ),
            title: const Text(
              'Tentang Aplikasi',
              style: TextStyle(color: cokelat),
            ),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              showAboutDialog(
                context: context,
                applicationName: 'Katalog Buku Digital',
                applicationVersion: '1.0.0',
                applicationIcon: const Icon(
                  Icons.menu_book,
                  color: cokelat,
                  size: 35,
                ),
                children: const [
                  Text(
                    'Aplikasi untuk melihat katalog buku, '
                    'mencari buku, melihat detail, dan '
                    'mengelola peminjaman buku.',
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget menu(
    IconData ikon,
    String label,
    VoidCallback onTap,
  ) {
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
  static const Color kuning = Color(0xFFFFC928);
  static const Color cokelat = Color(0xFF493B27);

  @override
  Widget build(BuildContext context) {
    final buku = widget.buku;

    return Scaffold(
      backgroundColor: const Color(0xFFFFFEFA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFEFA),
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
                    color: buku.dipinjam
                        ? Colors.red
                        : Colors.green,
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
                  buku.dipinjam
                      ? 'Kembalikan Buku'
                      : 'Pinjam Buku',
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
