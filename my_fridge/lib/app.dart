

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
        '/':(BuildContext context) => HomePage(),
        '/list':(BuildContext context) => ListPage(),
      },
    );
  }
}