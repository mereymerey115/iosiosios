import 'package:flutter/material.dart';
import 'phone.dart';
import 'detail_screen.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Phone> favorites;
  final Function(Phone) onFavorite;

  const FavoritesScreen({
    super.key,
    required this.favorites,
    required this.onFavorite,
  });

  @override
  Widget build(BuildContext context) {
    if (favorites.isEmpty) {
      return const Center(
        child: Text('No favorites yet'),
      );
    }

    return ListView.builder(
      itemCount: favorites.length,
      itemBuilder: (context, index) {
        final phone = favorites[index];

        return Card(
          child: ListTile(
            leading: Image.network(
              phone.image,
              width: 60,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stack) {
                return const Icon(Icons.smartphone);
              },
            ),
            title: Text(phone.title),
            subtitle: Text('${phone.price} KZT'),
            trailing: IconButton(
              icon: const Icon(
                Icons.favorite,
                color: Colors.red,
              ),
              onPressed: () => onFavorite(phone),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailScreen(
                    phone: phone,
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
