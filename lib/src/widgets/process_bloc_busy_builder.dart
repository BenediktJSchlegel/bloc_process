import 'package:bloc_process/bloc_process.dart';
import 'package:flutter/material.dart';

class ProcessBlocBusyBuilder<TBloc extends ProcessBloc> extends StatefulWidget {
  final TBloc bloc;
  final Widget Function(bool busy) builder;

  const ProcessBlocBusyBuilder({
    super.key,
    required this.bloc,
    required this.builder,
  });

  @override
  State<ProcessBlocBusyBuilder> createState() => _ProcessBlocBusyBuilderState<TBloc>();
}

class _ProcessBlocBusyBuilderState<TBloc extends ProcessBloc> extends State<ProcessBlocBusyBuilder> {
  bool _isBusy = false;

  @override
  Widget build(BuildContext context) {
    return ProcessBlocBusyListener(
      bloc: widget.bloc,
      onBusyCallback: _onBusyCallback,
      child: widget.builder.call(_isBusy),
    );
  }

  void _onBusyCallback(bool event) {
    setState(() {
      _isBusy = event;
    });
  }
}
