import 'package:bloc_process/bloc_process.dart';
import 'package:mockito/annotations.dart';

import '../io/test_input.dart';
import '../io/test_output.dart';
import 'test_event.dart';
import 'test_state.dart';

@GenerateNiceMocks([MockSpec<TestBloc>()])
class TestBloc
    extends ProcessBloc<TestInput, TestEvent, TestState, TestOutput> {
  TestBloc(super.initialState) {
    on<TestEvent>((event, emit) {
      emit(TestState());
    });
  }

  @override
  initialize(TestInput input) {
    //
  }
}
