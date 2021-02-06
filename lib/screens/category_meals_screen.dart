import 'package:flutter/material.dart';
import 'package:flutter_meals/dummy_data.dart';
import 'package:flutter_meals/models/meal.dart';

class CategoryMealsScreen extends StatelessWidget {
  static const routeName = '/category-meals';

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    // final categoryId = routeArgs['id'];
    final categoryTitle = routeArgs['title'];
    final categoryId = routeArgs['id'];
    final List<Meal> categoryMeal = DUMMY_MEALS
        .where((meal) => meal.categories.contains(categoryId))
        .toList();
    return Scaffold(
        appBar: AppBar(
          title: Text(categoryTitle),
        ),
        body: ListView.builder(
          itemBuilder: (context, index) {
            return Text(categoryMeal[index].title);
          },
          itemCount: categoryMeal.length,
        ));
  }
}
