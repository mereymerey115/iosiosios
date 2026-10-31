import 'package:flutter/material.dart';
import '../models/product.dart';
import '../widgets/product_list_item.dart';
import '../widgets/product_grid_card.dart';

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key});

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  bool isGrid = false;
  int nextId = 7;

  List<Product> getInitialProducts() {
    return [
      Product(
        id: 1,
        title: 'iPhone 16 Pro',
        category: 'Apple',
        price: 650000,
        rating: 4.9,
        icon: Icons.phone_iphone,
      ),
      Product(
        id: 2,
        title: 'Samsung Galaxy S24',
        category: 'Samsung',
        price: 420000,
        rating: 4.8,
        icon: Icons.smartphone,
      ),
      Product(
        id: 3,
        title: 'Google Pixel 9',
        category: 'Google',
        price: 380000,
        rating: 4.7,
        icon: Icons.phone_android,
      ),
      Product(
        id: 4,
        title: 'Xiaomi 14',
        category: 'Xiaomi',
        price: 300000,
        rating: 4.6,
        icon: Icons.smartphone,
      ),
      Product(
        id: 5,
        title: 'Headphones',
        category: 'Accessories',
        price: 25000,
        rating: 4.5,
        icon: Icons.headphones,
      ),
      Product(
        id: 6,
        title: 'Smart Watch',
        category: 'Accessories',
        price: 45000,
        rating: 4.8,
        icon: Icons.watch,
      ),
    ];
  }

  late List<Product> products = getInitialProducts();

  Future<void> refreshProducts() async {
    await Future.delayed(
      const Duration(milliseconds: 1500),
    );

    if (!mounted) return;

    setState(() {
      products.insert(
        0,
        Product(
          id: nextId,
          title: 'New Product $nextId',
          category: 'New Arrival',
          price: 30000,
          rating: 4.9,
          icon: Icons.shopping_bag,
        ),
      );
      nextId++;
    });
  }

  void deleteProduct(Product product) {
    int index = products.indexOf(product);

    if (index == -1) return;

    setState(() {
      products.removeAt(index);
    });

    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${product.title} deleted'),
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: 'UNDO',
          onPressed: () {
            setState(() {
              products.insert(
                index.clamp(0, products.length),
                product,
              );
            });
          },
        ),
      ),
    );
  }

  void resetCatalog() {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    setState(() {
      products = getInitialProducts();
      nextId = 7;
    });
  }

  Widget emptyCatalog() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.shopping_cart_outlined,
            size: 90,
            color: Colors.grey,
          ),
          const SizedBox(height: 20),
          const Text(
            'Catalog is Empty',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: resetCatalog,
            child: const Text('Reset Catalog'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Smart Catalog'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isGrid = !isGrid;
              });
            },
            icon: Icon(
              isGrid ? Icons.list : Icons.grid_view,
            ),
          ),
        ],
      ),

      body: products.isEmpty
          ? emptyCatalog()
          : RefreshIndicator(
        onRefresh: refreshProducts,
        child: isGrid
            ? GridView.builder(
          padding: const EdgeInsets.all(12),
          physics:
          const AlwaysScrollableScrollPhysics(),
          itemCount: products.length,
          gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.72,
          ),
          itemBuilder: (context, index) {
            return ProductGridCard(
              product: products[index],
            );
          },
        )
            : ListView.separated(
          physics:
          const AlwaysScrollableScrollPhysics(),
          itemCount: products.length,
          separatorBuilder: (context, index) {
            return const Divider(height: 1);
          },
          itemBuilder: (context, index) {
            final product = products[index];

            return ProductListItem(
              product: product,
              onDelete: () {
                deleteProduct(product);
              },
            );
          },
        ),
      ),
    );
  }
}
