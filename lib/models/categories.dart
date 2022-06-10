import 'package:flutter/material.dart';
import 'package:news_ware/constants.dart';

class Category {
  final String id;
  final String label;
  final Color color;

  Category({required this.id, required this.label, required this.color});

  static List<Category> all() => <Category>[
        Category(
            id: 'top-headlines', label: 'Top Headlines', color: kPrimaryColor),
        Category(id: 'sports', label: 'Sports', color: Colors.teal),
        Category(id: 'business', label: 'Business', color: Colors.blueGrey),
        Category(id: 'science', label: 'Science', color: Colors.green),
        Category(id: 'technology', label: 'Technology', color: Colors.blue),
        Category(
            id: 'entertainment', label: 'Entertainment', color: Colors.purple),
        Category(id: 'health', label: 'Health', color: Colors.redAccent),
      ];
}
