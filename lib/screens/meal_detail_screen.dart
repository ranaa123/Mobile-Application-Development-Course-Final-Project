import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/meal_provider.dart';

class MealDetailScreen extends StatefulWidget {
  final String mealId;

  const MealDetailScreen({required this.mealId, Key? key}) : super(key: key);

  @override
  _MealDetailScreenState createState() => _MealDetailScreenState();
}

class _MealDetailScreenState extends State<MealDetailScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    Future.microtask(() => _fetchMealDetails());
  }

  Future<void> _fetchMealDetails() async {
    try {
      await Provider.of<MealProvider>(context, listen: false)
          .fetchMealDetails(widget.mealId);
    } catch (error) {
      print("Error fetching meal details: $error");
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
    final mealProvider = Provider.of<MealProvider>(context);

    return Scaffold(
      appBar: AppBar(
          title: Text(mealProvider.selectedMeal?.name ?? 'Meal Details')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : mealProvider.selectedMeal == null
              ? const Center(child: Text('No details available'))
              : ListView.builder(
                  itemCount: mealProvider.selectedMeal!.ingredients.length,
                  itemBuilder: (context, index) {
                    final ingredient =
                        mealProvider.selectedMeal!.ingredients[index];
                    final measure = mealProvider.selectedMeal!.measures[index];
                    return ListTile(
                      title: Text(ingredient),
                      subtitle: Text(measure),
                    );
                  },
                ),
    );
  }
}
