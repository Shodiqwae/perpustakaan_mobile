import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Favorite extends StatelessWidget {
  const Favorite({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(93, 23, 235, 1),
        centerTitle: true,
        title: Text(
          'Favorite',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
