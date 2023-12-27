import 'package:bloc_process/src/bloc/process_bloc.dart';
import 'package:flutter/cupertino.dart';

abstract class StatelessBlocRoute<TBloc extends ProcessBloc>
    extends StatelessWidget {
  final TBloc bloc;

  const StatelessBlocRoute(this.bloc, {super.key});
}
