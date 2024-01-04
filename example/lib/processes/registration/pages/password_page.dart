import 'package:bloc_process/bloc_process.dart';
import 'package:flutter/material.dart';

import '../../../helpers/utils.dart';
import '../state/bloc/registration_process_events.dart';

class PasswordPage extends StatelessBlocRoute {
  const PasswordPage(super.bloc, {super.key});

  @override
  Widget build(BuildContext context) {
    return ProcessBlocErrorListener(
      bloc: bloc,
      onErrorCallback: (event) => _onError(event, context),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text("Password"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(
                  Icons.error,
                  size: 34,
                ),
                onPressed: () => _onErrorPressed(),
              ),
              IconButton(
                icon: const Icon(
                  Icons.arrow_forward_ios,
                  size: 34,
                ),
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
    bloc.add(PasswordSubmittedEvent());
  }

  void _onErrorPressed() {
    bloc.add(ThrowErrorEvent("Error during password"));
  }
}
