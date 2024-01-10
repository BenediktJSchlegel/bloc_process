import 'package:bloc_process/bloc_process.dart';
import 'package:flutter/material.dart';

abstract class ShowcaseEvent implements ProcessBlocEvent {}

class InitEvent implements ShowcaseEvent {
  final String headerText;
  final String continueText;
  final String previousProcessName;
  final List<String> previousProcessNames;
  final Color color;
  final bool allowsSkip;
  final bool allowsBreakout;

  InitEvent(
    this.headerText,
    this.continueText,
    this.previousProcessName,
    this.previousProcessNames,
    this.color,
    this.allowsSkip,
    this.allowsBreakout,
  );
}

class ShowcaseContinueEvent implements ShowcaseEvent {
  final String action;

  ShowcaseContinueEvent(this.action);
}

class ShowcaseCauseErrorEvent implements ShowcaseEvent {
  final String message;

  ShowcaseCauseErrorEvent(this.message);
}

class ShowcaseCanceledEvent implements ShowcaseEvent {}
