import 'package:flutter/material.dart';
import 'meal_item.dart';
import 'meal.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = '/category-meals';
final List<Meal> _availabelMeals;
CategoryMealsScreen(this._availabelMeals);
  @override
  State<CategoryMealsScreen> createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
//  final String categoryId;
  late String  categoryTitle;
  late List<Meal> displayedMeals;


  @override
  void didChangeDependencies() {
    final routeArgs =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    categoryTitle = routeArgs['title'].toString();
    final categoryId = routeArgs['id'];
    displayedMeals = widget._availabelMeals.where((meal) {
      return meal.categories.contains(categoryId);
    }).toList();
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  void _removeMeal(String mealId) {
    setState(() {
      displayedMeals.removeWhere((meal) => meal.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle.toString()),
      ),
      body: Center(
        child: ListView.builder(
          itemBuilder: (context, index) {
            return MeaIItem(
              affordability: displayedMeals[index].affordability,
              complexity: displayedMeals[index].complexity,
              duration: displayedMeals[index].duration,
              imageUrl: displayedMeals[index].imageUrl,
              title: displayedMeals[index].title,
              id: displayedMeals[index].id,
              
            );
          },
          itemCount: displayedMeals.length,
        ),
      ),
    );
  }
}
