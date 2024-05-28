import 'package:flutter/material.dart';
import 'package:perpustakaan_mobile/Screen/Book.dart';
import 'package:perpustakaan_mobile/Screen/Favorite.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:   Book()
    );
  }
}