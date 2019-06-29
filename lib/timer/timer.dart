import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindin/timer/bloc/timer_bloc.dart';
import 'package:mindin/timer/bloc/timer_event.dart';
import 'package:mindin/timer/bloc/timer_state.dart';

import '../main.dart';

class Timer extends StatelessWidget {
  final TimerBloc timerBloc;

  Timer(this.timerBloc);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: timerBloc,
      builder: (context, state) {
        final String minutesStr = ((state.duration / 60) % 60)
            .floor()
            .toString()
            .padLeft(2, '0');
        final String secondsStr = (state.duration % 60).floor().toString().padLeft(2, '0');
        return GestureDetector(
            child: MindIn.centralMessage('$minutesStr:$secondsStr'),
            onTap: () => _mapStateToAction(timerBloc)
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