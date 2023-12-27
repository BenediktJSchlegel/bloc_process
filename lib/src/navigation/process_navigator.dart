import 'package:bloc_process/bloc_process.dart';

abstract interface class ProcessNavigator<TBloc extends ProcessBloc,
    TState extends ProcessBlocState> {
  void onStateChanged(
    TBloc bloc,
    TState state,
  );
}
