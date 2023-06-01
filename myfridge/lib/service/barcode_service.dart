import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_fridge/model/product.dart';

import '../model/barcode.dart';


class BarcodeService {
  static const String baseUrl = 'http://openapi.foodsafetykorea.go.kr/api/db78c7b4db404a198965/C005/json/1/1000';


  static Future<List<BarcodeModel>> getProduct() async {
    List<BarcodeModel> productInstanses = [];

    final url = Uri.parse("$baseUrl");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      final List<dynamic> products = responseData['C005']['row'];
      for (var product in products) {
        final instance = BarcodeModel.fromJson(product);
        productInstanses.add(instance);
      }
      print(productInstanses);
      return productInstanses;
    }
    throw Error();
  }
}