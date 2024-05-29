import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../BookProvider.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Books'),
      ),
      body: Consumer<BookProvider>(
        builder: (context, bookProvider, _) {
          final favoriteBooks = bookProvider.favoriteBooks;
          return ListView.builder(
            itemCount: favoriteBooks.length,
            itemBuilder: (context, index) {
              final book = favoriteBooks[index];
              return ListTile(
                title: Text(book.title),
                subtitle: Text(book.author),
                trailing: IconButton(
                  icon: Icon(Icons.favorite),
                  onPressed: () {
                    bookProvider.toggleFavoriteStatus(book);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
