import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_ecom_app_customer/pages/launcher_page.dart';
import 'package:flutter_ecom_app_customer/themes/font_awesome5_icons.dart';
import '../database/auth/auth_service.dart';
import '../utils/helper_functions.dart';
import '../utils/widget_functions.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = '/login_page';

  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  String _errMsg = '';
  bool _obscureTxt = true;

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(24.0),
            shrinkWrap: true,
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                      filled: true,
                      prefixIcon: Icon(Icons.email),
                      labelText: 'Email'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'provide a valid email';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: TextFormField(
                  controller: _passController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      filled: true,
                      prefixIcon: const Icon(Icons.lock_open),
                      suffixIcon: IconButton(
                          onPressed: _toggle,
                          icon: Icon(_obscureTxt
                              ? Icons.visibility
                              : Icons.visibility_off)),
                      labelText: 'Password'),
                  obscureText: _obscureTxt,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'enter a password';
                    } else if (value.length < 6) {}
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  _errMsg,
                  style: const TextStyle(
                    fontSize: 18.0,
                    color: Colors.red,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: _login,
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Login'),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text('Need Help? '),
                  TextButton(
                    onPressed: _resetPassword,
                    child: const Text('Reset Password'),
                  ),
                ],
              ),
              Row(
                children: const [
                  Expanded(
                    child: Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text('OR'),
                  ),
                  Expanded(
                    child: Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8,),
              ElevatedButton(
                onPressed: _loginWithGoogle,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(FontAwesome5.google_1),
                      SizedBox(
                        width: 16.0,
                      ),
                      Text('Login with Google')
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16,),
              Row(
                children: const [
                  Expanded(
                    child: Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text('OR'),
                  ),
                  Expanded(
                    child: Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8,),
              ElevatedButton(
                onPressed: _loginAnonymously,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(FontAwesome5.ghost),
                      SizedBox(
                        width: 16.0,
                      ),
                      Text('Login Anonymously'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text('Don\'t have an account? '),
                  TextButton(
                    onPressed: _register,
                    child: const Text('Register'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _toggle() {
    setState(() {
      _obscureTxt = !_obscureTxt;
    });
  }

  void _resetPassword() {
    showSingleTextInputDialog(
        context: context,
        title: 'Reset Password',
        hint: 'Enter email',
        onSubmit: (email) {
          if (email.isNotEmpty && email.contains('@')) {
            AuthService.resetPassword(email).then((value) {
              showMsg(context, 'Password reset link sent to $email');
            }).catchError((error) {
              _errMsg = error.toString();
            });
          }
        },
        negativeButtonText: 'cancel',
        positiveButtonText: 'Send');
  }

  void _login() {
    if (_formKey.currentState!.validate()) {
      EasyLoading.show(status: 'Please wait...', dismissOnTap: false);
      final email = _emailController.text;
      final pass = _passController.text;

      try {} on FirebaseAuthException catch (error) {
        EasyLoading.dismiss();
        setState(() {
          _errMsg = error.message!;
        });
      }
    }
  }

  void _register() {}

  void _loginWithGoogle() {

  }

  void _loginAnonymously() {
    AuthService.loginAsGuest().then((value) {
      Navigator.pushReplacementNamed(context, LauncherPage.routeName);
    });
  }
}
