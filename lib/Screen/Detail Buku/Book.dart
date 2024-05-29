import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:perpustakaan_mobile/Widget/Favorite/BookModel.dart';
import 'package:perpustakaan_mobile/BookProvider.dart';

class BookPage extends StatelessWidget {
  final BookModel book;

  const BookPage({required this.book, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(93, 23, 235, 1),
        elevation: 0,
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
        ),
        title: Text(
          "Detail Book",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Consumer<BookProvider>(
            builder: (context, bookProvider, _) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        height: 305,
                        width: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.black,
                        ),
                      ),
                      Container(
                        height: 305,
                        width: 160,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 25,
                                  width: 70,
                                  child: Center(
                                    child: Text(
                                      "Online",
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color.fromRGBO(236, 239, 248, 1),
                                  ),
                                ),
                                SizedBox(width: 20),
                                Container(
                                  height: 25,
                                  width: 70,
                                  child: Center(
                                    child: Text(
                                      "30 coins",
                                      style: TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color.fromRGBO(232, 220, 44, 1),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            Text(
                              book.title,
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              book.author,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(height: 16),
                            Text(
                              "Halaman",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w100,
                              ),
                            ),
                            Text(
                              "400",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w100,
                              ),
                            ),
                            SizedBox(height: 20),
                            Text(
                              "Rating",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w100,
                              ),
                            ),
                            Row(
                              children: [
                                Row(
                                  children: List.generate(5, (index) {
                                    return Icon(
                                      index < 4 ? Icons.star : Icons.star_border,
                                      color: Colors.amber,
                                      size: 16,
                                    );
                                  }),
                                ),
                                SizedBox(width: 5),
                                Text(
                                  "4.0",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w100,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Genre : Comedy, Adventure, Fantasy",
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          color: Color.fromRGBO(246, 84, 84, 1),
                        ),
                      ),
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 60,
                            width: 250,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.play_arrow,
                                    color: Colors.black,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    "Pinjam sekarang",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Color.fromRGBO(90, 166, 255, 1),
                            ),
                          ),
                          SizedBox(width: 20),
                          GestureDetector(
                            onTap: () {
                              // bookProvider.toggleFavoriteStatus(book);
                            },
                            child: Container(
                              height: 60,
                              width: 85,
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Icon(
                                  book.isFavorite ? Icons.favorite : Icons.favorite_border,
                                  color: Colors.black,
                                ),
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Color.fromRGBO(236, 241, 248, 1),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      Text(
                        "DESKRIPSI",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        book.description,
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
