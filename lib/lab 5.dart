import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProductScreen(),
    );
  }
}

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  bool isSaved = false;
  int cartCount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Preview'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // Phone image and bookmark
              Stack(
                children: [
                  Container(
                    height: 250,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.indigo.shade50,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Icon(
                      Icons.smartphone,
                      size: 140,
                      color: Colors.indigo,
                    ),
                  ),

                  Positioned(
                    top: 10,
                    right: 10,
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          isSaved = !isSaved;
                        });
                      },
                      icon: Icon(
                        isSaved
                            ? Icons.bookmark
                            : Icons.bookmark_border,
                        color: Colors.indigo,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Product title
              const Text(
                'Smartphone Pro 256GB',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              // Rating and price
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.star, color: Colors.orange),
                      SizedBox(width: 5),
                      Text('4.9'),
                    ],
                  ),

                  const Text(
                    '450 000 KZT',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Category badges
              const Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  Chip(label: Text('Electronics')),
                  Chip(label: Text('Smartphone')),
                  Chip(label: Text('256GB')),
                  Chip(label: Text('5G')),
                ],
              ),

              const SizedBox(height: 20),

              const Text(
                'Modern smartphone with a powerful camera, '
                    'fast performance and long battery life.',
                style: TextStyle(fontSize: 16),
              ),

              const SizedBox(height: 16),

              Text(
                'Items in cart: $cartCount',
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),

      // Bottom sticky button
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      cartCount++;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.all(16),
                  ),
                  child: const Text('Add to Cart'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}