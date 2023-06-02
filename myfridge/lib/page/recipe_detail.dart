import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import 'package:my_fridge/theme/colorTheme.dart';
import '../model/recipe.dart';
import '../service/recipe_service.dart';

class RecipeDetailPage extends StatelessWidget {
  const RecipeDetailPage({super.key});

  RecipeModel? getProductNameFromSnapshot(
      AsyncSnapshot<List<RecipeModel>> snapshot, String menu) {
    if (snapshot.hasData) {
      List<RecipeModel> recipes = snapshot.data!;
      RecipeModel? matchedRecipe = recipes.firstWhereOrNull(
        (recipe) => recipe.menu == menu,
      );
      if (matchedRecipe != null) {
        return matchedRecipe;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final String? menu = ModalRoute.of(context)!.settings.arguments as String?;

    return FutureBuilder<List<RecipeModel>>(
        future: RecipeService.getRecipe(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: ColorStyle.background,
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: ColorStyle.primary,
                  ),
                ),
                title: const Text(
                  '레시피 정보',
                  style: TextStyle(
                      color: ColorStyle.primary,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              body: const Center(child: CircularProgressIndicator()),
            );
          } else if (!snapshot.hasData) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: ColorStyle.background,
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: ColorStyle.primary,
                  ),
                ),
                title: const Text(
                  '레시피 정보',
                  style: TextStyle(
                      color: ColorStyle.primary,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              body: const Center(child: Text('레시피 정보를 불러오지 못했습니다')),
            );
          } else {
            final recipeIfo = getProductNameFromSnapshot(snapshot, menu!);
            return Scaffold(
              appBar: AppBar(
                backgroundColor: ColorStyle.background,
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: ColorStyle.primary,
                  ),
                ),
                title: Text(
                  recipeIfo!.menu,
                  style: const TextStyle(
                      color: ColorStyle.primary,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(recipeIfo.imageUrl),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      '재료',
                      style: const TextStyle(
                          color: ColorStyle.primary,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    Divider(
                      height: 5,
                      color: ColorStyle.primary,
                    ),
                    SizedBox(height: 10,),
                    Text(recipeIfo.ingredients),
                    SizedBox(
                      height:40,
                    ),
                    Text(
                      '조리 방법',
                      style: const TextStyle(
                          color: ColorStyle.primary,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    Divider(
                      height: 5,
                      color: ColorStyle.primary,
                    ),
                    Expanded(
                      child: ListView(
                        children: [
                          ListTile(
                            title: Text(recipeIfo.manual1),
                          ),
                          ListTile(
                            title: Text(recipeIfo.manual2),
                          ),
                          ListTile(
                            title: Text(recipeIfo.manual3),
                          ),
                          ListTile(
                            title: Text(recipeIfo.manual4),
                          ),
                          ListTile(
                            title: Text(recipeIfo.manual5),
                          ),
                          ListTile(
                            title: Text(recipeIfo.manual6),
                          ),
                          ListTile(
                            title: Text(recipeIfo.manual7),
                          ),
                          ListTile(
                            title: Text(recipeIfo.manual8),
                          ),
                          ListTile(
                            title: Text(recipeIfo.manual9),
                          ),
                          ListTile(
                            title: Text(recipeIfo.manual10),
                          ),
                          ListTile(
                            title: Text(recipeIfo.manual11),
                          ),
                          ListTile(
                            title: Text(recipeIfo.manual12),
                          ),
                          ListTile(
                            title: Text(recipeIfo.manual13),
                          ),
                          ListTile(
                            title: Text(recipeIfo.manual14),
                          ),
                          ListTile(
                            title: Text(recipeIfo.manual15),
                          ),
                          ListTile(
                            title: Text(recipeIfo.manual16),
                          ),
                          ListTile(
                            title: Text(recipeIfo.manual17),
                          ),
                          ListTile(
                            title: Text(recipeIfo.manual18),
                          ),
                          ListTile(
                            title: Text(recipeIfo.manual19),
                          ),
                          ListTile(
                            title: Text(recipeIfo.manual20),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          }
        });
  }
}
