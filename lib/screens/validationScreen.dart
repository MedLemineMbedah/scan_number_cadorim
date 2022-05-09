import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../api/api.dart';
import '../const/colors.dart';
import 'homeScreen.dart';

class ValidationScreen extends StatefulWidget {
  String montant, operateur, code;
  // ignore: use_key_in_widget_constructors
  ValidationScreen(
      {required this.montant, required this.operateur, required this.code});

  @override
  State<ValidationScreen> createState() => _ValidationScreenState();
}

class _ValidationScreenState extends State<ValidationScreen> {
  bool _isLoading = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  late Timer timer;
  late String password;
  var _pass;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: AppColor.bl,
        title: const Text("Verification"),
      ),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            Card(
                elevation: 20,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                margin: EdgeInsets.all(3),
                child: ListTile(
                  title: Text("Operateur"),
                  subtitle: Text(widget.operateur),
                )),
            Card(
                elevation: 20,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                margin: EdgeInsets.all(3),
                child: ListTile(
                  title: Text("Motant"),
                  subtitle: Text(widget.montant),
                )),
            Card(
                elevation: 20,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                margin: EdgeInsets.all(3),
                child: ListTile(
                  title: Text("Code"),
                  subtitle: Text(widget.code),
                )),
            const SizedBox(
              height: 40,
            ),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(AppColor.bl),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                ),
                onPressed: !_isLoading
                    ? () {
                        _passAlert().then((value) async {
                          if (_pass != null) {
                            setState(() {
                              password = value!;
                            });
                            _add();
                          } else {
                            //Navigator.of(context).pop();
                          }
                        });
                      }
                    : null,
                child: const Text("Ajouter"),
              ),
            ),
          ],
        ),
      )),
    );
  }

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

  void _add() async {
    setState(() {
      _isLoading = true;
    });
    var data = {
      'operateur': widget.operateur,
      'montant': widget.montant,
      'code': widget.code,
      'password': password,
    };
    try {
      timer = Timer(const Duration(milliseconds: 60000), () async {
        await EasyLoading.dismiss();
      });
      await EasyLoading.show(
        status: "Veuillez patienter",
        maskType: EasyLoadingMaskType.black,
      );
      var res = await Network().authDataTok(data, 'add/card');

      var body = json.decode(res.body);
      // ignore: avoid_print
      print(body);
      if (body['success']) {
        await EasyLoading.dismiss();

        _topBar("La carte a ete ajoute", Colors.green, Icons.done);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      } else {
        await EasyLoading.dismiss();

        _topBar(body['msg'], Colors.red, Icons.error);
      }
    } catch (e) {
      await EasyLoading.dismiss();

      _topBar("Erreur technique", Colors.red, Icons.dangerous_sharp);
    }

    setState(() {
      _isLoading = false;
    });
  }

  Future<String?> _passAlert() async {
    return showDialog<String>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Validation"),
          content: Form(
            key: _formKey,
            child: TextFormField(
              // controller: _pass,
              keyboardType: TextInputType.text,
              obscureText: true,
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.vpn_key,
                  color: AppColor.bl,
                ),
                hintStyle: TextStyle(
                    color: Color(0xFF9b9b9b),
                    fontSize: 15,
                    fontWeight: FontWeight.normal),
                filled: false,
                labelText: "Saisir le mot de passe",
              ),
              validator: (passwordValue) {
                if (passwordValue!.isEmpty) {
                  return "Veuillez saisir le mot de passe";
                }
                _pass = passwordValue;
                return null;
              },
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text("Annuler"),
              onPressed: () {
                setState(() {
                  _pass = null;
                });
                Navigator.of(context).pop(_pass);
              },
            ),
            TextButton(
              child: const Text("Valider"),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  Navigator.of(context).pop(_pass);
                }
              },
            ),
          ],
        );
      },
    );
  }
}
