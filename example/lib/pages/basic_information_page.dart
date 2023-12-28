import 'package:bloc_process/bloc_process.dart';
import 'package:example/helpers/utils.dart';
import 'package:flutter/material.dart';

import '../state/bloc/registration_process_events.dart';

class BasicInformationPage extends StatelessBlocRoute {
  const BasicInformationPage(super.bloc, {super.key});

  @override
  Widget build(BuildContext context) {
    return ProcessBlocErrorListener(
      bloc: bloc,
      onErrorCallback: (event) => _onError(event, context),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text("Basic Information"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.error),
                onPressed: () => _onErrorPressed(),
              ),
              IconButton(
                icon: const Icon(Icons.arrow_forward_ios),
                onPressed: () => _onContinuePressed(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onError(ErrorEvent event, BuildContext context) {
    Utils(context).showErrorDialog(event.message ?? "");
  }

  void _onContinuePressed() {
    bloc.add(BasicInformationSubmittedEvent());
  }

  void _onErrorPressed() {
    bloc.add(ThrowErrorEvent("Error during basic information"));
  }
}
