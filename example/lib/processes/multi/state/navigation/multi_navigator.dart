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
  Future<void> onEnd(MultiBloc bloc) async {
    Navigator.of(_context).pop();
  }

  @override
  Future<void> onRevive(MultiBloc bloc) async {
    //
  }

  @override
  Future<void> onStart(MultiBloc bloc) async {
    Navigator.of(_context).push(MaterialPageRoute(
      builder: (context) => _page,
    ));
  }

  @override
  Future<void> onStateChanged(MultiBloc bloc, MultiState state) async {
    //
  }
}
