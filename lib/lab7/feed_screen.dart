import 'package:flutter/material.dart';
import 'phone.dart';
import 'detail_screen.dart';

class FeedScreen extends StatelessWidget {
  final List<Phone> favorites;
  final Function(Phone) onFavorite;

  FeedScreen({
    super.key,
    required this.favorites,
    required this.onFavorite,
  });

  final List<Phone> phones = [
    Phone(
      title: 'iPhone 16 Pro',
      description: 'Apple smartphone with a powerful camera.',
      image: 'https://avatars.mds.yandex.net/get-mpic/17720270/2a0000019d6157bb889bba61c9d1f1a6eb65/orig',
      price: 650000,
      category: 'Apple',
    ),
    Phone(
      title: 'Samsung Galaxy S24',
      description: 'Samsung smartphone with a great display.',
      image: 'https://images.unsplash.com/photo-1610945265064-0e34e5519bbf?w=800',
      price: 420000,
      category: 'Samsung',
    ),
    Phone(
      title: 'Google Pixel 9',
      description: 'Google smartphone with smart AI features.',
      image: 'https://avatars.mds.yandex.net/get-mpic/11179429/2a00000191d6cc45b222da4d6f37ed8aaa64/orig',
      price: 380000,
      category: 'Google',
    ),
    Phone(
      title: 'Xiaomi 14',
      description: 'Fast smartphone with a modern design.',
      image: 'https://ir.ozone.ru/s3/multimedia-1-g/c1000/7340375680.jpg',
      price: 300000,
      category: 'Xiaomi',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: phones.length,
      itemBuilder: (context, index) {
        final phone = phones[index];

        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              InkWell(
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
                child: Column(
                  children: [
                    Image.network(
                      phone.image,
                      height: 180,
                      width: double.infinity,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stack) {
                        return const SizedBox(
                          height: 180,
                          child: Icon(Icons.smartphone, size: 70),
                        );
                      },
                    ),
                    ListTile(
                      title: Text(phone.title),
                      subtitle: Text('${phone.price} KZT'),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: Icon(
                    favorites.contains(phone)
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: Colors.red,
                  ),
                  onPressed: () => onFavorite(phone),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
