import 'package:flutter/material.dart';
import 'package:flutter_ecom_app_customer/database/auth/auth_service.dart';
import 'package:flutter_ecom_app_customer/pages/launcher_page.dart';
import 'package:flutter_ecom_app_customer/themes/font_awesome5_icons.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          IconButton(onPressed: () {
            AuthService.logout().then((value) {
              Navigator.pushReplacementNamed(context, LauncherPage.routeName);
            });
          }, icon: Icon(FontAwesome5.sign_out_alt))
        ],
      ),
    );
  }
}
