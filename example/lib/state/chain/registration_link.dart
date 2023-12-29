import 'package:bloc_process/bloc_process.dart';
import 'package:example/state/bloc/registration_process_bloc.dart';
import 'package:example/state/bloc/registration_process_events.dart';
import 'package:example/state/bloc/registration_process_state.dart';
import 'package:example/state/controller/registration_process_controller.dart';
import 'package:example/state/navigation/registration_process_navigator.dart';
import 'package:example/state/result/registration_process_result.dart';

class RegistrationLink extends ProcessLink<
    String,
    RegistrationProcessEvent,
    RegistrationProcessState,
    RegistrationProcessResult,
    RegistrationProcessBloc,
    RegistrationProcessNavigator,
    RegistrationProcessController> {
  RegistrationLink(super.controller, {required super.transformer});
}
