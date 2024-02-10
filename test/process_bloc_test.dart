import 'package:bloc_process/bloc_process.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'process_controller_test.dart';
import 'src/process/bloc/test_bloc.dart';
import 'src/process/bloc/test_event.dart';
import 'src/process/bloc/test_state.dart';
import 'src/process/io/test_input.dart';
import 'src/process/navigation/test_navigator.mocks.dart';
import 'src/process/test_process_controller.dart';

void main() {
  group("ProcessBloc tests", () {
    test("Can be created", () {
      final bloc = TestBloc(TestState());

      expect(bloc, isNotNull);
    });

    test("Can listen to error stream", () {
      final bloc = TestBloc(TestState());

      bloc.errorStream.listen((event) {});

      expect(bloc, isNotNull);
    });

    test("EmitError emits to the error stream", () {
      final bloc = TestBloc(TestState());
      final event = ErrorEvent("test");

      expectLater(bloc.errorStream, emits(event));

      bloc.emitError(event);
    });

    test("Can listen to stream", () {
      final bloc = TestBloc(TestState());

      bloc.stream.listen((event) {});

      expect(bloc, isNotNull);
    });

    test("Can notify Navigator", () async {
      final bloc = TestBloc(TestState());
      final navigator = MockTestNavigator();

      final controller = TestProcessController(
        bloc: bloc,
        navigationBuilder: (context) => navigator,
      );

      controller.start(MockBuildContext(), TestInput(), (output) {});

      bloc.add(TestEvent());

      await Future.delayed(const Duration(milliseconds: 100));

      verify(navigator.onStateChanged(any, any));
    });
  });
}
