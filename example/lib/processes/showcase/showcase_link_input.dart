import 'package:flutter/material.dart';

class ShowcaseLinkInput {
  final List<String> _previousProcessNames;
  final String _previousProcessName;
  final String _previousAction;
  final String _headerText;
  final String _continueText;
  final Color _color;
  final bool _allowsSkip;
  final bool _allowsBreakout;

  ShowcaseLinkInput(
    this._previousProcessNames,
    this._previousProcessName,
    this._headerText,
    this._continueText,
    this._color,
    this._allowsSkip,
    this._allowsBreakout,
    this._previousAction,
  );

  List<String> get previousProcessNames => _previousProcessNames;

  String get continueText => _continueText;

  String get headerText => _headerText;

  String get previousProcessName => _previousProcessName;

  Color get color => _color;

  bool get allowsBreakout => _allowsBreakout;

  bool get allowsSkip => _allowsSkip;

  String get previousAction => _previousAction;
}
