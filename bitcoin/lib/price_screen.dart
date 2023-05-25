import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import 'package:bitcoin/coin_data.dart';

class PriceScreen extends StatefulWidget {
  const PriceScreen({super.key});

  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';

  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> dropDownItems = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        value: currency,
        child: Text(currency),
      );
      dropDownItems.add(newItem);
    }
    return DropdownButton<String>(
      items: dropDownItems,
      value: selectedCurrency,
      onChanged: (value) {
        setState(
          () {
            selectedCurrency = value!;
            getDataCoin();
          },
        );
      },
    );
  }

  Widget iOSPicker() {
    List<Text> cupertinoItems = [];
    for (String currency in currenciesList) {
      cupertinoItems.add(Text(currency));
    }
    return CupertinoPicker(
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        setState(
          () {
            selectedCurrency = currenciesList[selectedIndex];
            getDataCoin();
          },
        );
      },
      backgroundColor: Colors.lightBlue,
      children: cupertinoItems,
    );
  }

  String bitcoinValue = 'USD';
  String ethcoinValue = 'USD';
  String ltccoinValue = 'USD';

  void getDataCoin() async {
    try {
      double bitcoinData = await CoinData().getData('BTC', selectedCurrency);
      double ethcoinData = await CoinData().getData('ETH', selectedCurrency);
      double ltccoinData = await CoinData().getData('LTC', selectedCurrency);
      setState(() {
        bitcoinValue = bitcoinData.toStringAsFixed(0);
        print(bitcoinValue);
        ethcoinValue = ethcoinData.toStringAsFixed(0);
        ltccoinValue = ltccoinData.toStringAsFixed(0);
      });
    } on Exception catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getDataCoin();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                child: Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: CoinValueText('BTC', selectedCurrency, bitcoinValue),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                child: Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: CoinValueText('ETH', selectedCurrency, ethcoinValue),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                child: Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: CoinValueText('LTC', selectedCurrency, ltccoinValue),
                  ),
                ),
              ),
            ],
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: const EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iOSPicker() : androidDropdown(),
          ),
        ],
      ),
    );
  }

  Text CoinValueText(String valuta, String cambio, String valore) {
    return Text(
      '1 $valuta = $valore $cambio',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 20.0,
        color: Colors.white,
      ),
    );
  }
}


// url_example = 'rest.coinapi.io/v1/exchangerate/BTC/USD?apikey=$kApiKey';