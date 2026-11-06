import 'package:flutter/material.dart';

class Product {
  final int id;
  final String name;
  final int price;
  final IconData icon;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.icon,
  });
}
