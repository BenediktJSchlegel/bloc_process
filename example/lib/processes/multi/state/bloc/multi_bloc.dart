import 'package:bloc_process/bloc_process.dart';
import 'package:example/processes/multi/state/bloc/channels/first_channel.dart';
import 'package:example/processes/multi/state/bloc/channels/second_channel.dart';
import 'package:example/processes/multi/state/bloc/events/multi_event.dart';
import 'package:example/processes/multi/state/bloc/state/multi_state.dart';
import 'package:example/processes/multi/state/io/multi_input.dart';
import 'package:example/processes/multi/state/io/multi_output.dart';

class MultiBloc extends MultiChannelProcessBloc<MultiInput, MultiEvent,
    MultiState, MultiOutput> {
  MultiBloc() : super(MultiState("None")) {
    final List<BlocChannel> channels = [
      FirstChannel(this),
      SecondChannel(this)
    ];

    mountChannels(channels);
  }

  @override
  initialize(MultiInput input) {
    //
  }
}
