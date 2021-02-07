import 'package:flutter/material.dart';
import 'package:flutter_meals/dummy_data.dart';
import 'package:flutter_meals/screens/category_meals_screen.dart';
import 'package:flutter_meals/screens/filters_screen.dart';
import 'package:flutter_meals/screens/meal_detail_screen.dart';
import 'package:flutter_meals/screens/tabs_screen.dart';

import 'models/meal.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vega': false,
    'vegetarian': false,
  };

  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;

      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters['gluten'] && !meal.isGlutenFree) return false;
        if (_filters['lactose'] && !meal.isLactoseFree) return false;
        if (_filters['vega'] && !meal.isVegan) return false;
        if (_filters['vegetarian'] && !meal.isVegetarian) return false;

        return true;
      }).toList();
    });
  }

  void _toggleFavorite(String mealId) {
    final existingIndex =
        _favoriteMeals.indexWhere((meal) => meal.id == mealId);

    if (existingIndex >= 0)
      setState(() {
        _favoriteMeals.removeAt(existingIndex);
      });
    else
      setState(() {
        _favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      });
  }

  bool _isInFavorite(String mealId) {
    return _favoriteMeals.any((element) => element.id == mealId);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Еда',
      theme: ThemeData(
        primarySwatch: Colors.green,
        accentColor: Colors.amber,
        fontFamily: 'Raleway',
        // Фон
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              bodyText2: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              headline6: TextStyle(
                fontSize: 20,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
      home: TabsScreen(_favoriteMeals),
      // initialRoute: '/',
      routes: {
        // '/' : (context) => CategoryMealsScreen(),
        CategoryMealsScreen.routeName: (context) => CategoryMealsScreen(
              availableMeals: _availableMeals,
            ),
        MealDetailScreen.routeName: (context) =>
            MealDetailScreen(_toggleFavorite, _isInFavorite),
        FiltersScreen.routeName: (context) => FiltersScreen(
              saveFilters: _setFilters,
              filters: _filters,
            ),
      },
      onGenerateRoute: (settings) {
        print(settings.arguments);
        return MaterialPageRoute(
          builder: (context) => CategoryMealsScreen(),
        );
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => CategoryMealsScreen(),
        );
      },
    );
  }
}
