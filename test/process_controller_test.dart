import 'package:bloc_process/bloc_process.dart';
import 'package:bloc_process/src/exceptions/process_already_completed_error.dart';
import 'package:bloc_process/src/exceptions/process_not_started_error.dart';
import 'package:flutter/cupertino.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'src/process/bloc/test_bloc.dart';
import 'src/process/bloc/test_bloc.mocks.dart';
import 'src/process/bloc/test_state.dart';
import 'src/process/io/test_input.dart';
import 'src/process/io/test_output.dart';
import 'src/process/navigation/test_navigator.mocks.dart';
import 'src/process/test_process_controller.dart';

class MockBuildContext extends Mock implements BuildContext {}

void main() {
  group("ProcessController tests", () {
    test("Can be created", () {
      final bloc = MockTestBloc();
      final navigator = MockTestNavigator();

      final controller = TestProcessController(
        bloc: bloc,
        navigationBuilder: (context) => navigator,
      );

      expect(controller, isNotNull);
    });

    test("Can be started", () {
      final bloc = MockTestBloc();
      final navigator = MockTestNavigator();

      final controller = TestProcessController(
        bloc: bloc,
        navigationBuilder: (context) => navigator,
      );

      controller.start(MockBuildContext(), TestInput(), (output) {});

      expect(controller, isNotNull);
    });

    test("Can not be started twice", () {
      final bloc = MockTestBloc();
      final navigator = MockTestNavigator();

      final controller = TestProcessController(
        bloc: bloc,
        navigationBuilder: (context) => navigator,
      );

      controller.start(MockBuildContext(), TestInput(), (output) {});

      expect(
        () => controller.start(MockBuildContext(), TestInput(), (output) {}),
        throwsA(isA<ProcessAlreadyStartedError>()),
      );
    });

    test("Calls initialize on Bloc when started", () {
      final bloc = MockTestBloc();
      final navigator = MockTestNavigator();

      final controller = TestProcessController(
        bloc: bloc,
        navigationBuilder: (context) => navigator,
      );

      final input = TestInput();

      onComplete(TestOutput o) {}

      controller.start(MockBuildContext(), input, onComplete);

      verify(bloc.initialize(input));
    });

    test("Mounts Bloc callbacks when started", () {
      final bloc = MockTestBloc();
      final navigator = MockTestNavigator();

      final controller = TestProcessController(
        bloc: bloc,
        navigationBuilder: (context) => navigator,
      );

      final input = TestInput();

      onComplete(TestOutput o) {}

      controller.start(MockBuildContext(), input, onComplete);

      verify(bloc.mountCallbacks(any, any));
    });

    test("Calls start on Navigator when started", () {
      final bloc = MockTestBloc();
      final navigator = MockTestNavigator();

      final controller = TestProcessController(
        bloc: bloc,
        navigationBuilder: (context) => navigator,
      );

      final input = TestInput();

      controller.start(MockBuildContext(), input, (output) {});

      verify(navigator.onStart(bloc));
    });

    test("Calls revive on Navigator when revived", () {
      final bloc = MockTestBloc();
      final navigator = MockTestNavigator();

      final controller = TestProcessController(
        bloc: bloc,
        navigationBuilder: (context) => navigator,
        persistAfterCompletion: true,
      );

      final input = TestInput();

      controller.start(MockBuildContext(), input, (output) {});
      controller.revive();

      verify(navigator.onRevive(bloc));
    });

    test("Throws error when revived before starting", () {
      final bloc = MockTestBloc();
      final navigator = MockTestNavigator();

      final controller = TestProcessController(
        bloc: bloc,
        navigationBuilder: (context) => navigator,
      );

      expect(
        () => controller.revive(),
        throwsA(isA<ProcessNotStartedError>()),
      );
    });

    test("Calls callback when completed", () {
      final bloc = TestBloc(TestState());
      final navigator = MockTestNavigator();

      final controller = TestProcessController(
        bloc: bloc,
        navigationBuilder: (context) => navigator,
      );

      bool called = false;

      controller.start(
        MockBuildContext(),
        TestInput(),
        (output) {
          called = true;
        },
      );

      bloc.complete(TestOutput());

      expect(called, true);
    });

    test("Can be revived after completion", () {
      final bloc = TestBloc(TestState());
      final navigator = MockTestNavigator();

      final controller = TestProcessController(
        bloc: bloc,
        navigationBuilder: (context) => navigator,
        persistAfterCompletion: true,
      );

      controller.start(
        MockBuildContext(),
        TestInput(),
        (output) {},
      );

      bloc.complete(TestOutput());

      controller.revive();

      expect(controller, isNotNull);
    });

    test(
        "Can not be revived after completion when persistAfterCompletion is false",
        () {
      final bloc = TestBloc(TestState());
      final navigator = MockTestNavigator();

      final controller = TestProcessController(
        bloc: bloc,
        navigationBuilder: (context) => navigator,
        persistAfterCompletion: false,
      );

      controller.start(
        MockBuildContext(),
        TestInput(),
        (output) {},
      );

      bloc.complete(TestOutput());

      expect(() => controller.revive(),
          throwsA(isA<ProcessAlreadyCompletedError>()));
    });
  });
}
