import 'package:bloc_process/bloc_process.dart';
import 'package:mockito/annotations.dart';

import 'bloc/test_bloc.dart';
import 'bloc/test_event.dart';
import 'bloc/test_state.dart';
import 'io/test_input.dart';
import 'io/test_output.dart';
import 'navigation/test_navigator.dart';

@GenerateNiceMocks([MockSpec<TestProcessController>()])
class TestProcessController extends ProcessController<TestInput, TestEvent,
    TestState, TestOutput, TestBloc, TestNavigator> {
  TestProcessController({
    required super.bloc,
    required super.navigationBuilder,
    super.navigationConfiguration,
    super.persistAfterCompletion,
  });
}
