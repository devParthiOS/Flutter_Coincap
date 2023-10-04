import 'dart:convert';
import 'package:coincap/services/http_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late double deviceWidth;
  late double deviceHeight;
  late HTTPService http;

  @override
  void initState() {
    http = GetIt.instance.get<HTTPService>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _selectedCoinDropdown(),
            _dataWidget(),
          ],
        ),
      )),
    );
  }

  Widget _selectedCoinDropdown() {
    List<String> coins = ["bitcoin"];
    List<DropdownMenuItem> items = coins.map(
      (e) {
        return DropdownMenuItem<String>(
          value: e,
          child: Text(e,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.w600)),
        );
      },
    ).toList();
    return DropdownButton(
      value: coins.first,
      items: items,
      onChanged: (value) {},
      underline: Container(),
      dropdownColor: const Color.fromRGBO(83, 88, 206, 1.0),
      iconSize: 30,
      icon: const Icon(
        Icons.arrow_drop_down,
        color: Colors.white,
      ),
    );
  }

  Widget _dataWidget() {
    return FutureBuilder(
      future: http.get("coins/bitcoin"),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          Map data = jsonDecode(snapshot.data.toString());
          num usdPrice = data["market_data"]["current_price"]["usd"];
          num change24h =
              data["market_data"]["market_cap_change_percentage_24h"];
          String coinImage = data["image"]["large"];
          String description = data["description"]["en"];
          return Column(
            children: [
              _coinImageWidget(coinImage),
              _currentPriceWidget(usdPrice),
              _percentageChangeWidget(change24h),
              _discriptionCardWidget(description)
            ],
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          );
        }
      },
    );
  }

  Widget _currentPriceWidget(num rate) {
    return Text(
      "${rate.toStringAsFixed(2)}USD",
      style: const TextStyle(
        color: Colors.white,
        fontSize: 30,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Widget _percentageChangeWidget(num change) {
    return Text(
      "${change.toStringAsFixed(2)}USD",
      style: const TextStyle(
        color: Colors.white,
        fontSize: 15,
        fontWeight: FontWeight.w300,
      ),
    );
  }

  Widget _coinImageWidget(String imageUrl) {
    return Container(
      height: deviceHeight * 0.15,
      width: deviceWidth * 0.15,
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.contain, image: NetworkImage(imageUrl))),
    );
  }

  Widget _discriptionCardWidget(String description) {
    return Container(
      color: const Color.fromRGBO(83, 88, 206, 0.5),
      height: deviceHeight * 0.45,
      width: deviceWidth * 0.90,
      padding: EdgeInsets.all(deviceWidth * 0.02),
      margin: EdgeInsets.symmetric(
        vertical: deviceHeight * 0.01,
        horizontal: deviceHeight * 0.01,
      ),
      child: Text(
        description,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
