import 'package:example/processes/multi/state/bloc/events/multi_event.dart';

abstract class FirstMultiEvent implements MultiEvent {}

class FirstMultiEventImpl implements FirstMultiEvent {}

class CanceledEvent implements FirstMultiEvent {}
