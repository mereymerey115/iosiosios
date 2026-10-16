
import 'package:flutter/material.dart';
import 'phone.dart';

class DetailScreen extends StatelessWidget {
  final Phone phone;

  const DetailScreen({
    super.key,
    required this.phone,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Phone Details'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              phone.image,
              height: 280,
              width: double.infinity,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stack) {
                return const SizedBox(
                  height: 280,
                  child: Icon(Icons.smartphone, size: 90),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    phone.title,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text('Brand: ${phone.category}'),
                  const SizedBox(height: 12),
                  Text(
                    '${phone.price} KZT',
                    style: const TextStyle(
                      fontSize: 22,
                      color: Colors.indigo,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(phone.description),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Go Back'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
