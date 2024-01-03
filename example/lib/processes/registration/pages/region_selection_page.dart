import 'package:bloc_process/bloc_process.dart';
import 'package:flutter/material.dart';

import '../../../helpers/utils.dart';
import '../state/bloc/registration_process_bloc.dart';
import '../state/bloc/registration_process_events.dart';

class RegionSelectionPage extends StatefulBlocRoute<RegistrationProcessBloc> {
  const RegionSelectionPage(super.bloc, {super.key});

  @override
  State<RegionSelectionPage> createState() => _RegionSelectionPageState();
}

class _RegionSelectionPageState extends State<RegionSelectionPage> {
  @override
  Widget build(BuildContext context) {
    return ProcessBlocErrorListener(
      bloc: widget.bloc,
      onErrorCallback: (event) => _onError(event, context),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text("Region Selection"),
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
    widget.bloc.add(RegionSelectionSubmittedEvent());
  }

  void _onErrorPressed() {
    widget.bloc.add(ThrowErrorEvent("Error during region"));
  }
}
