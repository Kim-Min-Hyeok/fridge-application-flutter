import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:my_fridge/theme/colorTheme.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _productController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  Future<void> _addItem() async {
    User? user = _auth.currentUser;
    if (user != null) {
      String userId = user.uid;

      String product = _productController.text;
      String date = _dateController.text;

      try {
        await _firestore.collection('items').add({
          'userId': userId,
          'product': product,
          'date': date,
        });
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Item added successfully'),
        ));
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Failed to add item'),
        ));
        print('Error adding item: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
          '상품 추가',
          style: TextStyle(
              color: ColorStyle.primary,
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(children: [
          Row(
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '상품명:  ',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    '유통기한: ',
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
              Column(
                children: [
                  SizedBox(
                    width: 300,
                    height: 40,
                    child: TextField(
                      controller: _productController,
                      decoration: InputDecoration(
                        fillColor: Colors.grey[200],
                        filled: true,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    width: 300,
                    height: 40,
                    child: TextField(
                      controller: _dateController,
                      decoration: InputDecoration(
                        fillColor: Colors.grey[200],
                        filled: true,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
          const SizedBox(height: 30),
          ElevatedButton(
              onPressed: () {
                _addItem();
                Navigator.pop(context);
              },
              style:
                  ElevatedButton.styleFrom(backgroundColor: ColorStyle.primary),
              child: const Text(
                '저장',
                style: TextStyle(
                  color: Colors.white,
                ),
              )),
          const SizedBox(
            height: 50,
          ),
          GestureDetector(
            child: Container(
              child: Image.asset('assets/images/barcode_scanner.png'),
            ),
            onTap: () {
              Navigator.pushNamed(context, '/scan');
            },
          )
        ]),
      ),
    );
  }
}
