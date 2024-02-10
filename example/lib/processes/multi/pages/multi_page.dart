import 'package:example/processes/multi/state/bloc/events/second_multi_event.dart';
import 'package:example/processes/multi/state/bloc/multi_bloc.dart';
import 'package:example/processes/multi/state/bloc/state/multi_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../state/bloc/events/first_multi_event.dart';

class MultiPage extends StatelessWidget {
  final MultiBloc _bloc;

  const MultiPage(this._bloc, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: BlocBuilder<MultiBloc, MultiState>(
                bloc: _bloc,
                builder: (context, state) {
                  return Text(
                    state.text,
                    style: const TextStyle(
                        fontSize: 32, fontWeight: FontWeight.bold),
                  );
                },
              ),
            ),
            TextButton(
              child: const Text("First",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              onPressed: () => _first(),
            ),
            TextButton(
              child: const Text("Second",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              onPressed: () => _second(),
            ),
            IconButton(onPressed: _cancel, icon: const Icon(Icons.arrow_back)),
          ],
        ),
      ),
    );
  }

  void _first() {
    _bloc.add(FirstMultiEventImpl());
  }

  void _second() {
    _bloc.add(SecondMultiEventImpl());
  }

  void _cancel() {
    _bloc.add(CanceledEvent());
  }
}
