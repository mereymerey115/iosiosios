import 'package:flutter/material.dart';
import 'product.dart';

class ProductListItem extends StatelessWidget {
  final Product product;
  final VoidCallback onDelete;

  const ProductListItem({
    super.key,
    required this.product,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(product.id),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 30,
        ),
      ),
      onDismissed: (direction) {
        onDelete();
      },
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.indigo.shade100,
          child: Icon(
            product.icon,
            color: Colors.indigo,
          ),
        ),
        title: Text(product.title),
        subtitle: Row(
          children: [
            Flexible(
              child: Text(
                product.category,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 8),
            const Icon(
              Icons.star,
              color: Colors.orange,
              size: 16,
            ),
            Text('${product.rating}'),
          ],
        ),
        trailing: Text(
          '${product.price} KZT',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
