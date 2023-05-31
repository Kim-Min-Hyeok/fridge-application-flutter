import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../theme/colorTheme.dart';
import 'package:tab_container/tab_container.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  int _selectedIndex = 0;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late User? _user;
  List<String> _itemTitles = [];

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  Future<void> _getUser() async {
    _user = _auth.currentUser;
    if (_user != null) {
      await _getItems();
    }
  }

  Future<void> _getItems() async {
    QuerySnapshot itemSnapshot = await _firestore
        .collection('items')
        .where('userId', isEqualTo: _user!.uid)
        .get();
    setState(() {
      _itemTitles =
          itemSnapshot.docs.map((doc) => doc['title'] as String).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_user == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

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
              color: ColorStyle.primary,
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
        actions: const [
          SizedBox(
            width: 80,
            child: Center(
              child: Text(
                '냉장고1',
                style: TextStyle(
                    color: ColorStyle.secondary,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
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
                const SizedBox(
                    width: 324,
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
                    icon: const Icon(
                      Icons.search,
                      size: 50,
                      color: ColorStyle.primary,
                    ))
              ],
            ),
            Expanded(
              child: TabContainer(
                tabEdge: TabEdge.bottom,
                color: const Color.fromARGB(255, 221, 221, 221),
                tabs: const [
                  '전체 목록',
                  '곧 상해요',
                  '상했어요',
                ],
                children: [
                  Container(
                    child: const Text('Child 1'),
                  ),
                  Container(
                    child: const Text('Child 2'),
                  ),
                  Container(
                    child: const Text('Child 3'),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 40,
            ),
          ],
        ),
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

  List<Widget> _getChildren1() {
    return _itemTitles.map((title) => Text(title)).toList();
  }
}
