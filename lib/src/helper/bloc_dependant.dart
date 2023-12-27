import 'package:bloc_process/src/bloc/process_bloc.dart';
import 'package:flutter/cupertino.dart';

abstract class BlocDependant<TBloc extends ProcessBloc> {
  @protected
  late final TBloc bloc;

  BlocDependant(this.bloc);
}
