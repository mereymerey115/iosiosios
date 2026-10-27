import 'package:flutter/material.dart';
class Product {
  final int id;
  final String title;
  final String category;
  final int price;
  final double rating;
  final IconData icon;

  Product({
    required this.id,
    required this.title,
    required this.category,
    required this.price,
    required this.rating,
    required this.icon,
  });
}
