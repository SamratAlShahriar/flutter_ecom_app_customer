import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_ecom_app_customer/pages/main_nav_pages/home_page.dart';
import 'package:flutter_ecom_app_customer/pages/launcher_page.dart';
import 'package:flutter_ecom_app_customer/pages/auth_pages/login_page.dart';
import 'package:flutter_ecom_app_customer/pages/main_nav_pages/nav_page.dart';
import 'package:flutter_ecom_app_customer/pages/order_pages/order_page.dart';
import 'package:flutter_ecom_app_customer/pages/product_pages/product_details_page.dart';
import 'package:flutter_ecom_app_customer/pages/main_nav_pages/user_profile_page.dart';
import 'package:flutter_ecom_app_customer/pages/product_pages/view_product_page.dart';
import 'package:flutter_ecom_app_customer/providers/order_provider.dart';
import 'package:flutter_ecom_app_customer/providers/product_provider.dart';
import 'package:flutter_ecom_app_customer/providers/user_provider.dart';
import 'package:flutter_ecom_app_customer/themes/app_theme.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => OrderProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => ProductProvider(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: appTheme,
      initialRoute: LauncherPage.routeName,
      routes: {
        LauncherPage.routeName: (_) => const LauncherPage(),
        LoginPage.routeName: (_) => const LoginPage(),
        MainNavPage.routeName: (_) => const MainNavPage(),
        UserProfilePage.routeName: (_) => const UserProfilePage(),
        Homepage.routeName: (_) => const Homepage(),
        OrderPage.routeName: (_) => const OrderPage(),
        ProductDetailsPage.routeName: (_) => const ProductDetailsPage(),
        ViewProductPage.routeName: (_) => const ViewProductPage(),
      },
      builder: EasyLoading.init(),
    );
  }
}
