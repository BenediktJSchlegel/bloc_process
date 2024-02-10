import 'package:bloc_process/bloc_process.dart';
import 'package:mockito/annotations.dart';

import '../bloc/test_bloc.dart';
import '../bloc/test_event.dart';
import '../bloc/test_state.dart';
import '../io/test_input.dart';
import '../io/test_output.dart';
import '../navigation/test_navigator.dart';
import '../test_process_controller.dart';

@GenerateNiceMocks([MockSpec<TestLink>()])
class TestLink extends ProcessLink<TestInput, TestEvent, TestState, TestOutput,
    TestBloc, TestNavigator, TestProcessController> {
  TestLink(
    super.controller, {
    super.inputTransformer,
    super.outputTransformer,
  });
}
