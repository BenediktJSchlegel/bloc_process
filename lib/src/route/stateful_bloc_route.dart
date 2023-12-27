import 'package:flutter/widgets.dart';

import '../../bloc_process.dart';

abstract class StatefulBlocRoute<TBloc extends ProcessBloc>
    extends StatefulWidget {
  final TBloc bloc;

  const StatefulBlocRoute(this.bloc, {super.key});
}
