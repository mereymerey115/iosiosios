import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/product.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;

  const ProductDetailScreen({
    super.key,
    required this.product,
  });

  @override
  State<ProductDetailScreen> createState() =>
      _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int currentPage = 0;
  bool addedToCart = false;

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    final images = product.images.isEmpty
        ? <String>[]
        : List<String>.filled(3, product.imageUrl);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () => showShareSheet(context),
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 310,
              child: images.isEmpty
                  ? const Center(
                child: Icon(Icons.image_not_supported, size: 80),
              )
                  : PageView.builder(
                itemCount: images.length,
                onPageChanged: (index) {
                  setState(() {
                    currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  final image = Padding(
                    padding: const EdgeInsets.all(24),
                    child: Image.network(
                      images[index],
                      fit: BoxFit.contain,
                      errorBuilder: (_, __, ___) =>
                      const Icon(Icons.broken_image, size: 80),
                    ),
                  );

                  if (index == 0) {
                    return Hero(
                      tag: 'product_image_${product.id}',
                      child: image,
                    );
                  }

                  return image;
                },
              ),
            ),

            if (images.isNotEmpty) ...[
              Center(
                child: Text(
                  '${currentPage + 1} / ${images.length}',
                  style: const TextStyle(fontSize: 16),
                ),
              ),

              const SizedBox(height: 12),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  images.length,
                      (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: currentPage == index ? 22 : 9,
                    height: 9,
                    decoration: BoxDecoration(
                      color: currentPage == index
                          ? Colors.indigo
                          : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ],

            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Chip(
                    label: Text(product.category),
                    backgroundColor: Colors.indigo.shade50,
                  ),

                  const SizedBox(height: 12),

                  Text(
                    product.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 25,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.orange,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        '${product.rating} '
                            '(${product.reviewCount} reviews)',
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  const Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    product.description,
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            height: 55,
            child: ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  addedToCart = !addedToCart;
                });

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      addedToCart
                          ? 'Added to Cart!'
                          : 'Removed from Cart!',
                    ),
                  ),
                );
              },
              icon: Icon(
                addedToCart
                    ? Icons.check
                    : Icons.shopping_cart,
              ),
              label: Text(
                addedToCart
                    ? 'Added to Cart'
                    : 'Add to Cart',
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                foregroundColor: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showShareSheet(BuildContext context) {
    final link =
        'narxoz://store/product/${widget.product.id}';

    showModalBottomSheet(
      context: context,
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Share Product',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 20),

                SelectableText(link),

                const SizedBox(height: 20),

                ElevatedButton.icon(
                  onPressed: () async {
                    await Clipboard.setData(
                      ClipboardData(text: link),
                    );

                    if (!context.mounted) return;

                    Navigator.pop(sheetContext);

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Link copied!'),
                      ),
                    );
                  },
                  icon: const Icon(Icons.copy),
                  label: const Text('Copy Link'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
