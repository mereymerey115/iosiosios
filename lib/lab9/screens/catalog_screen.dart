import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/cart_provider.dart';
import 'cart_screen.dart';

class CatalogScreen extends StatelessWidget {
  const CatalogScreen({super.key});

  static final List<Product> products = [
    Product(id: 1, name: 'iPhone 16 Pro', price: 650000, icon: Icons.phone_iphone),
    Product(id: 2, name: 'Samsung S24', price: 420000, icon: Icons.smartphone),
    Product(id: 3, name: 'Google Pixel 9', price: 390000, icon: Icons.phone_android),
    Product(id: 4, name: 'Xiaomi 14', price: 310000, icon: Icons.phone_android),
    Product(id: 5, name: 'Headphones', price: 45000, icon: Icons.headphones),
    Product(id: 6, name: 'Smart Watch', price: 85000, icon: Icons.watch),
  ];

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Smart Catalog'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        actions: [
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CartScreen(),
                    ),
                  );
                },
              ),
              if (cart.count > 0)
                Positioned(
                  right: 2,
                  top: 2,
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '${cart.count}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 12),
        ],
      ),
      body: ListView.separated(
        itemCount: products.length,
        separatorBuilder: (context, index) =>
        const Divider(height: 1),
        itemBuilder: (context, index) {
          final product = products[index];
          final added = cart.isInCart(product);

          return ListTile(
            leading: CircleAvatar(
              child: Icon(product.icon),
            ),
            title: Text(product.name),
            subtitle: Text('${product.price} KZT'),
            trailing: ElevatedButton(
              onPressed: () {
                cart.toggleProduct(product);
              },
              child: Text(added ? 'Remove' : 'Add to Cart'),
            ),
          );
        },
      ),
    );
  }
}
