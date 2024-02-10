import 'package:bloc_process/bloc_process.dart';

class MultiState implements ProcessBlocState {
  final String text;

  MultiState(this.text);
}
