import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/product.dart';

class NotExpiredPage extends StatefulWidget {
  const NotExpiredPage({Key? key}) : super(key: key);

  @override
  State<NotExpiredPage> createState() => _NotExpiredPageState();
}

class _NotExpiredPageState extends State<NotExpiredPage> {
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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Not Expired Items'),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: items.where('userId', isEqualTo: _user?.uid).get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasData) {
            List<Product> expiredItems = snapshot.data!.docs
                .map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data() as Map<String, dynamic>;
                  String productName = data['product'];
                  String expiryDate = data['date'];
                  String userId = data['userId'];
                  String documentId = document.id;
                  int difference = data['difference'] ?? 0;

                  if (difference > 0) {
                    return Product(
                      product: productName,
                      date: expiryDate,
                      userUid: userId,
                      documentId: documentId,
                      difference: difference,
                    );
                  } else {
                    return null;
                  }
                })
                .whereType<Product>()
                .toList();

            if (expiredItems.isEmpty) {
              return const Center(child: Text('None.'));
            }

            return ListView.builder(
              itemCount: expiredItems.length,
              itemBuilder: (BuildContext context, int index) {
                Product product = expiredItems[index];
                return ListTile(
                  title: Text(product.product),
                  subtitle: Text(product.date),
                  trailing: Text('${product.difference} day(s)'),
                );
              },
            );
          }

          return const Text('No data available');
        },
      ),
    );
  }
}
