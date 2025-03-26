class Customer016 {
  final int id;
  final String nama;
  final String alamat;
  final String email;
  final String no_hp;

  Customer016({
    required this.id,
    required this.nama,
    required this.alamat,
    required this.email,
    required this.no_hp,
  });

  factory Customer016.fromMap(Map<String, dynamic> json) => Customer016(
        id: json['id'],
        nama: json['nama'],
        alamat: json['alamat'],
        email: json['email'],
        no_hp: json['no_hp'],
      );

  Map<String, dynamic> toMap() {
    return {
      'nama': nama,
      'alamat': alamat,
      'email': email,
      'no_hp': no_hp,
    };
  }
}
