import 'package:flutter/material.dart';
import 'package:monexo/screens/categories/categories.dart';

import 'package:monexo/screens/login/login.dart';
import 'package:monexo/screens/main/main.dart';
import 'package:monexo/screens/screens.dart';

Map<String, Widget Function(BuildContext)> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  LoginScreen.routeName: (context) => LoginScreen(),
  ProfileSetupScreen.routeName: (context) => ProfileSetupScreen(),
  CurrencySetupScreen.routeName: (context) => CurrencySetupScreen(),
  MainScreen.routeName: (context) => MainScreen(),
  CategoriesScreen.routeName: (context) => CategoriesScreen(),
};
