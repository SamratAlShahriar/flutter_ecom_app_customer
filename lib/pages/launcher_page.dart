import 'package:flutter/material.dart';
import 'package:flutter_ecom_app_customer/pages/main_nav_pages/home_page.dart';
import 'package:flutter_ecom_app_customer/pages/main_nav_pages/nav_page.dart';


import '../database/auth/auth_service.dart';
import 'auth_pages/login_page.dart';

class LauncherPage extends StatelessWidget {
  static const String routeName = '/';

  const LauncherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () {
      if (AuthService.currentUser != null) {
        Navigator.pushReplacementNamed(context, MainNavPage.routeName);
      } else {
        Navigator.pushReplacementNamed(context, LoginPage.routeName);
      }
    });

    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
