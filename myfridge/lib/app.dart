import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:my_fridge/page/add.dart';
import 'package:my_fridge/page/login.dart';
import 'package:my_fridge/page/recipe.dart';
import 'package:my_fridge/page/recipe_detail.dart';
import 'package:my_fridge/theme/colorTheme.dart';
import 'package:page_transition/page_transition.dart';
import 'page/expired.dart';
import 'page/list.dart';
import 'page/not_expired.dart';
import 'page/scan.dart';
import 'page/navigation.dart';

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
              nextScreen: const LoginPage(),
              splashTransition: SplashTransition.fadeTransition,
              pageTransitionType: PageTransitionType.fade,
              splashIconSize: 300,
              backgroundColor: ColorStyle.background,
            ),
        '/login': (BuildContext context) => const LoginPage(),
        '/navigation': (BuildContext context) => const NavigationPage(),
        '/list': (BuildContext context) => const ListPage(),
        '/recipe': (BuildContext context) => const RecipePage(),
        '/add': (BuildContext context) => const AddPage(),
        '/recipe_detail': (BuildContext context) => const RecipeDetailPage(),
        '/scan': (BuildContext context) => ScanPage(),
        '/expired': (BuildContext context) => const ExpiredPage(),
        '/notexpired': (BuildContext context) => const NotExpiredPage(),
      },
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
      ),
    );
  }
}
