// splashscreen.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:currencyconverter/currencyconverter.dart';  // Ensure this path is correct
import 'package:currencyconverter/api.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    getCurrencyRates();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/currencyconverterlogo.jpg"),
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                "Currency Converter",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const CircularProgressIndicator(
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> getCurrencyRates() async {
    final currencyURL =
        "https://api.freecurrencyapi.com/v1/latest?apikey=$currencyAPI&base_currency=INR";
    final currencyUri = Uri.parse(currencyURL);
    final response = await http.get(currencyUri);
    
    if (response.statusCode == 200) {
      final currencyData = json.decode(response.body);
      List<Map<String, dynamic>> currencyDataList = [];
      currencyData["data"].forEach((key, value) {
        currencyDataList.add({
          "currency": key,
          "rate": value,
        });
      });
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => CurrencyConverterApp(currencyDataList: currencyDataList),
        ),
      );
    }
  }
}