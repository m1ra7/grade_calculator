import 'package:flutter/material.dart';
import 'package:grade_calculator/widgets/ortalama_app.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ortalama Hesapla',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: const OrtalamaHesapla(),
    );
  }
}
