import 'dart:convert';

class Petugas044 {
  final int id;
  final String nama;
  final String bagian;
  final String email;
  final String no_hp;
  
  Petugas044({
    required this.id,
    required this.nama,
    required this.bagian,
    required this.email,
    required this.no_hp,
  });

  factory Petugas044.fromMap(Map<String, dynamic> json) => Petugas044(
        id: json['id'],
        nama: json['nama'],
        bagian: json['bagian'],
        email: json['email'],
        no_hp: json['no_hp'],
      );

  Map<String, dynamic> toMap() {
    return {
      'nama': nama,
      'bagian': bagian,
      'email': email,
      'no_hp': no_hp,
    };
  }
}
