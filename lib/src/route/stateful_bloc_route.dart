import 'package:bloc_process/src/route/bloc_route.dart';
import 'package:flutter/widgets.dart';

import '../../bloc_process.dart';

/// Exchange `StatefulWidget` with this for widget that are considered to be routes within a process.
abstract class StatefulBlocRoute<TBloc extends ProcessBloc>
    extends StatefulWidget implements BlocRoute {
  final TBloc bloc;

  const StatefulBlocRoute(this.bloc, {super.key});
}
