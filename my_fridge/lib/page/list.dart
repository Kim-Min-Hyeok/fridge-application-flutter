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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                    width: 324,
                    height: 50,
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: ColorStyle.primary, // Set the desired border color
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
              child: Stack(
                children: [
                  ListView(
            
                  ),
                  Positioned(
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            child: Text(
                              '곧 상해요  0',
                              style: TextStyle(
                                fontSize: 20
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            child: Text(
                              '상했어요  0',
                              style: TextStyle(
                                fontSize: 20
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  )
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: AnimatedBottomNavigationBar(
        barColor: Colors.white,
        controller: FloatingBottomBarController(initialIndex: 0),
        bottomBar: [
          BottomBarItem(
              icon: Image.asset(
                "assets/images/list.png",
                height: 50,
              ),
              iconSelected: Image.asset(
                "assets/images/list_active.png",
                height: 50,
              ),
              onTap: (value) {
                setState(() {
                  _selectedIndex = value;
                });
              }),
          BottomBarItem(
              icon: Image.asset(
                "assets/images/recipe.png",
                height: 50,
              ),
              iconSelected: Image.asset(
                "assets/images/recipe_active.png",
                height: 50,
              ),
              onTap: (value) {
                setState(() {
                  _selectedIndex = value;
                });
              }),
        ],
        bottomBarCenterModel: BottomBarCenterModel(
            centerBackgroundColor: Colors.black12,
            centerIcon: FloatingCenterButton(
              child: Image.asset('assets/images/plus.png'),
            ),
            centerIconChild: [
              FloatingCenterButtonChild(
                child: Image.asset('assets/images/barcode_scanner.png'),
              ),
            ]),
      ),
    );
  }
}
