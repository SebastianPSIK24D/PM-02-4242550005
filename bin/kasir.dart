import 'dart:io';

/// Data satu produk di katalog
typedef Produk = ({String nama, String kategori, int harga});

/// Satu item pesanan yang valid
typedef ItemPesanan = ({String kode, Produk produk, int qty});

/// Hasil uraian pesanan item valid dan item ditolak
typedef HasilUrai = ({List<ItemPesanan> diterima, List<String> ditolak});

// Lebar kolom tabel katalog
const int lebarKode = 6;
const int lebarNama = 24;
const int lebarHarga = 10;
const int lebarTabel = lebarKode + lebarNama + lebarHarga;

// Pemisah format pesanan
const String pemisahItem = ',';
const String pemisahJumlah = 'x';

/// Mencetak katalog sebagai tabel
void tampilkanKatalog(Map<String, Produk> katalog) {
  print('KATALOG TOKO');
  print(
    '${'Kode'.padRight(lebarKode)}'
    '${'Nama'.padRight(lebarNama)}'
    '${'Harga'.padLeft(lebarHarga)}',
  );

  katalog.forEach((kode, produk) {
    print(
      '${kode.padRight(lebarKode)}'
      '${produk.nama.padRight(lebarNama)}'
      '${produk.harga.toString().padLeft(lebarHarga)}',
    );
  });
}

/// Menguraikan teks pesanan menjadi item valid dan item ditolak
HasilUrai uraiPesanan(String input, Map<String, Produk> katalog) {
  final List<ItemPesanan> diterima = [];
  final List<String> ditolak = [];

  for (final item in input.split(pemisahItem)) {
    final String teks = item.trim();
    if (teks.isEmpty) continue;

    // Format (kode dan jumlah)
    final List<String> bagian = teks.toLowerCase().split(pemisahJumlah);
    if (bagian.length != 2) {
      ditolak.add(teks);
      continue;
    }

    final String kode = bagian[0].trim().toUpperCase();
    final int? qty = int.tryParse(bagian[1].trim()); // null jika bukan angka
    final Produk? produk = katalog[kode]; // null jika kode tidak ada

    if (produk == null || qty == null || qty <= 0) {
      ditolak.add(teks);
      continue;
    }

    
    diterima.add((kode: kode, produk: produk, qty: qty)); // Produk dan qty pasti non-null, jadi tanpa operator !
  }

  return (diterima: diterima, ditolak: ditolak);
}

void main() {
  // Katalog
  final Map<String, Produk> katalog = {
    'P01': (nama: 'Kopi Sidikalang 250 g', kategori: 'Kopi', harga: 45000),
    'P02': (nama: 'Kopi Gayo 250 g', kategori: 'Kopi', harga: 55000),
    'P03': (nama: 'Teh Kayu Aro 100 g', kategori: 'Teh', harga: 25000),
    'P04': (nama: 'Gula Aren 500 g', kategori: 'Pemanis', harga: 30000),
    'P05': (nama: 'Bolu Meranti', kategori: 'Makanan', harga: 80000),
  };

  tampilkanKatalog(katalog);

  stdout.write('Pesanan (contoh: P01x2, P03x1): ');
  final String input = stdin.readLineSync() ?? ''; // String? -> ganti ''

  final HasilUrai hasil = uraiPesanan(input, katalog);

  // input
  print('Diterima : ${hasil.diterima.length} item');
  print('Ditolak  : ${hasil.ditolak}');
}
