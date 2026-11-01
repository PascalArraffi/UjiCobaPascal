class Buku {
  final String judul;
  final String penulis;
  final String kategori;
  final String gambar;
  final String deskripsi;

  bool dipinjam;
  bool favorit;

  Buku({
    required this.judul,
    required this.penulis,
    required this.kategori,
    required this.gambar,
    required this.deskripsi,
    this.dipinjam = false,
    this.favorit = false,
  });
}
