import 'package:bloc_process/bloc_process.dart';
import 'package:flutter/foundation.dart';

abstract class MultiChannelProcessBloc<
    TInput,
    TEvent extends ProcessBlocEvent,
    TState extends ProcessBlocState,
    TOutput> extends ProcessBloc<TInput, TEvent, TState, TOutput> {
  late final List<BlocChannel> _channels;

  MultiChannelProcessBloc(super.initialState) {
    on<TEvent>((event, emit) async {
      final List<BlocChannel> applicableChannels =
          _channels.where((element) => element.isHandledBy(event)).toList();

      if (applicableChannels.isEmpty) {
        throw UnhandledBlocEventError();
      } else if (applicableChannels.length > 1) {
        throw AmbiguousBlocEventError();
      }

      await applicableChannels.first.onEvent(event, emit);
    });
  }

  @nonVirtual
  void mountChannels(List<BlocChannel> channels) {
    _channels = channels;
  }
}
