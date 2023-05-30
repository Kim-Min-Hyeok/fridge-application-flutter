import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  addFridge(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        debugPrint('The image button has been tapped');
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
      child: Image.asset(
        'assets/images/add_button.png',
        fit: BoxFit.fitWidth,
      ),
    );
  }

  fridgeAdded(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Ink.image(
        image: const AssetImage('assets/images/fridge1.png'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 1,
        title: const Text(
          '우리집 냉장고',
          style: TextStyle(
            color: Color(0xFF0C4C8A),
            fontWeight: FontWeight.w900,
            fontSize: 30,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 30,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '관리중',
              style: TextStyle(
                color: Color(0xFF9C9899),
                fontWeight: FontWeight.w700,
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 20.0,
                scrollDirection: Axis.vertical,
                primary: true,
                children: [
                  fridgeAdded(context),
                  fridgeAdded(context),
                  addFridge(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
