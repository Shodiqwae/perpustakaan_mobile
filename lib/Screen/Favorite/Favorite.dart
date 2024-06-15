import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:perpustakaan_mobile/service/ModelBook.dart';

class FavoritePage extends StatefulWidget {
  final int userId;

  const FavoritePage({Key? key, required this.userId}) : super(key: key);

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  List<Book> favoriteBooks = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchFavoriteBooks();
  }

  Future<void> fetchFavoriteBooks() async {
    final response = await http
        .get(Uri.parse('http://10.0.2.2:8000/api/favorites/${widget.userId}'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['success']) {
        setState(() {
          favoriteBooks = (data['favorites'] as List)
              .map((book) => Book.fromJson(book))
              .toList();
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromRGBO(93, 23, 235, 1),
        title: Text('Favorite Books',style: TextStyle(color: Colors.white),),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : favoriteBooks.isEmpty
              ? Center(
                  child: Text(
                    'Tambahkan Buku Favorite anda',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                )
              : ListView.builder(
                  itemCount: favoriteBooks.length,
                  itemBuilder: (context, index) {
                    final book = favoriteBooks[index];
                    return Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Gambar buku dengan URL dinamis
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.network(
                              'http://10.0.2.2:8000/storage/${book.imageUrl}',
                              width: 110,
                              height: 170,
                              fit: BoxFit.cover,
                              errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                                return Image.asset(
                                  'images/bukua.png',
                                  width: 100,
                                  height: 170,
                                  fit: BoxFit.cover,
                                );
                              },
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  book.title,
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  book.author,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                SizedBox(height: 5),
                                Row(
                                  children: [
                                    Text(
                                      'Online',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.green,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5),
                                Row(
                                  children: List.generate(5, (index) {
                                    return Icon(
                                      Icons.star,
                                      size: 19,
                                      color: index < 4 ? Colors.yellow : Colors.grey,
                                    );
                                  }),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 120),
                                child: GestureDetector(
                                  onTap: () async {
                                    final response = await http.delete(
                                      Uri.parse(
                                          'http://10.0.2.2:8000/api/remove-from-favorites/${book.id}'),
                                    );

                                    if (response.statusCode == 200) {
                                      // Berhasil menghapus dari favorit, lakukan sesuatu
                                      setState(() {
                                        favoriteBooks.remove(book);
                                      });
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text('Book removed from favorites'),
                                          duration: Duration(seconds: 2),
                                        ),
                                      );
                                    } else {
                                      // Gagal menghapus dari favorit, tampilkan pesan atau handling error
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text('Failed to remove from favorites'),
                                          duration: Duration(seconds: 2),
                                        ),
                                      );
                                    }
                                  },
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 221, 220, 215),
                                    borderRadius: BorderRadius.circular(50)
                                    ),
                                    child: Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                      size: 35,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
    );
  }
}
