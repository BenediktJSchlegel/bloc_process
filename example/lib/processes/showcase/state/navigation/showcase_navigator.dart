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
  void onEnd(ShowcaseBloc bloc) {
    Navigator.of(_context).pop();
  }

  @override
  void onStart(ShowcaseBloc bloc) {
    if (_pushReplaceStart) {
      Navigator.of(_context)
          .pushReplacement(MaterialPageRoute(builder: (context) => _page));
    } else {
      Navigator.of(_context)
          .push(MaterialPageRoute(builder: (context) => _page));
    }
  }

  @override
  void onStateChanged(ShowcaseBloc bloc, ShowcaseState state) {
    // ignore for this example
    // navigation based on state goes here!
  }

  @override
  void onRevive(ShowcaseBloc bloc) {
    Navigator.of(_context).push(MaterialPageRoute(builder: (context) => _page));
  }
}
