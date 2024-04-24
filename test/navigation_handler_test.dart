import 'package:bloc_process/bloc_process.dart';
import 'package:bloc_process/src/navigation/navigation_handler.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'src/process/bloc/test_bloc.mocks.dart';
import 'src/process/navigation/test_navigator.mocks.dart';

void main() {
  group('NavigationHandler tests', () {
    test('Can be created', () {
      final bloc = MockTestBloc();
      const config = NavigationConfiguration.defaultConfiguration();

      final handler = NavigationHandler(bloc, config);

      expect(handler, isNotNull);
    });

    test('Can mount Navigator', () {
      final bloc = MockTestBloc();
      const config = NavigationConfiguration.defaultConfiguration();

      final handler = NavigationHandler(bloc, config);

      handler.init(MockTestNavigator());
      handler.mount(bloc.stream);

      expect(handler, isNotNull);
    });

    test('Calls start on Navigator', () {
      final bloc = MockTestBloc();
      const config = NavigationConfiguration.defaultConfiguration();

      final handler = NavigationHandler(bloc, config);
      final navigator = MockTestNavigator();

      handler.init(navigator);
      handler.mount(bloc.stream);
      handler.start();

      verify(navigator.onStart(bloc));
    });

    test('Calls start and end on Navigator', () {
      final bloc = MockTestBloc();
      const config = NavigationConfiguration.defaultConfiguration();

      final handler = NavigationHandler(bloc, config);
      final navigator = MockTestNavigator();

      handler.init(navigator);
      handler.mount(bloc.stream);

      handler.start();
      handler.end();

      verify(navigator.onStart(bloc));
      verify(navigator.onEnd(bloc));
    });

    test('Calls start and end and revive on Navigator', () {
      final bloc = MockTestBloc();
      const config = NavigationConfiguration.defaultConfiguration();

      final handler = NavigationHandler(bloc, config);
      final navigator = MockTestNavigator();

      handler.init(navigator);
      handler.mount(bloc.stream);

      handler.start();
      handler.end();
      handler.revive();

      verify(navigator.onStart(bloc));
      verify(navigator.onEnd(bloc));
      verify(navigator.onRevive(bloc));
    });

    test('Calls shouldNavigate callbacks', () {
      final bloc = MockTestBloc();
      final config = NavigationConfiguration(
        onStart: NavigationBehaviour.callback,
        onEnd: NavigationBehaviour.callback,
        onRevive: NavigationBehaviour.callback,
      );

      final handler = NavigationHandler(bloc, config);
      final navigator = MockTestNavigator();

      handler.init(navigator);
      handler.mount(bloc.stream);

      handler.start();
      handler.end();
      handler.revive();

      verify(bloc.shouldNavigationOnStart());
      verify(bloc.shouldNavigationOnEnd());
      verify(bloc.shouldNavigationOnRevive());
    });

    test('Navigates when shouldNavigate callbacks are true', () {
      final bloc = MockTestBloc();
      final config = NavigationConfiguration(
        onStart: NavigationBehaviour.callback,
        onEnd: NavigationBehaviour.callback,
        onRevive: NavigationBehaviour.callback,
      );

      final handler = NavigationHandler(bloc, config);
      final navigator = MockTestNavigator();

      handler.init(navigator);
      handler.mount(bloc.stream);

      when(bloc.shouldNavigationOnStart()).thenReturn(true);
      when(bloc.shouldNavigationOnEnd()).thenReturn(true);
      when(bloc.shouldNavigationOnRevive()).thenReturn(true);

      handler.start();
      handler.end();
      handler.revive();

      verify(navigator.onStart(bloc));
      verify(navigator.onEnd(bloc));
      verify(navigator.onRevive(bloc));
    });

    test('Does not navigate when shouldNavigate callbacks are false', () {
      final bloc = MockTestBloc();
      final config = NavigationConfiguration(
        onStart: NavigationBehaviour.callback,
        onEnd: NavigationBehaviour.callback,
        onRevive: NavigationBehaviour.callback,
      );

      final handler = NavigationHandler(bloc, config);
      final navigator = MockTestNavigator();

      handler.init(navigator);
      handler.mount(bloc.stream);

      when(bloc.shouldNavigationOnStart()).thenReturn(false);
      when(bloc.shouldNavigationOnEnd()).thenReturn(false);
      when(bloc.shouldNavigationOnRevive()).thenReturn(false);

      handler.start();
      handler.end();
      handler.revive();

      verifyNever(navigator.onStart(bloc));
      verifyNever(navigator.onEnd(bloc));
      verifyNever(navigator.onRevive(bloc));
    });

    test('Does not navigate when NavigationBehaviour is noNavigation', () {
      final bloc = MockTestBloc();
      final config = NavigationConfiguration(
        onStart: NavigationBehaviour.noNavigation,
        onEnd: NavigationBehaviour.noNavigation,
        onRevive: NavigationBehaviour.noNavigation,
      );

      final handler = NavigationHandler(bloc, config);
      final navigator = MockTestNavigator();

      handler.init(navigator);
      handler.mount(bloc.stream);

      handler.start();
      handler.end();
      handler.revive();

      verifyNever(navigator.onStart(bloc));
      verifyNever(navigator.onEnd(bloc));
      verifyNever(navigator.onRevive(bloc));
    });
  });
}
