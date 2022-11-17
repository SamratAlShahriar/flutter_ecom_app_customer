import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecom_app_customer/custom_widgets/product_grid_view_item.dart';
import 'package:flutter_ecom_app_customer/providers/product_provider.dart';
import 'package:provider/provider.dart';
import '../../menus/main_drawer.dart';

import '../../themes/font_awesome5_icons.dart';

class Homepage extends StatefulWidget {
  static const String routeName = '/homepage';

  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late ProductProvider productProvider;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    productProvider = Provider.of<ProductProvider>(context);
    productProvider.getAllProducts();
    super.didChangeDependencies();
  }

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
      body:  productProvider.productList.isEmpty
          ? const Center(
        child: Text(
          'No Product Found!',
        ),
      )
          : GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 9/16,
              ),
              itemCount: productProvider.productList.length,
              itemBuilder: (context, index) {
                final product = productProvider.productList[index];
                return ProductGridViewItem(productModel: product);
              },
          ),
    );
  }
}
