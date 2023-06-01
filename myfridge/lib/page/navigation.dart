import 'package:flutter/material.dart';
import 'list.dart';
import 'recipe.dart';
import '../theme/colorTheme.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int _selectedIndex = 0;

  List<Widget> _widgetOptions = <Widget>[
    ListPage(),
    Container(),
    RecipePage(),
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: _widgetOptions.elementAt(_selectedIndex),
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
