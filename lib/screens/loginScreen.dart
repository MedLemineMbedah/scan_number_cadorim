import 'dart:async';
import 'dart:convert';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/api.dart';
import '../const/colors.dart';
import '../utils/helper.dart';
import 'homeScreen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false, visible = true;

  final _formKey = GlobalKey<FormState>();
  var email;
  var password;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late Timer timer;
  _topBar(msg, Color color, IconData icon) {
    showTopSnackBar(
      context,
      CustomSnackBar.info(
        message: msg,
        backgroundColor: color,
        iconRotationAngle: 0,
        icon: Icon(
          icon,
          size: 50,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SizedBox(
        height: Helper.getScreenHeight(context),
        width: Helper.getScreenWidth(context),
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
              vertical: 30,
            ),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    /*SizedBox( 
                      child: Image.asset(
                        Helper.getAssetName(
                          "icon.png",
                          "real",
                        ),
                      ),
                    ),*/
                    const SizedBox(height: 1),
                    Text(
                      "LOGIN",
                      style: Helper.getTheme(context).headline4,
                    ),
                    const SizedBox(height: 40),
                    SizedBox(
                      child: TextFormField(
                        style: const TextStyle(color: Color(0xFF000000)),
                        cursorColor: const Color(0xFF9b9b9b),
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                            prefixIcon: Icon(
                              Icons.email,
                              color: Colors.orange,
                            ),
                            hintStyle: TextStyle(
                                color: Color(0xFF9b9b9b),
                                fontSize: 15,
                                fontWeight: FontWeight.normal),
                            filled: false,
                            labelText: "Email",
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: AppColor.bl))),
                        validator: (emailValue) {
                          if (emailValue!.isEmpty) {
                            return "Veuilez saisir votre email";
                          }
                          email = emailValue;
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      child: TextFormField(
                        style: const TextStyle(color: Color(0xFF000000)),
                        cursorColor: const Color(0xFF9b9b9b),
                        keyboardType: TextInputType.text,
                        obscureText: visible,
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: Icon(
                                !visible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Color(0xfff29400),
                              ),
                              onPressed: () {
                                setState(() {
                                  if (visible) {
                                    visible = false;
                                  } else {
                                    visible = true;
                                  }
                                });
                              },
                            ),
                            prefixIcon: const Icon(
                              Icons.vpn_key,
                              color: Colors.orange,
                            ),
                            hintStyle: const TextStyle(
                                color: Color(0xFF9b9b9b),
                                fontSize: 15,
                                fontWeight: FontWeight.normal),
                            filled: false,
                            labelText: "Password",
                            border: const OutlineInputBorder(
                                borderSide: BorderSide(color: AppColor.bl))),
                        validator: (passwordValue) {
                          if (passwordValue!.isEmpty) {
                            return "Veuillez saisir votre mot de passe";
                          }
                          password = passwordValue;
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(AppColor.bl),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.white),
                        ),
                        onPressed: !_isLoading
                            ? () {
                                if (_formKey.currentState!.validate()) {
                                  _login();
                                }
                              }
                            : null,
                        child: const Text("Login"),
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _login() async {
    setState(() {
      _isLoading = true;
    });
    var data = {'email': email, 'password': password};
    try {
      timer = Timer(const Duration(milliseconds: 60000), () async {
        await EasyLoading.dismiss();
      });
      await EasyLoading.show(
        status: "Veuillez patienter",
        maskType: EasyLoadingMaskType.black,
      );
      var res = await Network().authData(data, 'card/login');

      var body = json.decode(res.body);
      // ignore: avoid_print
      print(body);
      if (body['success']) {
        await EasyLoading.dismiss();
        SharedPreferences localStorage = await SharedPreferences.getInstance();
        localStorage.setString('token', json.encode(body['token']));
        localStorage.setString('user', json.encode(body['user']));
        _topBar("Vous ete connecte", Colors.green, Icons.done);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      } else {
        await EasyLoading.dismiss();
        // _showMsg(body['error']);
        _topBar("Not found", Colors.red, Icons.error);
      }
    } catch (e) {
      await EasyLoading.dismiss();
      _topBar("Erreur technique", Colors.red, Icons.dangerous_sharp);
    }

    setState(() {
      _isLoading = false;
    });
  }
}
