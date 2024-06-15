import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:perpustakaan_mobile/service/ModelBook.dart';

class BookProvider with ChangeNotifier {
  List<Book> _favoriteBooks = [];

  List<Book> get favoriteBooks => _favoriteBooks;

  Future<void> fetchFavoriteBooks(int userId) async {
    final url = Uri.parse('http://10.0.2.2:8000/api/favorites?user_id=$userId');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<Book> loadedBooks = [];
      final extractedData = json.decode(response.body) as List<dynamic>;
      for (var bookData in extractedData) {
        loadedBooks.add(Book.fromJson(bookData['book']));
      }
      _favoriteBooks = loadedBooks;
      notifyListeners();
    } else {
      throw Exception('Failed to load favorite books');
    }
  }
}
