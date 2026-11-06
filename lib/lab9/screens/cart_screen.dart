
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text('My Cart (${cart.count})'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: cart.cart.isEmpty
                ? const Center(
              child: Text(
                'Your cart is empty',
                style: TextStyle(fontSize: 20),
              ),
            )
                : ListView.builder(
              itemCount: cart.cart.length,
              itemBuilder: (context, index) {
                final product = cart.cart[index];

                return ListTile(
                  leading: Icon(product.icon),
                  title: Text(product.name),
                  subtitle: Text('${product.price} KZT'),
                  trailing: IconButton(
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      cart.removeProduct(product);
                    },
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text(
                  'Total: ${cart.totalPrice} KZT',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: cart.cart.isEmpty
                      ? null
                      : () {
                    cart.clearCart();
                  },
                  child: const Text('Clear All'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
