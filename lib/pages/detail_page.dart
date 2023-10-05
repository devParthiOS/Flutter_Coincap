import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  Map pricelist;
  DetailPage({required this.pricelist, super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late List _currency;
  late List _rate;
  @override
  void initState() {
    _currency = widget.pricelist.keys.toList();
    _rate = widget.pricelist.values.toList();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: _currency.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text("${_currency[index]} : ${_rate[index]}"),
          );
        },
      ),
    );
  }
}
