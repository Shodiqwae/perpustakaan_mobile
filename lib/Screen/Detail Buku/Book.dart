import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:perpustakaan_mobile/Screen/Bukti%20Peminjaman/Bukti.dart';
import 'package:perpustakaan_mobile/service/modeluser.dart';

class BookPage extends StatefulWidget {
  final Map book;
  final UserModel user;

  BookPage({required this.book, required this.user});

  @override
  _BookPageState createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
    double averageRating = 0.0; // Nilai awal rata-rata rating

  bool isFavorite = false;
  List categories = [];

  @override
  void initState() {
    super.initState();
    fetchCategories();
    checkIfFavorite();
    fetchRating();
  }


  Future<void> fetchRating() async {
  final response = await http.get(
    Uri.parse('http://10.0.2.2:8000/api/book-rating/${widget.book['id']}'),
  );

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    // Periksa apakah data 'average_rating' tidak null
    if (data['average_rating'] != null) {
      setState(() {
        averageRating = double.parse(data['average_rating'].toString());
      });
    } else {
      // Jika 'average_rating' null, atur nilai default 0
      setState(() {
        averageRating = 0.0;
      });
    }
  } else {
    // Jika respons tidak berhasil, atur nilai default 0
    setState(() {
      averageRating = 0.0;
    });
    // Handle error
    print('Failed to load rating');
  }
}

  Future<void> fetchCategories() async {
    final response = await http.get(
        Uri.parse('http://10.0.2.2:8000/api/category/${widget.book['id']}'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data != null && data['data'] != null) {
        setState(() {
          categories = data['data']['categories'] ?? [];
        });
      }
    } else {
      // Handle error
    }
  }

  Future<void> checkIfFavorite() async {
    final response = await http.get(Uri.parse(
        'http://10.0.2.2:8000/api/check-favorite/${widget.user.id}/${widget.book['id']}'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        isFavorite = data['is_favorite'];
      });
    } else {
      // Handle error
    }
  }

  Future<void> addToFavorites() async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8000/api/add-to-favorites'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'user_id': widget.user.id,
        'book_id': widget.book['id'],
      }),
    );

    if (response.statusCode == 200) {
      setState(() {
        isFavorite = true;
      });

      // Tampilkan Snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Berhasil menambahkan ke favorit'),
          duration: Duration(seconds: 2), // Durasi Snackbar ditampilkan
        ),
      );
    } else {
      // Handle error
    }
  }

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
          child: Column(
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
                      image: DecorationImage(
                        image: NetworkImage(
                          'http://10.0.2.2:8000/storage/${widget.book['image_book']}',
                        ),
                        fit: BoxFit.cover,
                      ),
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
                                  "Offline",
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
                          ],
                        ),
                        SizedBox(height: 5),
                        Text(
                          '${widget.book['title']}',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '${widget.book['author']}',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          "Stock : ",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          '${widget.book['stock'] ?? 'Loading...'}', // Ubah bagian ini untuk mengambil nilai stok dari widget.book
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 10),
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
                      index < averageRating.round() ? Icons.star : Icons.star_border,
                      color: Colors.amber,
                      size: 24,
                    );
                  }),
                ),
                SizedBox(width: 10),
                Text(
                  averageRating.toStringAsFixed(1),
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),

            SizedBox(height: 20),

                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    child: Text(
                      "Genre: " +
                          (categories.isNotEmpty
                              ? categories.map((cat) => cat['name']).join(', ')
                              : 'Loading...'),
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Color.fromRGBO(246, 84, 84, 1),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Bukti(
                                book: widget.book,
                                user: widget.user,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          height: 60,
                          width: 200,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
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
                      ),
                      SizedBox(width: 20),
                      InkWell(
                        onTap: isFavorite ? null : addToFavorites,
                        child: Container(
                          height: 60,
                          width: 60,
                          child: Icon(
                            Icons.favorite,
                            color: isFavorite ? Colors.red : Colors.black,
                            size: 36,
                          ),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 3,
                                offset:
                                    Offset(0, 2), // changes position of shadow
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 15),
              Text(
                "Description",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                '${widget.book['description']}',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w300,
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
