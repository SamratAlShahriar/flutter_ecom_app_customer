import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecom_app_customer/menus/main_drawer.dart';

class Homepage extends StatelessWidget {
  static const String routeName = '/homepage';
  const Homepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: MainDrawer(),
      drawerDragStartBehavior:DragStartBehavior.down,
      drawerEdgeDragWidth: 10,drawerEnableOpenDragGesture: true,
      endDrawer: MainDrawer(),

    );
  }
}
