import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../env/secrets.dart' as secrets;
import '../../models/models.dart';

class CryptoCurrencyRepository {
  Future<List<CryptoCurrency>> getListing() async {
    var uri = Uri.parse('${secrets.sandboxUri}?start=1&limit=20');

    var response = await http.get(uri, headers: {
      secrets.header: secrets.sandboxApiKey,
    });

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body) as Map<String, dynamic>;
      var data = json['data'] as List;

      List<CryptoCurrency> cryptocurrencies = data.map((e) {
        return CryptoCurrency.fromJSON(e as Map<String, dynamic>);
      }).toList();
      return cryptocurrencies;
    } else {
      throw RequestFailedError();
    }
  }
}

class RequestFailedError implements Exception {}
