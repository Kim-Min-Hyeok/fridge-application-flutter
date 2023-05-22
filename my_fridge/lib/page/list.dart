import 'package:flutter/material.dart';
import 'package:my_fridge/Theme/colorTheme.dart';
import 'package:floating_bottom_bar/animated_bottom_navigation_bar.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
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
          '상품목록',
          style: TextStyle(
              color: Color.fromRGBO(25, 63, 128, 100),
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
      body: Column(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 100,
              child: Row(
                children: [
                  ElevatedButton(
                    onPressed: () {  },
                    child: Image.asset(
                      "assets/images/list_active.png",
                      width: 80,
                    ),
                  ),
                  const SizedBox(width: 100,),
                  ElevatedButton(
                    onPressed: () {  },
                    child: Image.asset(
                      "assets/images/recipe.png",
                      width: 80,
                    ),
                  ),
                ],
              ),
            )
          )
        ],
      ),
      bottomNavigationBar: AnimatedBottomNavigationBar(
        barColor: Colors.white,
        controller: FloatingBottomBarController(initialIndex: 0),
        bottomBar: [
          BottomBarItem(
            icon: Image.asset(
                      "assets/images/list.png",
                      width: 80,
                    ),
            iconSelected: Image.asset(
                      "assets/images/list_active.png",
                      width: 80,
                    ),
            title: 'list',
            onTap: (value) {
              setState(() {
                _selectedIndex = value;
              });
            }
          ),
          BottomBarItem(
            icon: Image.asset(
                      "assets/images/recipe.png",
                      width: 80,
                    ),
            iconSelected: Image.asset(
                      "assets/images/recipe_active.png",
                      width: 80,
                    ),
            title: 'recipe',
            onTap: (value) {
              setState(() {
                _selectedIndex = value;
              });
            }
          ),
        ],
        bottomBarCenterModel: BottomBarCenterModel(
          centerBackgroundColor: Colors.white,
          centerIcon: FloatingCenterButton(
            child: Image.asset('assets/images/plus.png'),
          ),
          centerIconChild: [
            FloatingCenterButtonChild(
            child: Image.asset('assets/images/barcode_scanner.png'),
            ),
          ]
        ),
      ),
    );
  }
}
