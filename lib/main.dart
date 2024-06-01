import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/meal_provider.dart';
import 'screens/category_screen.dart';
import 'screens/meal_list_screen.dart';
import 'screens/meal_detail_screen.dart';



/*main fonksiyonu: Uygulamayı başlatır.
MyApp sınıfı: Uygulamanın temel yapı taşını oluşturur ve gerekli rotaları tanımlar.
MultiProvider: State management için Provider kullanılır.
Rotalar: / rotası CategoryScreen'i, /meals rotası MealListScreen'i ve /mealDetail rotası MealDetailScreen'i gösterir.*/


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MealProvider()),
      ],
      child: MaterialApp(
        title: 'Meal App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => const CategoryScreen(),
        },
        onGenerateRoute: (settings) {
          if (settings.name == '/meals') {
            final args = settings.arguments as String;
            return MaterialPageRoute(
              builder: (context) {
                return MealListScreen(categoryName: args);
              },
            );
          } else if (settings.name == '/mealDetail') {
            final args = settings.arguments as String;
            return MaterialPageRoute(
              builder: (context) {
                return MealDetailScreen(mealId: args);
              },
            );
          }
          return null;
        },
      ),
    );
  }
}
