import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:perpustakaan_mobile/Screen/Detail%20Buku/Book.dart';
import 'package:perpustakaan_mobile/Screen/Favorite/Favorite.dart';
import 'package:perpustakaan_mobile/Screen/Profil/Profil_1.dart';
import 'dart:convert';
import 'package:perpustakaan_mobile/page/history.dart';
import 'package:perpustakaan_mobile/service/modeluser.dart';

class HomePP extends StatefulWidget {
  final UserModel user; // Menggunakan UserModel

  HomePP({required this.user});

  @override
  _HomePPState createState() => _HomePPState();
}

class _HomePPState extends State<HomePP> {
  int _selectedIndex = 0;
  late List<Widget> _pages; // Buat variabel _pages di sini dan tandai sebagai late

  @override
  void initState() {
    super.initState();
    _pages = [
      HomeScreen(user: widget.user), // Inisialisasi _pages di initState
      FavoritePage(userId: widget.user.id),
      Hisbae(userId: widget.user.id,),
      Profile(userId: widget.user.id,), // Passing user data to Profile
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite',
            ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        unselectedItemColor: Color.fromRGBO(93, 23, 235, 1),
        
        onTap: _onItemTapped,
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  final UserModel user;

  HomeScreen({required this.user});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List books = [];
  List filteredBooks = [];
  bool isLoading = true;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchBooks();
    searchController.addListener(_onSearchChanged);
  }

  Future<void> fetchBooks() async {
    final response = await http.get(
      Uri.parse('http://10.0.2.2:8000/api/books'),
      headers: {
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      try {
        setState(() {
          books = json.decode(response.body);
          filteredBooks = books; // Initialize filteredBooks with all books
          isLoading = false;
        });
      } catch (e) {
        print("Error parsing JSON: $e");
        setState(() {
          isLoading = false;
        });
      }
    } else {
      print("Server responded with status code: ${response.statusCode}");
      print("Response body: ${response.body}");
      setState(() {
        isLoading = false;
      });
    }
  }

  void _onSearchChanged() {
    String searchQuery = searchController.text.toLowerCase();
    setState(() {
      filteredBooks = books
          .where((book) =>
              book['title'].toLowerCase().contains(searchQuery) )
          .toList();
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromRGBO(93, 23, 235, 1),
        flexibleSpace: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: <Widget>[
              Image.asset(
                'images/gambar.png',
                height: 100,
                width: 70,
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: Container(
                  height: 50.0,
                  margin: const EdgeInsets.all(5.0),
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Search Destination..',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      suffixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : GridView.builder(
              padding: EdgeInsets.all(20.0),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 300.0,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                childAspectRatio: 0.6,
              ),
              itemCount: filteredBooks.length,
              itemBuilder: (BuildContext context, int index) {
                return BookCard(book: filteredBooks[index], user: widget.user);
              },
            ),
    );
  }
}

class BookCard extends StatelessWidget {
  final Map book;
  final UserModel user;

  BookCard({required this.book, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BookPage(book: book, user: user),
            ),
          );
        },
        child: Card(
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: book['image_book'] != null
                      ? Image.network(
                          'http://10.0.2.2:8000/storage/${book['image_book']}',
                          width: 300,
                          height: 200,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              'images/bukua.png',
                              width: 300,
                              height: 200,
                            );
                          },
                        )
                      : const SizedBox(
                          width: double.infinity,
                          height: 200,
                          child: Center(
                            child: Text('Gambar tidak tersedia'),
                          ),
                        ),
                ),
                const SizedBox(height: 8),
                Text(
                  book['title'],
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 8),
                Text(
                  book['author'],
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
