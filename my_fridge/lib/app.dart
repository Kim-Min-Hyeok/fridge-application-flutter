import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'page/list.dart';
import 'page/home.dart';

class MyFridge extends StatelessWidget {
  const MyFridge({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyFridge',
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => const HomePage(),
        '/list': (BuildContext context) => const ListPage(),
      },
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
      ),
    );
  }
}
