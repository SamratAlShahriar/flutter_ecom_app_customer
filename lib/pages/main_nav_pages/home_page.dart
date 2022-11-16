import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../menus/main_drawer.dart';

import '../../themes/font_awesome5_icons.dart';

class Homepage extends StatelessWidget {
  static const String routeName = '/homepage';

  const Homepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            FontAwesome5.align_left,
            color: Colors.deepOrange,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(FontAwesome5.shopping_cart_1),
            color: Theme.of(context).colorScheme.primary,
          )
        ],
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: Container(),
    );
  }
}
