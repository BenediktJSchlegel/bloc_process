import 'package:example/processes/showcase/showcase_link_input.dart';

class ShowcaseLinkOutput {
  final ShowcaseLinkInput _input;
  final String _processName;
  final String _action;

  ShowcaseLinkOutput(this._input, this._processName, this._action);

  String get processName => _processName;

  ShowcaseLinkInput get input => _input;

  String get action => _action;
}
