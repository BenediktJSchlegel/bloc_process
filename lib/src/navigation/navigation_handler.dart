import 'dart:async';

import 'package:bloc_process/bloc_process.dart';
import 'package:bloc_process/src/navigation/process_navigator.dart';

class NavigationHandler {
  final ProcessBloc _bloc;
  final NavigationConfiguration _configuration;

  late final ProcessNavigator _navigator;

  StreamSubscription? _blocStreamSubscription;

  NavigationHandler(this._bloc, this._configuration);

  void mount(ProcessNavigator navigator, Stream stream) {
    _navigator = navigator;

    _blocStreamSubscription = stream.listen(
      (event) {
        _navigator.onStateChanged(_bloc, event);
      },
    );
  }

  void start() {
    if (_configuration.onStartBehaviour == NavigationBehaviour.noNavigation) {
      return;
    }

    if (_configuration.onStartBehaviour == NavigationBehaviour.navigation ||
        _bloc.shouldNavigationOnStart()) {
      _navigator.onStart(_bloc);
    }
  }

  void end() {
    if (_configuration.onEndBehaviour == NavigationBehaviour.noNavigation) {
      return;
    }

    if (_configuration.onEndBehaviour == NavigationBehaviour.navigation ||
        _bloc.shouldNavigationOnEnd()) {
      _navigator.onEnd(_bloc);
    }
  }

  void revive() {
    if (_configuration.onReviveBehaviour == NavigationBehaviour.noNavigation) {
      return;
    }

    if (_configuration.onReviveBehaviour == NavigationBehaviour.navigation ||
        _bloc.shouldNavigationOnRevive()) {
      _navigator.onRevive(_bloc);
    }
  }

  void unmount() {
    _blocStreamSubscription?.cancel();
  }
}
