import 'package:flutter/material.dart';
import 'package:skycast_web/pages/home_page.dart';
import 'package:skycast_web/pages/weather_page.dart';
import 'package:skycast_web/themes/theme.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: MaterialThem.darkScheme(),
      ),
      title: 'SkyCast',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}