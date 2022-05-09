import 'package:card_numbers_form_camera/card_numbers_form_camera.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:scan_number_cadorim/const/colors.dart';
import 'package:scan_number_cadorim/screens/validationScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var operateur, montant, code;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: AppColor.bl,
        title: const Text("Ajouter une carte de credits"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const SizedBox(
                    height: 60,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                    child: DropdownSearch(
                      dropdownSearchDecoration: const InputDecoration(
                        hintText: "Selectionner l'operateur",
                      ),
                      mode: Mode.DIALOG,
                      //to show search box
                      showSearchBox: true,
                      showSelectedItems: true,
                      //list of dropdown items
                      items: const ['Mauritel', 'Mattel', 'Chinguitel'],
                      // ignore: deprecated_member_use

                      onChanged: (v) {
                        setState(() {
                          operateur = v;
                        });
                        print(v);
                      },
                      validator: (value) =>
                          value == null ? "Selectionner l'operateur " : null,
                      //show selected item
                      //selectedItem: "Veuillez selectionner l'agence",
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                    child: DropdownSearch(
                      dropdownSearchDecoration: const InputDecoration(
                        hintText: "Selectionner le montant",
                      ),
                      mode: Mode.DIALOG,
                      //to show search box
                      showSearchBox: true,
                      showSelectedItems: true,
                      //list of dropdown items
                      items: const [
                        '10',
                        '20',
                        '30',
                        '50',
                        '100',
                        '200',
                        '500'
                      ],
                      // ignore: deprecated_member_use

                      onChanged: (v) {
                        setState(() {
                          montant = v;
                        });
                        print(v);
                      },
                      validator: (value) =>
                          value == null ? "Veuillez choisir le montant " : null,
                      //show selected item
                      //selectedItem: "Veuillez selectionner l'agence",
                    ),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(AppColor.bl),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.white),
                        ),
                        // ignore: prefer_const_constructors
                        child: Text('Scan'),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            String s = await getCardNumbers(context);
                            setState(() {
                              code = s;
                            });
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ValidationScreen(
                                        operateur: operateur,
                                        montant: montant,
                                        code: code,
                                      )),
                            );
                          }
                        } /*() async {
                        String s = await getCardNumbers(context);
                        setState(() {
                          code = s;
                          print(code);
                        });
                      },*/
                        ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
