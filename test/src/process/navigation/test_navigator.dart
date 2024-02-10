import 'package:bloc_process/bloc_process.dart';
import 'package:mockito/annotations.dart';

import '../bloc/test_bloc.dart';
import '../bloc/test_state.dart';

@GenerateNiceMocks([MockSpec<TestNavigator>()])
class TestNavigator implements ProcessNavigator<TestBloc, TestState> {
  @override
  void onEnd(TestBloc bloc) {
    //
  }

  @override
  void onRevive(TestBloc bloc) {
    //
  }

  @override
  void onStart(TestBloc bloc) {
    //
  }

  @override
  void onStateChanged(TestBloc bloc, TestState state) {
    //
  }
}
