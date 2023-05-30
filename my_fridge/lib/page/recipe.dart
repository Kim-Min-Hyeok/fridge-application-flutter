import 'package:flutter/material.dart';
import 'package:my_fridge/theme/colorTheme.dart';

class RecipePage extends StatefulWidget {
  const RecipePage({super.key});

  @override
  State<RecipePage> createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
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
          '레시피',
          style: TextStyle(
              color: ColorStyle.primary,
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
        actions: [
          Container(
            width: 80,
            child: Center(
              child: Text(
                '냉장고1',
                style: TextStyle(
                  color: ColorStyle.secondary,
                  fontSize: 15,
                ),
              ),
            ),
          ), //나중에 저장된 냉장고 이름으로 바꿔야 함
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          Row(
            children: [
              Container(
                  width: 260,
                  height: 50,
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: ColorStyle
                              .primary, // Set the desired border color
                          width: 3.0, // Set the desired border weight
                        ),
                      ),
                    ),
                  )),
              Container(
                  width: 64,
                  height: 50,
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: ColorStyle
                              .primary, // Set the desired border color
                          width: 3.0, // Set the desired border weight
                        ),
                      ),
                    ),
                  )),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.search,
                    size: 50,
                    color: ColorStyle.primary,
                  ))
            ],
          ),
          Expanded(
            child: ListView(),
          )
        ]),
      ),
      floatingActionButton: ClipOval(
        child: FloatingActionButton.large(
          backgroundColor: ColorStyle.primary,
          onPressed: () {
            Navigator.pushNamed(context, '/add');
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
            size: 80,
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: ColorStyle.background,
        currentIndex: _selectedIndex,
        onTap: (index) {
          switch (index) {
            case 0:
              break;
            case 1:
              break;
            case 2:
              break;
          }
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/images/list.png",
              height: 70,
            ),
            activeIcon: Image.asset(
              "assets/images/list_active.png",
              height: 70,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
              icon: Container(
                height: 50,
              ),
              label: ''),
          BottomNavigationBarItem(
              icon: Image.asset(
                "assets/images/recipe.png",
                height: 70,
              ),
              activeIcon: Image.asset(
                "assets/images/recipe_active.png",
                height: 70,
              ),
              label: ''),
        ],
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
    );
  }
}
