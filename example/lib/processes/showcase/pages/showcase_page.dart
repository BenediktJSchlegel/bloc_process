import 'package:bloc_process/bloc_process.dart';
import 'package:example/processes/showcase/state/bloc/showcase_bloc.dart';
import 'package:flutter/material.dart';

import '../../../helpers/utils.dart';
import '../state/bloc/showcase_events.dart';

class ShowcasePage extends StatelessBlocRoute<ShowcaseBloc> {
  const ShowcasePage(super.bloc, {super.key});

  @override
  Widget build(BuildContext context) {
    return ProcessBlocErrorListener(
      bloc: bloc,
      onErrorCallback: (event) => _onError(event, context),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: bloc.state.color,
          title: Text(bloc.state.headerText),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                child: const Text("Show error"),
                onPressed: () => _onErrorPressed(),
              ),
              TextButton(
                child: Text(bloc.state.continueText),
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
    bloc.add(ShowcaseContinueEvent());
  }

  void _onErrorPressed() {
    bloc.add(ShowcaseCauseErrorEvent("Error during ${bloc.state.headerText}"));
  }
}
