// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import '../model/product.dart';
import '../theme/colorTheme.dart';
import '../util/auth.dart';

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  final int _selectedIndex = 0;
  String searchText = "";
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
        title: const Text(
          '상품목록',
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
        child: Column(
          children: [
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
                    hintText: '제품명 검색...',
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
                      String documentId = document.id;

                      String todayDate =
                          DateFormat('yyyy-MM-dd').format(DateTime.now());

                      int daysDifference = DateTime.parse(expiryDate)
                          .difference(DateTime.parse(todayDate))
                          .inDays;
                      return Product(
                        product: productName,
                        date: expiryDate,
                        userUid: userId,
                        documentId: documentId,
                        difference: daysDifference,
                      );
                    }).toList();

                    return ListView.builder(
                      itemCount: productList.length,
                      itemBuilder: (BuildContext context, int index) {
                        Product product = productList[index];

                        if (searchText.isEmpty) {
                          return Dismissible(
                            key: Key(product
                                .documentId), // Unique key for each list item
                            background: Container(
                              color: Colors.red,
                              alignment: Alignment.centerRight,
                              child: const Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            direction: DismissDirection.endToStart,
                            onDismissed: (direction) async {
                              // Remove the item from the list
                              setState(() {
                                productList.removeAt(index);
                              });

                              // Show a snackbar to indicate item deletion
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Item deleted'),
                                  duration: Duration(milliseconds: 900),
                                ),
                              );

                              // Delete item from Firebase database
                              await items.doc(product.documentId).delete();
                            },
                            child: ListTile(
                              title: Text(product.product),
                              subtitle: Text(product.date),
                            ),
                          );
                        }
                        if (product.product
                            .toString()
                            .startsWith(searchText.toLowerCase())) {
                          return ListTile(
                            title: Text(product.product),
                            subtitle: Text(product.date),
                          );
                        }
                        return Container();
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
    );
  }
}
