import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecom_app_customer/database/auth/auth_service.dart';
import 'package:flutter_ecom_app_customer/models/address_model.dart';
import 'package:flutter_ecom_app_customer/models/user_model.dart';
import 'package:flutter_ecom_app_customer/pages/auth_pages/login_page.dart';
import 'package:flutter_ecom_app_customer/providers/user_provider.dart';
import 'package:flutter_ecom_app_customer/themes/font_awesome5_icons.dart';
import 'package:provider/provider.dart';

import '../../utils/widget_functions.dart';
import '../auth_pages/phone_otp_verify_page.dart';

class UserProfilePage extends StatefulWidget {
  static const String routeName = '/profile';

  const UserProfilePage({Key? key}) : super(key: key);

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  late UserProvider userProvider;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    userProvider = Provider.of<UserProvider>(context);
    userProvider.getUserInfo();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    //if user is anonymous
    if (AuthService.currentUser != null &&
        AuthService.currentUser!.isAnonymous) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Please login/register to continue',
              style: TextStyle(
                fontSize: 22,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, LoginPage.routeName);
                },
                child: const Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
                  child: Text('Login'),
                )),
          ],
        ),
      );
    }
    return userProvider.userModel == null
        ? const Center(
            child: Text('Failed to load user data'),
          )
        : ListView(
            children: [
              _headerSection(context, userProvider),
              ListTile(
                leading: const Icon(FontAwesome5.phone_2),
                title: Text(userProvider.userModel!.phone ?? 'Not set yet'),
                trailing: IconButton(
                  onPressed: () {
                    showSingleTextInputDialog(
                      context: context,
                      title: 'Mobile Number',
                      hint: 'With country code (e.g. +88)',
                      onSubmit: (value) {
                        Navigator.pushNamed(
                            context, OtpVerificationPage.routeName,
                            arguments: value);
                      },
                    );
                  },
                  icon: const Icon(Icons.edit),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.calendar_month),
                title: Text(
                    userProvider.userModel!.dob.toString() ?? 'Not set yet'),
                subtitle: const Text('Date of Birth'),
                trailing: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.edit),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.person),
                title: Text(userProvider.userModel!.gender ?? 'Not set yet'),
                subtitle: const Text('Gender'),
                trailing: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.edit),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.location_city),
                title: Text(
                    userProvider.userModel!.addressModel?.addressLine1 ??
                        'Not set yet'),
                subtitle: const Text('Address Line 1'),
                trailing: IconButton(
                  onPressed: () {
                    showSingleTextInputDialog(
                      context: context,
                      title: 'Address Line 1',
                      onSubmit: (value) {
                        userProvider.updateUserProfileField(
                          '$userFieldUserAddress.$addressFieldAddressLine2',
                          value,
                        );
                      },
                    );
                  },
                  icon: const Icon(Icons.edit),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.location_city),
                title: Text(
                    userProvider.userModel!.addressModel?.addressLine2 ??
                        'Not set yet'),
                subtitle: const Text('Address Line 2'),
                trailing: IconButton(
                  onPressed: () {
                    showSingleTextInputDialog(
                      context: context,
                      title: 'Address Line 2',
                      onSubmit: (value) {
                        userProvider.updateUserProfileField(
                          '$userFieldUserAddress.$addressFieldAddressLine2',
                          value,
                        );
                      },
                    );
                  },
                  icon: const Icon(Icons.edit),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.location_city),
                title: Text(userProvider.userModel!.addressModel?.city ??
                    'Not set yet'),
                subtitle: const Text('City'),
                trailing: IconButton(
                  onPressed: () {
                    showSingleTextInputDialog(
                      context: context,
                      title: 'City',
                      onSubmit: (value) {
                        userProvider.updateUserProfileField(
                          '$userFieldUserAddress.$addressFieldCity',
                          value,
                        );
                      },
                    );
                  },
                  icon: const Icon(Icons.edit),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.location_city),
                title: Text(userProvider.userModel!.addressModel?.zipCode ??
                    'Not set yet'),
                subtitle: const Text('Zip Code'),
                trailing: IconButton(
                  onPressed: () {
                    showSingleTextInputDialog(
                      context: context,
                      title: 'Zip Code',
                      onSubmit: (value) {
                        userProvider.updateUserProfileField(
                          '$userFieldUserAddress.$addressFieldZipCode',
                          value,
                        );
                      },
                    );
                  },
                  icon: const Icon(Icons.edit),
                ),
              ),
            ],
          );
  }

  Container _headerSection(BuildContext context, UserProvider userProvider) {
    return Container(
      height: 150,
      color: Theme.of(context).colorScheme.primary,
      child: Row(
        children: [
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(45)),
            elevation: 5,
            child: userProvider.userModel!.userImageUrl == null
                ? const Icon(
                    Icons.person,
                    size: 90,
                    color: Colors.grey,
                  )
                : Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ClipOval(
                      child: CachedNetworkImage(
                        width: 90,
                        height: 90,
                        imageUrl: userProvider.userModel!.userImageUrl!,
                        placeholder: (context, url) =>
                            const Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                  ),
          ),
          const SizedBox(
            width: 15,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userProvider.userModel!.displayName ?? 'No Display Name',
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: Colors.white),
              ),
              Text(
                userProvider.userModel!.email,
                style: TextStyle(color: Colors.white60),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
