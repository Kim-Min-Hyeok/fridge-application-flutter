import 'package:flutter/material.dart';
import 'package:my_fridge/theme/colorTheme.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '상품명:  ',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 15,),
                  const Text(
                    '유통기한: ',
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    width: 300,
                    height: 40,
                    child: TextField(
                      decoration: InputDecoration(
                        fillColor: Colors.grey[200],
                        filled: true,
                      ),
                    ),
                  ),
                  SizedBox(height: 15,),
                  Container(
                    width: 300,
                    height: 40,
                    child: TextField(
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
          const SizedBox(height:30),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            }, 
            child: Text('저장',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorStyle.primary
            )
          ),
          const SizedBox(height: 50,),
          GestureDetector(
            child: Container(
              child: Image.asset('assets/images/barcode_scanner.png'),
            ),
            onTap: () {
            },
          )
        ]),
      ),
    );
  }
}
