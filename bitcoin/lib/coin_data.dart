import 'dart:convert';
import 'package:http/http.dart' as http;

const kApiKey = '38C35D8D-AC06-48B9-A5F6-6247FEE9EB34';
const kApiBegin = 'https://rest.coinapi.io/v1/exchangerate';

const List<String> currenciesList = [
  'USD',
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  Future<double> getData(String coin, String change) async {
    String url = "$kApiBegin/$coin/$change?apikey=$kApiKey";
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var decoded = jsonDecode(response.body);
      double changeValue = decoded['rate'];
      return changeValue;
    } else {
      double changeValue = 0.0;
      return changeValue;
    }
  }
}
