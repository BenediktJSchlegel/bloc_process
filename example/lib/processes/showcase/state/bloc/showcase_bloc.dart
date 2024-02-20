import 'package:bloc_process/bloc_process.dart';
import 'package:example/processes/showcase/showcase_link_input.dart';
import 'package:example/processes/showcase/showcase_link_output.dart';
import 'package:example/processes/showcase/state/bloc/showcase_events.dart';
import 'package:example/processes/showcase/state/bloc/showcase_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShowcaseBloc extends ProcessBloc<ShowcaseLinkInput, ShowcaseEvent,
    ShowcaseState, ShowcaseLinkOutput> {
  late ShowcaseLinkInput _input;

  ShowcaseBloc() : super(ShowcaseState.initial()) {
    on((ShowcaseEvent event, Emitter<ShowcaseState> emit) {
      switch (event.runtimeType) {
        case InitEvent:
          event as InitEvent;
          emit(ShowcaseState(
            event.headerText,
            event.continueText,
            event.previousProcessNames,
            event.previousProcessName,
            event.color,
            event.allowsSkip,
            event.allowsBreakout,
          ));
          break;
        case ShowcaseContinueEvent:
          complete(_buildOutput((event as ShowcaseContinueEvent).action));
          break;
        case ShowcaseCauseErrorEvent:
          emitError(ErrorEvent((event as ShowcaseCauseErrorEvent).message));
          break;
        case ShowcaseCanceledEvent:
          backOut();
          break;
      }
    });
  }

  @override
  initialize(ShowcaseLinkInput input) {
    _input = input;

    add(InitEvent(
      input.headerText,
      input.continueText,
      input.previousProcessName,
      input.previousProcessNames,
      input.color,
      input.allowsSkip,
      input.allowsBreakout,
    ));
  }

  ShowcaseLinkOutput _buildOutput(String action) {
    return ShowcaseLinkOutput(_input, state.headerText, action);
  }
}
