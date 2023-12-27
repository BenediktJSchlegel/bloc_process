import 'package:bloc_process/bloc_process.dart';
import 'package:flutter/material.dart';

import '../state/bloc/registration_process_bloc.dart';

class RegionSelectionPage extends StatefulBlocRoute<RegistrationProcessBloc> {
  const RegionSelectionPage(super.bloc, {super.key});

  @override
  State<RegionSelectionPage> createState() => _RegionSelectionPageState();
}

class _RegionSelectionPageState extends State<RegionSelectionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Expanded(
        child: Container(),
      ),
    );
  }
}
