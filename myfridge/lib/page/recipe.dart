import 'package:flutter/material.dart';
import 'package:my_fridge/theme/colorTheme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../util/auth.dart';

import '../model/recipe.dart';
import '../service/recipe_service.dart';

class RecipePage extends StatefulWidget {
  const RecipePage({super.key});

  @override
  State<RecipePage> createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  final int _selectedIndex = 2;
  String searchText = "";
  int searchNum = 0;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;

  @override
  void initState() {
    super.initState();
    _user = _auth.currentUser;
  }

  List<String> getRecipeFromSnapshot(
      AsyncSnapshot<List<RecipeModel>> snapshot, List<String> items) {
    List<String> matchedMenus = [];
    if (snapshot.hasData) {
      List<RecipeModel> recipes = snapshot.data!;

      for (var item in items) {
        for (var recipe in recipes) {
          if (recipe.ingredients.contains(item)) {
            matchedMenus.add(recipe.menu);
          }
        }
      }

      matchedMenus.sort((a, b) {
        var countA = 0;
        var countB = 0;
        for (var item in items) {
          if (a.contains(item)) countA++;
          if (b.contains(item)) countB++;
        }
        return countB.compareTo(countA);
      });
    }
    if (matchedMenus == null) {
      matchedMenus.add('일치하는 레시피가 없어요');
    }
    return matchedMenus;
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference items = FirebaseFirestore.instance.collection('items');

    if (_user == null) {
      return const Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.white,
          color: Color(0xffff0c4c8a),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorStyle.background,
        title: const Text(
          '레시피',
          style: TextStyle(
              color: ColorStyle.primary,
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          IconButton(
              onPressed: () async {
                await Authentication().signOut();
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('로그아웃 되었습니다'),
                  duration: Duration(milliseconds: 900),
                ));
                Navigator.pushNamedAndRemoveUntil(
                    context, '/login', (route) => false);
              },
              icon: const Icon(
                Icons.logout,
              ))
        ],
      ),
      drawer: SizedBox(
        width: MediaQuery.of(context).size.width * 0.6,
        child: Drawer(
          backgroundColor: Colors.white,
          surfaceTintColor: const Color.fromARGB(255, 233, 233, 233),
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              FutureBuilder<User?>(
                future: FirebaseAuth.instance.authStateChanges().first,
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data != null) {
                    final user = snapshot.data!;
                    final photoUrl = user.photoURL;
                    final name = user.displayName;
                    final email = user.email;

                    return UserAccountsDrawerHeader(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      accountName: Text(
                        name!,
                        style: const TextStyle(
                          color: ColorStyle.secondary,
                        ),
                      ),
                      accountEmail: Text(
                        email!,
                        style: const TextStyle(
                          color: ColorStyle.secondary,
                        ),
                      ),
                      currentAccountPicture: CircleAvatar(
                        backgroundColor: Colors.white,
                        backgroundImage: NetworkImage(photoUrl!),
                      ),
                    );
                  }

                  return const SizedBox
                      .shrink(); // Return an empty SizedBox if data is null
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.home,
                  size: 35,
                  color: ColorStyle.primary,
                ),
                title: const Text(
                  '안상했어요',
                  style: TextStyle(
                    color: ColorStyle.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/notexpired');
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.home,
                  size: 35,
                  color: ColorStyle.primary,
                ),
                title: const Text(
                  '상했어요',
                  style: TextStyle(
                    color: ColorStyle.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/expired');
                },
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(children: [
          SizedBox(
            height: 50,
            child: Expanded(
              child: TextField(
                textAlignVertical: TextAlignVertical.bottom,
                onChanged: (value) {
                  setState(() {
                    searchText = value;
                  });
                },
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: '레시피 검색...',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: ColorStyle.primary,
                      width: 3.0,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
                stream:
                    items.where('userId', isEqualTo: _user!.uid).snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (!snapshot.hasData) {
                    return const Text('사용자 정보 불러오기 실패');
                  } else {
                    List<String> productList =
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                          document.data() as Map<String, dynamic>;
                      String productName = data['product'];
                      return productName;
                    }).toList();

                    return FutureBuilder<List<RecipeModel>>(
                        future: RecipeService.getRecipe(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (!snapshot.hasData) {
                            return const Text('레시피 정보 불러오기 실패');
                          } else {
                            List<String> menuList =
                                getRecipeFromSnapshot(snapshot, productList);
                            return ListView.builder(
                                itemCount: menuList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  String menu = menuList[index];

                                  if (searchText.isEmpty) {
                                    ListTile(
                                      title: Text(menu),
                                    );
                                  }
                                  if (menu
                                      .startsWith(searchText.toLowerCase())) {
                                    return ListTile(
                                      title: Text(menu),
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, '/recipe_detail',
                                            arguments: menu);
                                      },
                                    );
                                  }
                                  return Container();
                                });
                          }
                        });
                  }
                }),
          ),
          const SizedBox(
            height: 40,
          ),
        ]),
      ),
    );
  }
}
