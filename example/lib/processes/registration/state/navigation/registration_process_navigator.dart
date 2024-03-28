import 'package:bloc_process/bloc_process.dart';
import 'package:flutter/material.dart';

import '../../pages/basic_information_page.dart';
import '../../pages/password_page.dart';
import '../../pages/region_selection_page.dart';
import '../bloc/registration_process_bloc.dart';
import '../bloc/registration_process_state.dart';

class RegistrationProcessNavigator extends ProcessNavigator<RegistrationProcessBloc, RegistrationProcessState> {
  final BuildContext _context;

  final BasicInformationPage _basicInformationPage;
  final PasswordPage _passwordPage;
  final RegionSelectionPage _regionSelectionPage;

  RegistrationProcessPages _currentPage = RegistrationProcessPages.basicInformation;

  RegistrationProcessNavigator(
    this._context,
    RegistrationProcessBloc bloc,
  )   : _basicInformationPage = BasicInformationPage(bloc),
        _passwordPage = PasswordPage(bloc),
        _regionSelectionPage = RegionSelectionPage(bloc);

  @override
  Future<void> onStart(RegistrationProcessBloc bloc) async {
    Navigator.of(_context).push(MaterialPageRoute(builder: (context) => _basicInformationPage));
  }

  @override
  Future<void> onEnd(RegistrationProcessBloc bloc) async {
    Navigator.of(_context).pop();
  }

  @override
  Future<void> onStateChanged(RegistrationProcessBloc bloc, RegistrationProcessState state) async {
    if (state.page != _currentPage) {
      _currentPage = state.page;

      switch (state.page) {
        case RegistrationProcessPages.basicInformation:
          Navigator.of(_context).pushReplacement(MaterialPageRoute(builder: (context) => _basicInformationPage));
          break;
        case RegistrationProcessPages.password:
          Navigator.of(_context).pushReplacement(MaterialPageRoute(builder: (context) => _passwordPage));
          break;
        case RegistrationProcessPages.regionSelection:
          Navigator.of(_context).pushReplacement(MaterialPageRoute(builder: (context) => _regionSelectionPage));
          break;
      }
    }
  }

  @override
  Future<void> onRevive(RegistrationProcessBloc bloc) async {}
}
