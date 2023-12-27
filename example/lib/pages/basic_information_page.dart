import 'package:bloc_process/bloc_process.dart';
import 'package:flutter/material.dart';

class BasicInformationPage extends StatelessBlocRoute {
  const BasicInformationPage(super.bloc, {super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Expanded(
        child: Center(
          child: Text("BASIC"),
        ),
      ),
    );
  }
}
