// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import 'package:my_fridge/theme/colorTheme.dart';
import '../service/barcode_service.dart';
import '../model/barcode.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key, this.restorationId});

  final String? restorationId;

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> with RestorationMixin {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _productController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  String todayDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  late String itemDate;
  late int difference;

  String productName = '';
  List<BarcodeModel> products = [];

  String getProductName(String barcode) {
    for (BarcodeModel product in products) {
      if (product.barcode == barcode) {
        return product.name;
      }
    }
    return '등록된 상품정보가 없습니다.';
  }

  // @override
  // void initState() {
  //   super.initState();
  //   _loadProductData();
  // }

  Future<void> _loadProductData() async {
    try {
      List<BarcodeModel> productList = await BarcodeService.getProduct();
      setState(() {
        products = productList;
      });
    } catch (e) {
      print('Failed to load product data: $e');
    }
  }

  Future<void> _addItem() async {
    User? user = _auth.currentUser;
    if (user != null) {
      String userId = user.uid;

      String product = _productController.text;
      String date = _dateController.text;

      DateTime itemDateConvert = DateTime.parse(itemDate);
      DateTime todayDateConvert = DateTime.parse(todayDate);
      int difference = itemDateConvert.difference(todayDateConvert).inDays;

      try {
        await _firestore.collection('items').add({
          'userId': userId,
          'product': product,
          'date': date,
          'difference': difference,
        });
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Item added successfully'),
          duration: Duration(milliseconds: 900),
        ));
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Failed to add item'),
          duration: Duration(milliseconds: 900),
        ));
        print('Error adding item: $e');
      }
    }
  }

  @override
  String? get restorationId => widget.restorationId;

  final RestorableDateTime _selectedDate = RestorableDateTime(DateTime.now());
  late final RestorableRouteFuture<DateTime?> _restorableDatePickerRouteFuture =
      RestorableRouteFuture<DateTime?>(
    onComplete: _selectDate,
    onPresent: (NavigatorState navigator, Object? arguments) {
      return navigator.restorablePush(
        _datePickerRoute,
        arguments: _selectedDate.value.millisecondsSinceEpoch,
      );
    },
  );

  static Route<DateTime> _datePickerRoute(
    BuildContext context,
    Object? arguments,
  ) {
    return DialogRoute<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return DatePickerDialog(
          restorationId: 'date_picker_dialog',
          initialEntryMode: DatePickerEntryMode.calendar,
          initialDate: DateTime.fromMillisecondsSinceEpoch(arguments! as int),
          firstDate: DateTime(2023),
          lastDate: DateTime(2030),
        );
      },
    );
  }

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_selectedDate, 'selected_date');
    registerForRestoration(
        _restorableDatePickerRouteFuture, 'date_picker_route_future');
  }

  void _selectDate(DateTime? newSelectedDate) {
    if (newSelectedDate != null) {
      setState(() {
        _selectedDate.value = newSelectedDate;
        if (kDebugMode) {
          print(newSelectedDate);
        }
        itemDate = DateFormat('yyyy-MM-dd').format(newSelectedDate);
        _dateController.text = itemDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '상품 추가',
          style: TextStyle(
              color: ColorStyle.primary,
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(
                        left: 20.0,
                        top: 20.0,
                      ),
                      child: Text(
                        '상품명:  ',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: TextButton(
                        child: const Text(
                          '유통기한: ',
                          style: TextStyle(fontSize: 20),
                        ),
                        onPressed: () {
                          _restorableDatePickerRouteFuture.present();
                        },
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Column(
                    children: [
                      SizedBox(
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
                            hintText: "왼쪽 \"유통기한\"을 터치해주세요",
                            fillColor: Colors.grey[200],
                            filled: true,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
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
            child: Image.asset('assets/images/barcode_scanner.png'),
            onTap: () async {
              final result = await Navigator.pushNamed(context, '/scan');
              setState(() {
                _loadProductData().then((_) {
                  if (result != null) {
                    final barcode = result as String;
                    print(barcode);
                    productName = getProductName(barcode);
                    _productController.text = productName;
                  }
                });
              });
            },
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
