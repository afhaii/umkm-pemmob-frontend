class Umkm {
  final int? id;
  final String namaUmkm;
  final String? pemilik;
  final String? alamat;
  final String? kategori;
  final String? kontak;

  Umkm({
    this.id,
    required this.namaUmkm,
    this.pemilik,
    this.alamat,
    this.kategori,
    this.kontak,
  });

  // Mengubah JSON menjadi objek Umkm
  factory Umkm.fromJson(Map<String, dynamic> json) {
    return Umkm(
      id: json['id'] != null ? int.tryParse(json['id'].toString()) : null,
      namaUmkm: json['nama_umkm']?.toString() ?? '',
      pemilik: json['pemilik']?.toString(),
      alamat: json['alamat']?.toString(),
      kategori: json['kategori']?.toString(),
      kontak: json['kontak']?.toString(),
    );
  }

  // Mengubah objek Umkm menjadi JSON
  Map<String, dynamic> toJson() {
    return {
      'nama_umkm': namaUmkm,
      'pemilik': pemilik,
      'alamat': alamat,
      'kategori': kategori,
      'kontak': kontak,
    };
  }
}
