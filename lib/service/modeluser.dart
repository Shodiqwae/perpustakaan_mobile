class UserModel {
  final int id;
  final String name;
  final String email;
  final String role;
   final String gambar;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.gambar,

  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'] ?? '', // Menambahkan default value jika null
      email: json['email'] ?? '',
      role: json['role'] ?? '', // Menambahkan default value jika null
      gambar: json['gambar'],
    );
  }
}
