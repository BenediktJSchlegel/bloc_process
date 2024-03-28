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
      (event) async {
        await _navigator.onStateChanged(_bloc, event);
      },
    );
  }

  Future<void> start() async {
    if (_configuration.onStartBehaviour == NavigationBehaviour.noNavigation) {
      return;
    }

    if (_configuration.onStartBehaviour == NavigationBehaviour.navigation || _bloc.shouldNavigationOnStart()) {
      await _navigator.onStart(_bloc);
    }
  }

  Future<void> end() async {
    if (_configuration.onEndBehaviour == NavigationBehaviour.noNavigation) {
      return;
    }

    if (_configuration.onEndBehaviour == NavigationBehaviour.navigation || _bloc.shouldNavigationOnEnd()) {
      await _navigator.onEnd(_bloc);
    }
  }

  Future<void> revive() async {
    if (_configuration.onReviveBehaviour == NavigationBehaviour.noNavigation) {
      return;
    }

    if (_configuration.onReviveBehaviour == NavigationBehaviour.navigation || _bloc.shouldNavigationOnRevive()) {
      await _navigator.onRevive(_bloc);
    }
  }

  void unmount() {
    _blocStreamSubscription?.cancel();
  }
}
