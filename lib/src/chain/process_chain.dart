import 'package:bloc_process/src/helper/input_output_typed.dart';
import 'package:flutter/widgets.dart';

import 'links/chain_link.dart';

class ProcessChain<TInput, TOutput> with InputOutputTyped<TInput, TOutput> {
  final BuildContext _context;
  final List<ChainLink> _links;
  final void Function(TOutput output) _onEndCallback;

  int _index = 0;
  bool _hasStarted = false;

  ProcessChain({
    required List<ChainLink> links,
    required BuildContext context,
    required void Function(TOutput output) onEndCallback,
  })  : _links = links,
        _context = context,
        _onEndCallback = onEndCallback;

  void start(TInput input) {
    if (_hasStarted) {
      throw Error(); // TODO: Change error. Chain already started
    }

    _hasStarted = true;

    _setup();
    _next(input);
  }

  void _setup() {
    _links.forEach(_registerOnEnd);
  }

  void _registerOnEnd(ChainLink link) {
    link.onEnd = _onLinkCompleted;
  }

  void _next(dynamic lastOutput) {
    ChainLink nextLink = _links[_index];

    if (!nextLink.isInputType(lastOutput)) {
      throw Error(); // TODO: Change error
    }

    _links[_index].start(_context, lastOutput);
  }

  void _onLinkCompleted(dynamic output) {
    if (_isLastLink()) {
      if (!isOutputType(output)) {
        throw Error(); // TODO: throw better error
      }

      _onEndCallback.call(output as TOutput);
    } else {
      _index++;
      _next(output);
    }
  }

  bool _isLastLink() {
    return _index == (_links.length - 1);
  }
}
