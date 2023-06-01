import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_fridge/model/product.dart';

import '../model/recipe.dart';

class RecipeService {
  static const String baseUrl = 'http://openapi.foodsafetykorea.go.kr/api/db78c7b4db404a198965/COOKRCP01/json/1/1000';


  static Future<List<RecipeModel>> getRecipe() async {
    List<RecipeModel> productInstanses = [];

    final url = Uri.parse("$baseUrl");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      final List<dynamic> products = responseData['COOKRCP01']['row'];
      for (var product in products) {
        final instance = RecipeModel.fromJson(product);
        productInstanses.add(instance);
      }
      print(productInstanses);
      return productInstanses;
    }
    throw Error();
  }
}