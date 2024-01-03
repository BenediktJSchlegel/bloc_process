import 'package:example/processes/showcase/showcase_link_input.dart';

class ShowcaseLinkOutput {
  final ShowcaseLinkInput _input;
  final String _processName;

  ShowcaseLinkOutput(this._input, this._processName);

  String get processName => _processName;

  ShowcaseLinkInput get input => _input;
}
