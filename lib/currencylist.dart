// currencylist.dart
import 'package:flutter/material.dart';

class CurrencyList extends StatefulWidget {
  final List<Map<String, dynamic>> currencyDataList;
  const CurrencyList({super.key, required this.currencyDataList});

  @override
  State<CurrencyList> createState() => _CurrencyListState();
}

class _CurrencyListState extends State<CurrencyList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Currency List",
          style: TextStyle(color: Colors.blue),
        ),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(color: Colors.blue),
      ),
      backgroundColor: Colors.blue,
      body: ListView.builder(
        itemCount: widget.currencyDataList.length,
        itemBuilder: (context, index) {
          final currency = widget.currencyDataList[index];
          return ListTile(
            leading: const Icon(
              Icons.attach_money,
              color: Colors.white,
            ),
            title: Text(
              currency["currency"],
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              currency["rate"].toString(),
              style: const TextStyle(color: Colors.white),
            ),
          );
        },
      ),
    );
  }
}