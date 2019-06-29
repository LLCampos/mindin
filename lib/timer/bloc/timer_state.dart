import 'package:equatable/equatable.dart';

// https://medium.com/flutter-community/flutter-timer-with-flutter-bloc-a464e8332ceb
abstract class TimerState extends Equatable {
  final int duration;

  TimerState(this.duration, [List props = const []])
    : super([duration]..addAll(props));
}

class Ready extends TimerState {
  Ready(int duration): super(duration);

  @override
  String toString() => 'Ready { duration: $duration }';
}

class Paused extends TimerState {
  Paused(int duration) : super(duration);

  @override
  String toString() => 'Paused { duration: $duration }';
}

class Running extends TimerState {
  Running(int duration) : super(duration);

  @override
  String toString() => 'Running { duration: $duration }';
}

class Finished extends TimerState {
  Finished() : super(0);

  @override
  String toString() => 'Finished';
}