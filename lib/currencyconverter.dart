import 'package:flutter/material.dart';
import 'package:currencyconverter/currencylist.dart';

class CurrencyConverterApp extends StatefulWidget {
  final List<Map<String, dynamic>> currencyDataList;
  const CurrencyConverterApp({super.key, required this.currencyDataList});

  @override
  State<CurrencyConverterApp> createState() => _CurrencyConverterAppState();
}

class _CurrencyConverterAppState extends State<CurrencyConverterApp> {
  String? selectedCurrency;
  List<String> currencyList = [];
  TextEditingController inrController = TextEditingController();
  double convertedValue = 0.0;

  @override
  void initState() {
    super.initState();
    populateCurrencyList();
  }

  void populateCurrencyList() {
    currencyList = widget.currencyDataList.map((item) => item['currency'] as String).toList();
    selectedCurrency = currencyList.first;
  }

  void convertCurrency() {
    final inrValue = double.tryParse(inrController.text);
    if (inrValue != null && selectedCurrency != null) {
      final selectedCurrencyData = widget.currencyDataList.firstWhere(
        (item) => item['currency'] == selectedCurrency,
      );
      final rate = selectedCurrencyData['rate'] as double;
      setState(() {
        convertedValue = inrValue * rate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: const Text(
          "Currency Converter",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      CurrencyList(currencyDataList: widget.currencyDataList),
                ),
              );
            },
            icon: const Icon(
              Icons.monetization_on_outlined,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text(
                  "INR",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                Container(
                  width: 100,
                  child: TextField(
                    controller: inrController,
                    style: const TextStyle(color: Colors.white),
                    keyboardType: TextInputType.numberWithOptions(),
                    decoration: InputDecoration(
                      enabled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.white),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                DropdownButton<String>(
                  value: selectedCurrency,
                  dropdownColor: Colors.blue,
                  iconEnabledColor: Colors.white,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedCurrency = newValue;
                    });
                  },
                  items: currencyList
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: const TextStyle(color: Colors.white),
                      ),
                    );
                  }).toList(),
                ),
                Container(
                  height: 50,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.white),
                  ),
                  child: Center(
                    child: Text(
                      convertedValue.toStringAsFixed(2),
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: convertCurrency,
                child: const Text("Convert"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
