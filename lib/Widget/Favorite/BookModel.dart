class BookModel {
  final String title;
  final String author;
  final String description;
  final String imageUrl; // URL gambar buku

  BookModel({
    required this.title,
    required this.author,
    required this.description,
    required this.imageUrl,
  });

factory BookModel.fromJson(Map<String, dynamic> json) {
  return BookModel(
    title: json['title'] ?? '',
    author: json['author'] ?? '',
    description: json['description'] ?? '',
    imageUrl: json['image_book'] != null
        ? 'http://10.0.2.2:8000/storage/${json['image_book']}'
        : '', // Sesuaikan dengan key yang digunakan untuk URL gambar buku di JSON response
  );
}

}
