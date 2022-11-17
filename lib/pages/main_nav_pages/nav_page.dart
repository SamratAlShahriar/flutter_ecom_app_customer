import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecom_app_customer/pages/auth_pages/login_page.dart';
import 'package:flutter_ecom_app_customer/pages/main_nav_pages/home_page.dart';
import 'package:flutter_ecom_app_customer/pages/main_nav_pages/user_profile_page.dart';
import 'package:flutter_ecom_app_customer/pages/product_pages/search_page.dart';
import 'package:flutter_ecom_app_customer/pages/product_pages/view_product_page.dart';
import 'package:flutter_ecom_app_customer/themes/font_awesome5_icons.dart';
import 'package:provider/provider.dart';

import '../../providers/order_provider.dart';
import '../../providers/product_provider.dart';
import '../../providers/user_provider.dart';
import '../order_pages/wishlist_page.dart';

class MainNavPage extends StatefulWidget {
  static const String routeName = '/main_nav';

  const MainNavPage({Key? key}) : super(key: key);

  @override
  State<MainNavPage> createState() => _MainNavPageState();
}

class _MainNavPageState extends State<MainNavPage> {
  int _selectedIndex = 0;
  late GlobalKey<ScaffoldState> _sKey;
  late PageController _pageController;

  @override
  void initState() {
    // TODO: implement initState
    _sKey = GlobalKey<ScaffoldState>();
    _pageController = PageController();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    Provider.of<ProductProvider>(context, listen: false).getAllCategories();
    Provider.of<ProductProvider>(context, listen: false).getAllProducts();
    Provider.of<OrderProvider>(context, listen: false).getOrderConstants();
    Provider.of<UserProvider>(context, listen: false).getUserInfo();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _sKey,
      bottomNavigationBar: _bottomNavBar(),
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _selectedIndex = index);
          },
          children: const [
            Homepage(),
            SearchPage(),
            WishListPage(),
            UserProfilePage(),
          ],
        ),
      ),
    );
  }

  BottomNavyBar _bottomNavBar() {
    return BottomNavyBar(
      selectedIndex: _selectedIndex,
      iconSize: 20,
      onItemSelected: (index) => setState(() {
        _selectedIndex = index;
        _pageController.animateToPage(index,
            duration: const Duration(milliseconds: 300), curve: Curves.ease);
      }),
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      items: [
        BottomNavyBarItem(
            icon: const Icon(FontAwesome5.home_2),
            title: const Text('Home'),
            activeColor: Colors.red,
            inactiveColor: Colors.grey),
        BottomNavyBarItem(
          icon: const Icon(FontAwesome5.search_2),
          title: const Text('Search'),
        ),
        BottomNavyBarItem(
          icon: const Icon(FontAwesome5.heart_1),
          title: const Text('Wishlist'),
        ),
        BottomNavyBarItem(
          icon: const Icon(
            FontAwesome5.user_alt,
          ),
          title: const Text('Login'),
        ),
      ],
    );
  }
}
