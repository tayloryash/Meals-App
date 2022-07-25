import 'package:flutter/material.dart';

import 'tabs_screen.dart';
import 'category_meals_screen.dart';
import 'categories_screen.dart';
import 'meal_detail_screen.dart';
import 'filters_screen.dart';
import 'dummy_data.dart';
import 'meal.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  List<Meal> _availabelMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;
      _availabelMeals = DUMMY_MEALS.where((meal) {
        if (_filters['gluten'] as bool && !meal.isGlutenFree) return false;

        if (_filters['lactose'] as bool && !meal.isLactoseFree) return false;

        if (_filters['vegan'] as bool && !meal.isVegan) return false;

        if (_filters['vegetarian'] as bool && !meal.isVegetarian) return false;

        return true;
      }).toList();
    });
  }

  void _toggleFavorite(String mealId) {
    final existingIndex =
        _favoriteMeals.indexWhere((meal) => meal.id == mealId);

        if(existingIndex >=0)
        {
          setState(() {
            _favoriteMeals.removeAt(existingIndex);
          });
        }
      else
      {
        setState(() {
          _favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
        });
      }

  }

  bool _isMealFavorite(String id)
  {
    return _favoriteMeals.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.pink)
            .copyWith(secondary: Colors.amber),
        canvasColor: const Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              titleMedium: const TextStyle(
                fontSize: 20,
                fontFamily: 'RobotoCondensed',
              ),
            ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => TabsScreen(_favoriteMeals),
        CategoryMealsScreen.routeName: (context) =>
            CategoryMealsScreen(_availabelMeals),
        MealDetailScreen.routeName: (context) => MealDetailScreen(_toggleFavorite,_isMealFavorite),
        FiltersScreen.routeName: (context) =>
            FiltersScreen(_filters, _setFilters),
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => CategoriesScreen(),
        );
      },
    );
  }
}
