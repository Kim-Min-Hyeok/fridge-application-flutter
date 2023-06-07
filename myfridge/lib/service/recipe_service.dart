import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_fridge/model/recipe.dart';


class RecipeService {
  static const String baseUrl = 'http://openapi.foodsafetykorea.go.kr/api/db78c7b4db404a198965/COOKRCP01/json/1/1000';


  static Future<List<RecipeModel>> getRecipe() async {
    List<RecipeModel> recipeInstanses = [];

    final url = Uri.parse("$baseUrl");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      final List<dynamic> recipes = responseData['COOKRCP01']['row'];
      for (var recipe in recipes) {
        final instance = RecipeModel.fromJson(recipe);
        recipeInstanses.add(instance);
      }
      print(recipeInstanses);
      return recipeInstanses;
    }
    throw Error();
  }
}