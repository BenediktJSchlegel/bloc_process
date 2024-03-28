import 'package:bloc_process/bloc_process.dart';
import 'package:example/processes/showcase/pages/showcase_page.dart';
import 'package:example/processes/showcase/state/bloc/showcase_bloc.dart';
import 'package:example/processes/showcase/state/bloc/showcase_state.dart';
import 'package:flutter/material.dart';

class ShowcaseNavigator extends ProcessNavigator<ShowcaseBloc, ShowcaseState> {
  final BuildContext _context;
  final ShowcasePage _page;
  final bool _pushReplaceStart;

  ShowcaseNavigator(
    ShowcaseBloc bloc,
    this._context, {
    bool pushReplaceStart = false,
  })  : _page = ShowcasePage(bloc),
        _pushReplaceStart = pushReplaceStart;

  @override
  Future<void> onEnd(ShowcaseBloc bloc) async {
    Navigator.of(_context).pop();
  }

  @override
  Future<void> onStart(ShowcaseBloc bloc) async {
    if (_pushReplaceStart) {
      await Navigator.of(_context).pushReplacement(MaterialPageRoute(builder: (context) => _page));
    } else {
      await Navigator.of(_context).push(MaterialPageRoute(builder: (context) => _page));
    }
  }

  @override
  Future<void> onStateChanged(ShowcaseBloc bloc, ShowcaseState state) async {
    // ignore for this example
    // navigation based on state goes here!
  }

  @override
  Future<void> onRevive(ShowcaseBloc bloc) async {
    await Navigator.of(_context).push(MaterialPageRoute(builder: (context) => _page));
  }
}
