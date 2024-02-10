import 'package:bloc_process/bloc_process.dart';
import 'package:bloc_process/src/exceptions/multi_channel/ambiguous_bloc_event_error.dart';
import 'package:bloc_process/src/exceptions/multi_channel/unhandled_bloc_event_error.dart';
import 'package:flutter/foundation.dart';

import 'bloc_channel.dart';

abstract class MultiChannelProcessBloc<
    TInput,
    TEvent extends ProcessBlocEvent,
    TState extends ProcessBlocState,
    TOutput> extends ProcessBloc<TInput, TEvent, TState, TOutput> {
  late final List<BlocChannel> _channels;

  MultiChannelProcessBloc(super.initialState) {
    on((event, emit) {
      final List<BlocChannel> applicableChannels =
          _channels.where((element) => element.isHandledBy(event)).toList();

      if (applicableChannels.isEmpty) {
        throw UnhandledBlocEventError();
      } else if (applicableChannels.length > 1) {
        throw AmbiguousBlocEventError();
      }

      applicableChannels.first.apply(event, emit);
    });
  }

  @nonVirtual
  void mountChannels(List<BlocChannel> channels) {
    _channels = channels;
  }
}
