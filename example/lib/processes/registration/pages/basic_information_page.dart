import 'package:bloc_process/bloc_process.dart';
import 'package:example/helpers/utils.dart';
import 'package:flutter/material.dart';

import '../state/bloc/registration_process_events.dart';

class BasicInformationPage extends StatefulBlocRoute {
  static const List<String> source = ["Basic", "Admin"];

  const BasicInformationPage(super.bloc, {super.key});

  @override
  State<BasicInformationPage> createState() => _BasicInformationPageState();
}

class _BasicInformationPageState extends State<BasicInformationPage> {
  String _selectedValue = BasicInformationPage.source.first;

  @override
  Widget build(BuildContext context) {
    return ProcessBlocErrorListener(
      bloc: widget.bloc,
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
              ProcessBlocBusyBuilder(
                bloc: widget.bloc,
                builder: (busy) {
                  if (busy) {
                    return const CircularProgressIndicator();
                  }

                  return Container();
                },
              ),
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
              IconButton(
                icon: const Icon(
                  Icons.hourglass_bottom,
                  size: 34,
                ),
                onPressed: () => _onLongEventPressed(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _pickerChanged(String? value) {
    if (value != null) {
      setState(() {
        _selectedValue = value;
      });

      widget.bloc.add(UserRoleChangedEvent(value));
    }
  }

  void _onError(ErrorEvent event, BuildContext context) {
    Utils(context).showErrorDialog(event.message ?? "");
  }

  void _onContinuePressed() {
    widget.bloc.add(BasicInformationSubmittedEvent());
  }

  void _onErrorPressed() {
    widget.bloc.add(ThrowErrorEvent("Error during basic information"));
  }

  _onLongEventPressed() {
    widget.bloc.add(LongEventSubmittedEvent());
  }
}
