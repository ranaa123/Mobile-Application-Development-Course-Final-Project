import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/category.dart';
import '../models/meal.dart';

class ApiService {
  static const String _baseUrl = 'https://www.themealdb.com/api/json/v1/1';

  static Future<List<Category>> fetchCategories() async {
    final response = await http.get(Uri.parse('$_baseUrl/categories.php'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body)['categories'];
      return data.map((item) => Category.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }

  static Future<List<Meal>> fetchMealsByCategory(String categoryName) async {
    final response = await http.get(Uri.parse('$_baseUrl/filter.php?c=$categoryName'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body)['meals'];
      return data.map((item) => Meal.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load meals');
    }
  }

  static Future<Meal> fetchMealDetails(String mealId) async {
    final response = await http.get(Uri.parse('$_baseUrl/lookup.php?i=$mealId'));

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body)['meals'][0];
      return Meal.fromJson(data);
    } else {
      throw Exception('Failed to load meal details');
    }
  }
}
