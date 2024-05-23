import 'package:flutter/material.dart';

class Book extends StatefulWidget {
  const Book({Key? key}) : super(key: key);

  @override
  State<Book> createState() => _BookState();
}

class _BookState extends State<Book> {
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
                    height: 300,
                    width: 180, // Decreased width
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.black,
                    ),
                  ),
                  Container(
                    height: 305,
                    width: 205, // Decreased width
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 25,
                              width: 80,
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
                              width: 80,
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
                          "We could be",
                          style: TextStyle(
                            fontSize: 33,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "Heroes",
                          style: TextStyle(
                            fontSize: 33,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "Margare",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          "Finegan",
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
                        Text(
                          "4.0",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w100,
                          ),
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
                      color: Color.fromRGBO(246, 84, 84, 1)
                    ),
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 60,
                        width: 280, // Decreased width
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Color.fromRGBO(90, 166, 255, 1),
                        ),
                      ),
                      SizedBox(width: 20),
                      Container(
                        height: 60,
                        width: 85,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Color.fromRGBO(236, 241, 248, 1),
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
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed et eros eu quam scelerisque fermentum eget in nisl. Fusce ac lobortis magna, eget tristique lorem. Duis fringilla nisl eget metus pretium, sit ",
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
