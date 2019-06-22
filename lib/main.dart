import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() => runApp(MindIn());

class MindIn extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MindIn',
      theme: ThemeData(
        backgroundColor: Colors.teal[200],
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Text(
                'MindIn',
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
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
              ),
              child: Text("Let's start"),
              onPressed: () => print("pressed"),
            )
          ],
        ),
      ),
    );
  }
}
