import 'package:flutter/material.dart';
import 'package:my_fridge/Theme/colorTheme.dart';


class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
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
        title: const Text('상품목록',
            style: TextStyle(
              color: Color.fromRGBO(25, 63, 128, 100),
              fontSize: 20,
              fontWeight: FontWeight.bold
            ),
        ),
        actions: [
          Container(
            width: 80,
            child: Center(
              child: Text('냉장고1',
                style: TextStyle(
                  color: ColorStyle.secondary,
                  fontSize: 15,
                ),
              ),
            ),
          ), //나중에 저장된 냉장고 이름으로 바꿔야 함
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Image.asset("assets/images/list.png"),
            activeIcon: Image.asset("assets/images/list_active.png"),
            label: ''
          ),
          BottomNavigationBarItem(
            icon: Image.asset("assets/images/recipe.png"),
            activeIcon: Image.asset("assets/images/recipe.png"),
            label: ''
          ),
        ]
      ),
    );
  }
}
