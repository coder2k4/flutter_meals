import 'package:flutter/material.dart';

class Category {
  final String id;
  final String title;
  final Color color;

  // Объект категрии не может быть изменен, и поля тоже
  const Category({
    @required this.id,
    @required this.title,
    this.color = Colors.orange,
  });
}
