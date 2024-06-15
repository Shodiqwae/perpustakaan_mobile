class Loan {
  final int id;
  final String bookTitle;
  final String bookAuthor;
  final String bookImage;
  final String status;

  Loan({
    required this.id,
    required this.bookTitle,
    required this.bookAuthor,
    required this.bookImage,
    required this.status,
  });

  factory Loan.fromJson(Map<String, dynamic> json) {
    return Loan(
      id: json['id'],
      bookTitle: json['book']['title'],
      bookAuthor: json['book']['author'],
      bookImage: json['book']['image_book'],
      status: json['status'],
    );
  }
}
