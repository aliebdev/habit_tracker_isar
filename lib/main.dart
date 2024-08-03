import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'database/habit_database.dart';
import 'pages/home_page.dart';
import 'theme/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HabitDatabase.initialize();
  await HabitDatabase().saveFirstLaunchDate();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => HabitDatabase(),
      ),
      ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
      ),
    ],
    child: const MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeProvider>(context).themeData,
      home: const HomePage(),
    );
  }
}
