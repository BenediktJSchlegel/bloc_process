import 'package:bloc_process/bloc_process.dart';
import 'package:mockito/annotations.dart';

import '../bloc/test_bloc.dart';
import '../bloc/test_state.dart';

@GenerateNiceMocks([MockSpec<TestNavigator>()])
class TestNavigator implements ProcessNavigator<TestBloc, TestState> {
  @override
  Future<void> onEnd(TestBloc bloc) async {
    //
  }

  @override
  Future<void> onRevive(TestBloc bloc) async {
    //
  }

  @override
  Future<void> onStart(TestBloc bloc) async {
    //
  }

  @override
  Future<void> onStateChanged(TestBloc bloc, TestState state) async {
    //
  }
}
