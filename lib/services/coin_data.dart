import 'dart:convert';
import 'package:http/http.dart' as http;

const List<String> currenciesList = [
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
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const apiKey = '182190A6-F5C7-46A1-8359-FFB3E401A123';
const openCoinDataURL = 'https://rest.coinapi.io/v1/exchangerate';

class CoinData {
  // created Asynchronous method that will return a Future(price).
  Future getCoinData(String selectedCurrency) async {
    //loop through cryptoList to request data for each and
    //return Map of results
    Map<String, String> cryptoPrices = {};

    for (String crypto in cryptoList) {
      // update URL to use crypto symbol in cryptoList
      String requestURL =
          '$openCoinDataURL/$crypto/$selectedCurrency?apikey=$apiKey';
      http.Response response = await http.get(requestURL);

      //make sure request is successful
      if (response.statusCode == 200) {
        // used 'dart:convert' package to decode JSON data
        var decodedData = jsonDecode(response.body);
        // Retrieved last price
        double lastPrice = decodedData['rate'];
        // create new key value pair crypto symbol and value being lastPrice
        cryptoPrices[crypto] = lastPrice.toStringAsFixed(0);
      } else {
        print(response.statusCode);

        throw 'Failed get request';
      }
    }
    return cryptoPrices;
  }
}
