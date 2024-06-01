import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/meal_provider.dart';
import 'meal_detail_screen.dart';

class MealListScreen extends StatefulWidget {
  final String categoryName;

  const MealListScreen({required this.categoryName, Key? key}) : super(key: key);

  @override
  _MealListScreenState createState() => _MealListScreenState();
}

class _MealListScreenState extends State<MealListScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    Future.microtask(() => _fetchMeals());
  }

  Future<void> _fetchMeals() async {
    try {
      await Provider.of<MealProvider>(context, listen: false).fetchMealsByCategory(widget.categoryName);
    } catch (error) {
      print("Error fetching meals: $error");
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final mealProvider = Provider.of<MealProvider>(context, listen: true);

    return Scaffold(
      appBar: AppBar(title: Text('${widget.categoryName} Meals')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : mealProvider.meals.isEmpty
              ? const Center(child: Text('No meals found'))
              : ListView.builder(
                  itemCount: mealProvider.meals.length,
                  itemBuilder: (context, index) {
                    final meal = mealProvider.meals[index];
                    return ListTile(
                      leading: Image.network(meal.thumbnail),
                      title: Text(meal.name),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MealDetailScreen(mealId: meal.id),
                          ),
                        );
                      },
                    );
                  },
                ),
    );
  }
}
