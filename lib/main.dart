import 'package:flutter/material.dart';
import 'package:perpustakaan_mobile/Screen/Bukti%20Peminjaman/Bukti.dart';
import 'package:perpustakaan_mobile/Screen/Detail%20Buku/Book.dart';
import 'package:perpustakaan_mobile/Screen/Login/Login.dart';
import 'package:perpustakaan_mobile/Screen/SplashScreen/SplashScreen.dart';
import 'package:perpustakaan_mobile/Widget/Favorite/BookModel.dart';
import 'package:perpustakaan_mobile/BookProvider.dart';
import 'package:provider/provider.dart'; 

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Bukti(),

    );
  }
}
