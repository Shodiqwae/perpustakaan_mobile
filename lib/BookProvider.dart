import 'package:flutter/material.dart';
import 'Widget/Favorite/bookmodel.dart';

class BookProvider with ChangeNotifier {
  List<BookModel> _books = [
    BookModel(title: 'We could be Heroes', author: 'Margaret Finnegan', description: 'Some description here'),
    // Tambahkan lebih banyak buku di sini jika diperlukan
  ];

  List<BookModel> get books => _books;

  void toggleFavoriteStatus(BookModel book) {
    book.isFavorite = !book.isFavorite;
    notifyListeners();
  }

  List<BookModel> get favoriteBooks => _books.where((book) => book.isFavorite).toList();
}
