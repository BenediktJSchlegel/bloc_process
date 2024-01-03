import 'package:bloc_process/bloc_process.dart';
import 'package:example/processes/showcase/showcase_link_input.dart';
import 'package:example/processes/showcase/showcase_link_output.dart';
import 'package:example/processes/showcase/state/bloc/showcase_bloc.dart';
import 'package:example/processes/showcase/state/bloc/showcase_events.dart';
import 'package:example/processes/showcase/state/bloc/showcase_state.dart';
import 'package:example/processes/showcase/state/navigation/showcase_navigator.dart';

import '../controller/showcase_controller.dart';

class ShowcaseLink extends ProcessLink<
    ShowcaseLinkInput,
    ShowcaseEvent,
    ShowcaseState,
    ShowcaseLinkOutput,
    ShowcaseBloc,
    ShowcaseNavigator,
    ShowcaseController> {
  ShowcaseLink(
    super.controller, {
    required super.outputTransformer,
    required super.inputTransformer,
  });
}
