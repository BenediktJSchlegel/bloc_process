/// Used to define the behaviour of the `ProcessNavigator`
enum NavigationBehaviour {
  /// navigate normally
  navigation,

  /// call the `shouldNavigate` callback of the `ProcessBloc`
  callback,

  /// do not navigate
  noNavigation,
}

/// Controls how the `ProcessNavigator` gets called
class NavigationConfiguration {
  final NavigationBehaviour onStartBehaviour;
  final NavigationBehaviour onEndBehaviour;
  final NavigationBehaviour onReviveBehaviour;

  NavigationConfiguration({
    required NavigationBehaviour onStart,
    required NavigationBehaviour onEnd,
    required NavigationBehaviour onRevive,
  })  : onStartBehaviour = onStart,
        onEndBehaviour = onEnd,
        onReviveBehaviour = onRevive;

  const NavigationConfiguration.defaultConfiguration()
      : onStartBehaviour = NavigationBehaviour.navigation,
        onEndBehaviour = NavigationBehaviour.navigation,
        onReviveBehaviour = NavigationBehaviour.navigation;
}
