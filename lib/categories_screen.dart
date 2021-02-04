import 'package:flutter/material.dart';

import 'category_item.dart';
import 'dummy_data.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Еда!'),
      ),
      body: GridView(
        padding: EdgeInsets.all(25),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200, // минимальная ширина ячейки
          childAspectRatio: 3 / 2, // соотнощение ??
          crossAxisSpacing: 20, // Отступы между строками
          mainAxisSpacing: 20, // Отступы между колоками
        ),
        children: DUMMY_CATEGORIES
            .map((catData) => CategoryItem(
                  title: catData.title,
                  color: catData.color,
                  id: catData.id,
                ))
            .toList(),
      ),
    );
  }
}
