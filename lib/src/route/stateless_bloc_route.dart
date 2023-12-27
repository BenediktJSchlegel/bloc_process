import 'package:bloc_process/src/bloc/process_bloc.dart';
import 'package:flutter/cupertino.dart';

import 'bloc_route.dart';

abstract class StatelessBlocRoute<TBloc extends ProcessBloc>
    extends StatelessWidget implements BlocRoute {
  final TBloc bloc;

  const StatelessBlocRoute(this.bloc, {super.key});
}
