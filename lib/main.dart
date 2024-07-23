// main.dart
import 'package:flutter/material.dart';
import 'package:currencyconverter/splashscreen.dart';

void main() {
  runApp(const CurrencyConverter());
}

class CurrencyConverter extends StatelessWidget {
  const CurrencyConverter({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
    );
  }
}