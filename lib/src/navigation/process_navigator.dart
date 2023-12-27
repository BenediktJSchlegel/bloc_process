import 'package:bloc_process/bloc_process.dart';

abstract class ProcessNavigator<TBloc extends ProcessBloc,
    TState extends ProcessBlocState> {
  void onStateChanged(
    TBloc bloc,
    TState state,
  );

  void onStart(TBloc bloc);

  void onEnd(TBloc bloc);
}
