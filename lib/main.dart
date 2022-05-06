import 'package:flutter/material.dart';
// first import the packge
import 'package:card_numbers_form_camera/card_numbers_form_camera.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ac',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Ac'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String text = '';
  String Societe = '';
  String Type = '';
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ///Button
    // ignore: non_constant_identifier_names, duplicate_ignore
    var button_Scan = new ElevatedButton(
      // ignore: prefer_const_constructors
      child: Text('Scan'),
      onPressed: () async {
        String s = await getCardNumbers(context);
        setState(() {
          text = s;
          print("######################### cart number : " + text);
        });
      },
    );
    var button_Societe = new ElevatedButton(
      // ignore: prefer_const_constructors
      child: Text('Mauritel'),

      onPressed: () async {
        _bottomDeSociete(context);
      },
      style: ElevatedButton.styleFrom(
        primary: Colors.blue,
        // Background color
      ),
    );
    var button_Type = new ElevatedButton(
      // ignore: prefer_const_constructors
      child: Text('10'),

      onPressed: () async {
        _bottomDeCart(context);
      },
      style: ElevatedButton.styleFrom(
        primary: Colors.blue,
        // Background color
      ),
    );

    // ignore: non_constant_identifier_names

    // ignore: non_constant_identifier_names

    // ignore: non_constant_identifier_names
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[button_Societe, button_Type, button_Scan],
      ),
    );
  }

  _bottomDeSociete(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext c) {
          return Wrap(children: <Widget>[
            // ignore: avoid_unnecessary_containers
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(""),
                  ),
                  ListTile(
                    title: Text("Mauritel"),
                    onTap: () {
                      setState(() {});
                    },
                  ),
                  ListTile(
                    title: Text("Mattel"),
                    onTap: () {
                      setState(() {});
                    },
                  ),
                  ListTile(
                    title: Text("Chenguitel"),
                    onTap: () {
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
          ]);
        });
  }

  _bottomDeCart(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext c) {
          return Wrap(children: <Widget>[
            // ignore: avoid_unnecessary_containers
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(""),
                  ),
                  ListTile(
                    title: Text("10"),
                    onTap: () {
                      setState(() {});
                    },
                  ),
                  ListTile(
                    title: Text("20"),
                    onTap: () {
                      setState(() {});
                    },
                  ),
                  ListTile(
                    title: Text("30"),
                    onTap: () {
                      setState(() {});
                    },
                  ),
                  ListTile(
                    title: Text("50"),
                    onTap: () {
                      setState(() {});
                    },
                  ),
                  ListTile(
                    title: Text("100"),
                    onTap: () {
                      setState(() {});
                    },
                  ),
                  ListTile(
                    title: Text("200"),
                    onTap: () {
                      setState(() {});
                    },
                  ),
                  ListTile(
                    title: Text("300"),
                    onTap: () {
                      setState(() {});
                    },
                  ),
                  ListTile(
                    title: Text("500"),
                    onTap: () {
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
          ]);
        });
  }
}
