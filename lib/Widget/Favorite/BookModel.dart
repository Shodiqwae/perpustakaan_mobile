class BookModel {
  final String title;
  final String author;
  final String description;
  bool isFavorite;

  BookModel({
    required this.title,
    required this.author,
    required this.description,
    this.isFavorite = false,
  });
}
