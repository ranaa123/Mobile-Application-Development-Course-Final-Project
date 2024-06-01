import 'package:flutter/material.dart';
import '../models/category.dart';
import '../models/meal.dart';
import '../services/api_service.dart';

/*MealProvider sınıfı: State management ve API çağrılarını yönetir.
fetchCategories, fetchMealsByCategory, fetchMealDetails yöntemleri: Kategorileri ve yemek tariflerini API'dan çeker.*/

class MealProvider with ChangeNotifier {
  List<Category> _categories = [];
  List<Meal> _meals = [];
  Meal? _selectedMeal;
  bool _isLoading = false;

  List<Category> get categories => _categories;
  List<Meal> get meals => _meals;
  Meal? get selectedMeal => _selectedMeal;
  bool get isLoading => _isLoading;

  Future<void> fetchCategories() async {
    _isLoading = true;
    notifyListeners();
    _categories = await ApiService.fetchCategories();
    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchMealsByCategory(String categoryName) async {
    _isLoading = true;
    notifyListeners();
    _meals = await ApiService.fetchMealsByCategory(categoryName);
    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchMealDetails(String mealId) async {
    _isLoading = true;
    notifyListeners();
    _selectedMeal = await ApiService.fetchMealDetails(mealId);
    _isLoading = false;
    notifyListeners();
  }
}
