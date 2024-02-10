import 'package:bloc_process/bloc_process.dart';
import 'package:example/processes/multi/state/bloc/events/multi_event.dart';
import 'package:example/processes/multi/state/bloc/multi_bloc.dart';
import 'package:example/processes/multi/state/bloc/state/multi_state.dart';
import 'package:example/processes/multi/state/io/multi_input.dart';
import 'package:example/processes/multi/state/io/multi_output.dart';
import 'package:example/processes/multi/state/navigation/multi_navigator.dart';

class MultiProcessController extends ProcessController<MultiInput, MultiEvent,
    MultiState, MultiOutput, MultiBloc, MultiNavigator> {
  MultiProcessController({
    required super.bloc,
    required super.navigationBuilder,
  });
}
