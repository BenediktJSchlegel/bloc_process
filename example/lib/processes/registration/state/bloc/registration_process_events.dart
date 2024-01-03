import 'package:bloc_process/bloc_process.dart';

class RegistrationProcessEvent implements ProcessBlocEvent {}

class BasicInformationSubmittedEvent extends RegistrationProcessEvent {}

class RegionSelectionSubmittedEvent extends RegistrationProcessEvent {}

class PasswordSubmittedEvent extends RegistrationProcessEvent {}

class ThrowErrorEvent extends RegistrationProcessEvent {
  final String message;

  ThrowErrorEvent(this.message);
}

class UserRoleChangedEvent extends RegistrationProcessEvent {
  final String role;

  UserRoleChangedEvent(this.role);
}
