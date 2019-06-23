import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mindin/fade_route.dart';
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
      home: HomePageScreen(),
    );
  }

  static Widget scaffold(BuildContext context, Widget bodyWidget) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0.0,
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: Center(
        child: bodyWidget,
      ),
    );
  }

  static Widget centralMessage(String message) {
    return Container(
      child: Text(
        message,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 40,
          color: Colors.cyan[900],
        ),
      ),
    );
  }
}

class HomePageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MindIn.scaffold(context, this.mainScreenWidget(context));
  }

  Widget mainScreenWidget(BuildContext context) {
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
          onPressed: () {
            Navigator.push(
              context,
              FadeRoute(page: IntentionChoiceScreen()),
            );
          },
        )
      ],
    );
  }
}

class IntentionChoiceScreen extends StatelessWidget {
  final intentions = [
    "Don't interrupt others. Listen more.",
    "Think before I talk.",
    "Don't disregard other's opinions."
  ];

  final Map<int, Widget> nextScreen = {0: DontInterruptOthersScreen()};

  @override
  Widget build(BuildContext context) {
    return MindIn.scaffold(context, mainScreenWidget());
  }

  Widget mainScreenWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        MindIn.centralMessage("What's your intention for the interaction?"),
        Container(
          height: 200,
          child: ListView.builder(
              itemCount: intentions.length,
              itemBuilder: (BuildContext context, int index) {
                return Center(
                    child: OutlineButton(
                  borderSide: BorderSide(),
                  child: Text(intentions[index]),
                  onPressed: () => Navigator.push(
                        context,
                        FadeRoute(page: nextScreen[0]),
                      ),
                ));
              }),
        )
      ],
    );
  }
}

class DontInterruptOthersScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => DontInterruptOthersScreenState();
}

class DontInterruptOthersScreenState extends State<DontInterruptOthersScreen> {
  var _currentMessageIndex = 0;
  var timer;

  final messages = [
    "Appreciate what others have to say.",
    "Listen. Don't just wait for your time to talk.",
  ];

  void initState() {
    timer = new Timer(new Duration(seconds: 5), () => update());
    super.initState();
  }

  void update() {
    setState(() {
      _currentMessageIndex++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MindIn.scaffold(context, mainScreenWidget());
  }

  Widget mainScreenWidget() {
    return MindIn.centralMessage(messages[_currentMessageIndex]);
  }
}
