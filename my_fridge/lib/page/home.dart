import 'package:flutter/material.dart';
import 'package:my_fridge/page/list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<bool> buttonClickedList = List.generate(6, (_) => false);

  void toggleButton(int index) {
    setState(() {
      buttonClickedList[index] = !buttonClickedList[index];
    });
  }

  void navigateToPage(int index) {
    Navigator.pushNamed(context, '/list');
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(
              left: 30,
              top: 30,
            ),
            child: Text('관리중',
                style: TextStyle(fontSize: 40, color: Color(0xfff9c9899))),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(
                vertical: 30,
                horizontal: 30,
              ),
              itemCount: 6,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 40,
                childAspectRatio: 18 / 13,
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    if (!buttonClickedList[index]) {
                      toggleButton(index);
                    } else {
                      navigateToPage(index);
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 183, 183, 183),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: buttonClickedList[index]
                          ? Text(
                              '냉장고 ${index + 1}',
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            )
                          : IconButton(
                              icon: const Icon(
                                Icons.add,
                                size: 40,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                toggleButton(index);
                              },
                            ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
