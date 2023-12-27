import 'package:bloc_process/bloc_process.dart';

class RegistrationProcessState implements ProcessBlocState {
  final RegistrationProcessPages page;

  RegistrationProcessState(this.page);

  RegistrationProcessState.initial()
      : page = RegistrationProcessPages.basicInformation;
}

enum RegistrationProcessPages {
  basicInformation,
  password,
  regionSelection,
}
