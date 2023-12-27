import 'dart:async';

import 'package:bloc_process/bloc_process.dart';
import 'package:bloc_process/src/navigation/process_navigator.dart';

class NavigationHandler {
  final ProcessNavigator _navigator;
  final ProcessBloc _bloc;

  StreamSubscription? _blocStreamSubscription;

  NavigationHandler(this._navigator, this._bloc);

  void mount(Stream stream) {
    _blocStreamSubscription = stream.listen(
      (event) {
        _navigator.onStateChanged(_bloc, event);
      },
    );
  }

  void unmount() {
    _blocStreamSubscription?.cancel();
  }
}
