import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:my_fridge/theme/colorTheme.dart';
import 'package:page_transition/page_transition.dart';
import 'page/list.dart';
import 'page/home.dart';

class MyFridge extends StatelessWidget {
  const MyFridge({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyFridge',
      //initialRoute: '/',
      routes: {
        '/': (BuildContext context) => AnimatedSplashScreen(
        duration: 2000,
        splash: Image.asset('assets/images/splash.png'),
        nextScreen: const HomePage(),
        splashTransition: SplashTransition.fadeTransition,
        pageTransitionType: PageTransitionType.fade,
        splashIconSize: 300,
        backgroundColor: ColorStyle.background,
      ),
        '/home': (BuildContext context) => const HomePage(),
        '/list': (BuildContext context) => const ListPage(),
      },
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
      ),
    );
  }
}
