import 'package:bloc_process/bloc_process.dart';
import 'package:flutter/material.dart';

class ShowcaseState implements ProcessBlocState {
  final String headerText;
  final String continueText;
  final List<String> previousProcessNames;
  final String previousProcessName;
  final Color color;
  final bool allowsSkip;
  final bool allowsBreakout;

  ShowcaseState(
    this.headerText,
    this.continueText,
    this.previousProcessNames,
    this.previousProcessName,
    this.color,
    this.allowsSkip,
    this.allowsBreakout,
  );

  ShowcaseState.initial()
      : headerText = "",
        continueText = "",
        previousProcessName = "",
        previousProcessNames = [],
        color = Colors.white,
        allowsSkip = false,
        allowsBreakout = false;
}
