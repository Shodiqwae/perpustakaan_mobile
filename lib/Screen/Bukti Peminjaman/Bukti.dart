import 'package:flutter/material.dart';

class Bukti extends StatelessWidget {
  const Bukti({super.key});

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
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(height: 2),
            Text(
              "Kode antrian : ",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(height: 10),
            Container(
              height: 200,
              width: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.black
              ),
            ),
            SizedBox(height: 5),
            Text(
              "We could be",
            ),
            SizedBox(height: 2),
            Text(
              "We could be",
            ),
            SizedBox(height: 100),
            Container(
              height: 40,
              width: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.black
              ),
            ),
          ],
        ),
      ),
    );
  }
}