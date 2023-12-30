import 'package:bloc_process/bloc_process.dart';

class RegistrationProcessState implements ProcessBlocState {
  final RegistrationProcessPages page;
  final String role;

  RegistrationProcessState(this.page, this.role);

  RegistrationProcessState.initial()
      : page = RegistrationProcessPages.basicInformation,
        role = "Basic";
}

enum RegistrationProcessPages {
  basicInformation,
  password,
  regionSelection,
}
