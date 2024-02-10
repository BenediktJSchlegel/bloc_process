import 'package:bloc_process/bloc_process.dart';
import 'package:example/processes/multi/state/bloc/multi_bloc.dart';
import 'package:example/processes/multi/state/bloc/state/multi_state.dart';
import 'package:flutter/material.dart';

import '../../pages/multi_page.dart';

class MultiNavigator implements ProcessNavigator<MultiBloc, MultiState> {
  final BuildContext _context;
  final MultiPage _page;

  MultiNavigator(this._context, MultiBloc bloc) : _page = MultiPage(bloc);

  @override
  void onEnd(MultiBloc bloc) {
    Navigator.of(_context).pop();
  }

  @override
  void onRevive(MultiBloc bloc) {
    //
  }

  @override
  void onStart(MultiBloc bloc) {
    Navigator.of(_context).push(MaterialPageRoute(
      builder: (context) => _page,
    ));
  }

  @override
  void onStateChanged(MultiBloc bloc, MultiState state) {
    //
  }
}
