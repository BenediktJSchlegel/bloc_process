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
                child: const Text("Show error", style: TextStyle(fontSize: 18)),
                onPressed: () => _onErrorPressed(),
              ),
              TextButton(
                child: Text(
                  bloc.state.continueText,
                  style: const TextStyle(fontSize: 18),
                ),
                onPressed: () => _onContinuePressed("continue"),
              ),
              _buildSkipButton(),
              _buildBreakoutButton(),
              Padding(
                padding: const EdgeInsets.only(top: 32),
                child: TextButton(
                  onPressed: _onBackOut,
                  child: const Text(
                    "Back",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onBackOut() {
    bloc.add(ShowcaseCanceledEvent());
  }

  Widget _buildSkipButton() {
    return bloc.state.allowsSkip
        ? TextButton(
            onPressed: () => _onContinuePressed("skip"),
            child: const Text("Skip", style: TextStyle(fontSize: 18)),
          )
        : Container();
  }

  Widget _buildBreakoutButton() {
    return bloc.state.allowsBreakout
        ? TextButton(
            onPressed: () => _onContinuePressed("breakout"),
            child: const Text("Breakout", style: TextStyle(fontSize: 18)),
          )
        : Container();
  }

  void _onError(ErrorEvent event, BuildContext context) {
    Utils(context).showErrorDialog(event.message ?? "");
  }

  void _onContinuePressed(String action) {
    bloc.add(ShowcaseContinueEvent(action));
  }

  void _onErrorPressed() {
    bloc.add(ShowcaseCauseErrorEvent("Error during ${bloc.state.headerText}"));
  }
}
