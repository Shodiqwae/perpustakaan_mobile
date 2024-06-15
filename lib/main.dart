import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:perpustakaan_mobile/Screen/Login/Login.dart'; // Import your LoginPage widget
import 'package:fluttertoast/fluttertoast.dart';

import 'BookProvider.dart'; // Import your BookProvider class
import 'package:perpustakaan_mobile/page/history.dart';
import 'package:perpustakaan_mobile/page/home_page.dart';
import 'package:perpustakaan_mobile/Screen/Bukti%20Peminjaman/Bukti.dart';
import 'package:perpustakaan_mobile/Screen/Detail%20Buku/Book.dart';
import 'package:perpustakaan_mobile/Screen/SplashScreen/SplashScreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BookProvider()), // Initialize your BookProvider
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/', // Set your initial route here
        routes: {
          '/': (context) => LoginPage(), // Define your initial route

          // Add other routes as needed
        },
      ),
    );
  }
}
