import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindin/timer/bloc/bloc.dart';
import 'package:mindin/fade_route.dart';
import 'package:mindin/mindin_theme.dart';
import 'package:mindin/timer/ticker.dart';


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
                        FadeRoute(page: nextScreen[index]),
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
    "Appreciate what others have to say.",
    "Listen. Don't just wait for your time to talk.",
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
  final _fadeDurationMillis = 1000;

  MessagesSlidesScreen(this.messages): assert(messages.isNotEmpty);

  void update() {
    if (_currentMsgIndex + 1 == messages.length) {
      _currentMsgIndex = 0;
      Navigator.push(
        context,
        FadeRoute(page: MeditationPreparationScreen()),
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
        duration: Duration(milliseconds: _fadeDurationMillis),
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

// TODO join all meditation related to screens in one screen
class MeditationPreparationScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MeditationPreparationScreenState();
}

class MeditationPreparationScreenState extends State<MeditationPreparationScreen> {
  Widget _widget = MindIn.centralMessage(
  "Spend 2 minutes meditating about your intention for the interaction");

  @override
  Widget build(BuildContext context) {
    return MindIn.scaffold(context, mainScreenWidget());
  }

  Widget mainScreenWidget() {
    return Container(
      child: GestureDetector(
        child: _widget,
        onTap: () => Navigator.push(
            context,
            FadeRoute(page: MeditationScreen())),
      ),
    );
  }
}

class MeditationScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MeditationScreenState();
}

class MeditationScreenState extends State<MeditationScreen> {
  final TimerBloc _timerBloc = TimerBloc(
      ticker: Ticker(), duration: 120);

  @override
  Widget build(BuildContext context) {
    return MindIn.scaffold(context, mainScreenWidget());
  }

  Widget mainScreenWidget() {
    return BlocProvider(
      bloc: _timerBloc,
      child: Timer(),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

}

// TODO probaby could also go to timer/ directory
class Timer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final TimerBloc _timerBloc = BlocProvider.of<TimerBloc>(context);
    return BlocBuilder(
      bloc: _timerBloc,
      builder: (context, state) {
        final String minutesStr = ((state.duration / 60) % 60)
            .floor()
            .toString()
            .padLeft(2, '0');
        final String secondsStr = (state.duration % 60).floor().toString().padLeft(2, '0');
        return GestureDetector(
          child: MindIn.centralMessage('$minutesStr:$secondsStr'),
          onTap: () => _mapStateToAction(_timerBloc)
        );
      },
    );
  }

  void _mapStateToAction(TimerBloc timerBloc) {
    if (timerBloc.currentState is Ready) {
      timerBloc.dispatch(Start(duration: timerBloc.initialState.duration));
    } else if (timerBloc.currentState is Running) {
      timerBloc.dispatch(Pause());
    } else if (timerBloc.currentState is Paused) {
      timerBloc.dispatch(Resume());
    }
  }

}