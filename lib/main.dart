import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mindin/mindin_theme.dart';

void main() => runApp(MindIn());

class MindIn extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MindIn',
      theme: MindInTheme.getThemeData(),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget _widgetInFocus;

  @override
  void initState() {
    super.initState();
    setWidgetInFocus(_startWidget());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Center(
        child: _widgetInFocus,
      ),
    );
  }

  void setWidgetInFocus(Widget widget) {
    setState(() {
      _widgetInFocus = widget;
    });
  }

  Widget _startWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          child: Text(
            "MindIn",
            style: TextStyle(
              fontSize: 60,
              color: Colors.cyan[900],
            ),
          ),
        ),
        SizedBox(height: 20),
        MaterialButton(
          color: Colors.cyan[900],
          textColor: Colors.white,
          child: Text("Let's start"),
          onPressed: () => setWidgetInFocus(intentionChoiceWidget()),
        )
      ],
    );
  }

  Widget intentionChoiceWidget() {
    final intentions = [
      "Don't interrupt others. Listen more.",
      "Think before I talk.",
      "Don't disregard other's opinions."
    ];

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          child: Text(
            "What's your intention for the interaction?",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 40,
              color: Colors.cyan[900],
            ),
          ),
        ),
        Container(
          height: 200,
          child: ListView.builder(
              itemCount: intentions.length,
              itemBuilder: (BuildContext context, int index) {
                return Center(
                    child: OutlineButton(
                      borderSide: BorderSide(),
                      child: Text(intentions[index]),
                      onPressed: () => setState(() => print("pressed")),
                ));
              }),
        )
      ],
    );
  }
}
