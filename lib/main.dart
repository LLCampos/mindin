import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindin/timer/bloc/bloc.dart';
import 'package:mindin/fade_route.dart';
import 'package:mindin/mindin_theme.dart';
import 'package:mindin/timer/ticker.dart';
import 'package:mindin/timer/timer.dart';


const FadeDurationMillis = 1000;

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
        iconTheme: IconThemeData(
          color: Theme.of(context).primaryColorDark,
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0.5,
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: Center(
        child: bodyWidget,
      ),
    );
  }

  static Widget centralMessage(String message) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        message,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 35,
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
            ),
          ),
        ),
        SizedBox(height: 20),
        MaterialButton(
          color: Theme.of(context).buttonColor,
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

  final Map<int, Widget> nextScreen = {
    0: DontInterruptOthersScreen(),
    1: ThinkBeforeTalkScreen(),
    2: DontDisregardOtherOpinions(),
  };

  @override
  Widget build(BuildContext context) {
    return MindIn.scaffold(context, mainScreenWidget());
  }

  Widget mainScreenWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        MindIn.centralMessage("What's your intention for the interaction?"),
        SizedBox(height: 20),
        Container(
          height: 200,
          child: ListView.builder(
              itemCount: intentions.length,
              itemBuilder: (BuildContext context, int index) {
                return Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3.0),
                      child: MaterialButton(
                        color: Theme.of(context).buttonColor,
                        textColor: Colors.white,
                        child: Text(intentions[index]),
                        onPressed: () => Navigator.push(
                          context,
                          FadeRoute(page: nextScreen[index]),
                        ),
                ),
                    ));
              }),
        )
      ],
    );
  }
}

class DontInterruptOthersScreen extends StatefulWidget {
  final messages = [
    "Appreciate what others have to say",
    "Listen. Don't just wait for your time to talk",
  ];

  @override
  State<StatefulWidget> createState() => MessagesSlidesScreen(messages);
}

class ThinkBeforeTalkScreen extends StatefulWidget {
  final messages = [
    "Reflect on what you're going to say before saying it",
    "There's no rush",
    "Better to wait than saying something you will regret",
  ];

  @override
  State<StatefulWidget> createState() => MessagesSlidesScreen(messages);
}

class DontDisregardOtherOpinions extends StatefulWidget {
  final messages = ["placeholder"];

  @override
  State<StatefulWidget> createState() => MessagesSlidesScreen(messages);
}

class MessagesSlidesScreen<T extends StatefulWidget> extends State<T> {
  List<String> messages;
  var _currentMsgIndex = 0;

  MessagesSlidesScreen(this.messages): assert(messages.isNotEmpty);

  void update() {
    if (_currentMsgIndex + 1 == messages.length) {
      _currentMsgIndex = 0;
      Navigator.push(
        context,
        FadeRoute(page: MeditationScreen()),
      );
    } else {
      setState(() {
        _currentMsgIndex++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MindIn.scaffold(context, mainScreenWidget());
  }

  Widget mainScreenWidget() {
    return AnimatedSwitcher(
        duration: Duration(milliseconds: FadeDurationMillis),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(child: child, opacity: animation);
        },
        child: GestureDetector(
          key: ValueKey<int>(_currentMsgIndex),
          child: MindIn.centralMessage(messages[_currentMsgIndex]),
          onTap: () {
            update();
          },
        ));
  }
}

class MeditationScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MeditationScreenState();
}

class MeditationScreenState extends State<MeditationScreen> {
  Widget _currentWidget;
  final TimerBloc _timerBloc = TimerBloc(ticker: Ticker(), duration: 120);

  @override
  void initState() {
    _currentWidget = meditationPreparation();
    super.initState();
}

  Widget meditationPreparation() {
    return GestureDetector(
      child: MindIn.centralMessage("Spend 2 minutes meditating about your intention for the interaction"),
      onTap: () => setState(() => _currentWidget = meditationTimer()),
    );
  }

  Widget meditationTimer() {
    return BlocListener(
      bloc: _timerBloc,
      listener: (context, state) {
        if (state is Finished) {
          setState(() => _currentWidget = meditationFinished());
        }
      },
      child: Timer(_timerBloc),
    );
  }

  Widget meditationFinished() {
    return GestureDetector(
      child: MindIn.centralMessage("Good job :)"),
      onTap: () => Navigator.popUntil(context, ModalRoute.withName('/')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MindIn.scaffold(context, AnimatedSwitcher(
      duration: Duration(milliseconds: FadeDurationMillis),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(child: child, opacity: animation);
      },
      child: Container(
        key: ValueKey<String>(_currentWidget.toStringShort()),
        child: _currentWidget,
      ),
    ));
  }

  @override
  void dispose() {
    _timerBloc.dispose();
    super.dispose();
  }
}