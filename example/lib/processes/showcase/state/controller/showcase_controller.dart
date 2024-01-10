import 'package:bloc_process/bloc_process.dart';
import 'package:example/processes/showcase/showcase_link_input.dart';
import 'package:example/processes/showcase/showcase_link_output.dart';
import 'package:example/processes/showcase/state/bloc/showcase_bloc.dart';
import 'package:example/processes/showcase/state/bloc/showcase_events.dart';
import 'package:example/processes/showcase/state/bloc/showcase_state.dart';

import '../navigation/showcase_navigator.dart';

class ShowcaseController extends ProcessController<
    ShowcaseLinkInput,
    ShowcaseEvent,
    ShowcaseState,
    ShowcaseLinkOutput,
    ShowcaseBloc,
    ShowcaseNavigator> {
  ShowcaseController({
    required super.bloc,
    required super.navigationBuilder,
    required super.persistAfterCompletion,
  });
}
