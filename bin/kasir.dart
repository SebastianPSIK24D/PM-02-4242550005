/// Data satu produk di katalog
typedef Produk = ({String nama, String kategori, int harga});

// Lebar kolom tabel katalog
const int lebarKode = 6;
const int lebarNama = 24;
const int lebarHarga = 10;
const int lebarTabel = lebarKode + lebarNama + lebarHarga;

/// Mencetak katalog sebagai tabel dengan kolom Kode, nama, dan harga
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
}
