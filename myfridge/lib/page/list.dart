import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/product.dart';
import '../theme/colorTheme.dart';

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  int _selectedIndex = 0;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;

  @override
  void initState() {
    super.initState();
    _user = _auth.currentUser;
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
          ),
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
                          color: ColorStyle.primary,
                          width: 3.0,
                        ),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.search,
                    size: 50,
                    color: ColorStyle.primary,
                  ),
                ),
              ],
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                // Fetching data from the 'items' collection
                stream:
                    items.where('userId', isEqualTo: _user!.uid).snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  // Error Handling conditions
                  if (snapshot.hasError) {
                    return const Text("Something went wrong");
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  // Data is output to the user
                  if (snapshot.hasData) {
                    List<Product> productList =
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                          document.data() as Map<String, dynamic>;
                      String productName = data['product'];
                      String expiryDate = data['date'];
                      String userId = data['userId'];
                      return Product(
                        product: productName,
                        date: expiryDate,
                        userUid: userId,
                      );
                    }).toList();

                    return ListView.builder(
                      itemCount: productList.length,
                      itemBuilder: (BuildContext context, int index) {
                        Product product = productList[index];
                        return ListTile(
                          title: Text(product.product),
                          subtitle: Text(product.date),
                        );
                      },
                    );
                  }

                  return const Text("No data available");
                },
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
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/images/recipe.png",
              height: 70,
            ),
            activeIcon: Image.asset(
              "assets/images/recipe_active.png",
              height: 70,
            ),
            label: '',
          ),
        ],
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
    );
  }
}
