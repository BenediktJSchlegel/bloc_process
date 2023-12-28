import 'dart:async';

import 'package:bloc_process/bloc_process.dart';
import 'package:bloc_process/src/navigation/process_navigator.dart';

class NavigationHandler {
  late final ProcessNavigator _navigator;
  final ProcessBloc _bloc;

  StreamSubscription? _blocStreamSubscription;

  NavigationHandler(this._bloc);

  void mount(ProcessNavigator navigator, Stream stream) {
    _navigator = navigator;

    _blocStreamSubscription = stream.listen(
      (event) {
        _navigator.onStateChanged(_bloc, event);
      },
    );
  }

  void start() {
    _navigator.onStart(_bloc);
  }

  void end() {
    _navigator.onEnd(_bloc);
  }

  void unmount() {
    _blocStreamSubscription?.cancel();
  }
}
