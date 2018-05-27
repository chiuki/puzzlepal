import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or press Run > Flutter Hot Reload in IntelliJ). Notice that the
        // counter didn't reset back to zero; the application is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: new HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(context) => new Scaffold(
        appBar: new AppBar(title: new Text("Braille")),
        body: new BrailleDecoder(),
      );
}

class BrailleDecoder extends StatefulWidget {
  @override
  _BrailleDecoderState createState() => new _BrailleDecoderState();
}

class _BrailleDecoderState extends State<BrailleDecoder> {
  @override
  Widget build(BuildContext context) => new Column(
        children: <Widget>[
          new Expanded(
            child: new Row(
              children: <Widget>[
                new Expanded(
                  flex: 2,
                  child: new BrailleInput(),
                ),
                new Expanded(
                  flex: 1,
                  child: new Column(
                    children: <Widget>[
                      new Text(""),
                      new MaterialButton(
                        onPressed: () {},
                        child: new Text("OK"),
                      ),
                      new MaterialButton(
                        onPressed: () {},
                        child: new Text("Clear"),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          new Padding(
            padding: const EdgeInsets.all(8.0),
            child: new Text("Tap on a dot to toggle",
                style: new TextStyle(
                  fontSize: 16.0,
                )),
          )
        ],
      );
}

class BrailleInput extends StatefulWidget {
  @override
  _BrailleInputState createState() => new _BrailleInputState();
}

class _BrailleInputState extends State<BrailleInput> {
  List<bool> _dots = new List.filled(6, false);
  static const int _rows = 3;
  static const int _columns = 2;

  @override
  Widget build(BuildContext context) {
    List<Widget> rows = new List();
    for (int r = 0; r < _rows; r++) {
      List<Widget> columns = new List();
      for (int c = 0; c < _columns; c++) {
        final cell = r * _columns + c;
        final filled = _dots[cell];
        columns.add(new Expanded(
            child: new Padding(
          padding: const EdgeInsets.all(16.0),
          child: new GestureDetector(
            child: new _Dot(filled: filled),
            onTap: () {
              setState(() {
                _dots[cell] = !filled;
              });
            },
          ),
        )));
      }
      rows.add(new Expanded(
        child: new Row(
          children: columns,
        ),
      ));
    }
    return new Center(child: new Column(children: rows));
  }
}

class _Dot extends StatelessWidget {
  const _Dot({Key key, this.filled}) : super(key: key);
  final bool filled;

  @override
  Widget build(context) {
    final theme = Theme.of(context);
    return new Container(
      decoration: new ShapeDecoration(
        shape: new CircleBorder(
          side: new BorderSide(
            color: theme.accentColor,
            width: filled ? 16.0 : 4.0,
          ),
        ),
      ),
    );
  }
}
