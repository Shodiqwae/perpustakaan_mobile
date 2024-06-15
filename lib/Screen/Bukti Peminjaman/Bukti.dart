import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:perpustakaan_mobile/page/home_page.dart';
import 'package:perpustakaan_mobile/service/modeluser.dart';

class Bukti extends StatelessWidget {
  final Map book;
  final UserModel user;

  Bukti({required this.book, required this.user});

Future<void> createLoan(int bookId, int userId, BuildContext context) async {
  final String apiUrl = 'http://10.0.2.2:8000/api/storeLoan';

  final response = await http.post(
    Uri.parse(apiUrl),
    body: {
      'book_id': bookId.toString(),
      'user_id': userId.toString(),
    },
  );

  if (response.statusCode == 201) {
    print('Loan created successfully');
    // Tampilkan Snackbar peminjaman berhasil
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Peminjaman berhasil')),
    );
    // Navigasi kembali ke halaman utama
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => HomePP(user: user)),
      (Route<dynamic> route) => false,
    );
  } else if (response.statusCode == 400) {
    // Tangani kasus stok buku habis
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Stok buku habis atau anda sudah meminjam sebelumnya, tidak dapat melakukan peminjaman')),
    );
  } else {
    print('Failed to create loan: ${response.statusCode}');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Gagal membuat peminjaman, silakan coba lagi')),
    );
  }
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Image.asset(
              "assets/images/buku.png",
              height: 120,
              width: 240,
            ),
            SizedBox(height: 2),
            Text(
              "Lakukan Peminjaman",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 2),
            Text(
              "Kode antrian : ",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Container(
              height: 200,
              width: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.black,
              ),
              child: book['image_book'] != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        'http://10.0.2.2:8000/storage/${book['image_book']}',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            'images/bukua.png',
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    )
                  : Image.asset(
                      'images/bukua.png',
                      fit: BoxFit.cover,
                    ),
            ),
            SizedBox(height: 5),
            Text(
              book['title'],
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 2),
            Text(
              book['author'],
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            SizedBox(height: 100),
            InkWell(
              onTap: () {
                createLoan(book['id'], user.id, context); // Menggunakan book['id'] sebagai bookId
              },
              child: Container(
                height: 40,
                width: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color.fromARGB(255, 95, 68, 171),
                ),
                child: Center(
                  child: Text(
                    "Accept",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Icon(Icons.arrow_back),
        backgroundColor: Color.fromARGB(255, 95, 68, 171),
        focusColor: Colors.white,
        foregroundColor: Colors.white,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}
