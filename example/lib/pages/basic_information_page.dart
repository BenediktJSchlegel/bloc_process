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
              DropdownButton<String>(
                value: _selectedValue,
                icon: const Icon(Icons.supervised_user_circle, size: 24),
                elevation: 16,
                style: const TextStyle(color: Colors.deepPurple, fontSize: 24),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: _pickerChanged,
                items: BasicInformationPage.source
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
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
}
