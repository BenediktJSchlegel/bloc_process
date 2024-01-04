import 'package:bloc_process/bloc_process.dart';
import 'package:flutter/widgets.dart';

/// Controls the flow of multiple processes in order.
///
/// ---
///
/// `TInput`: the type for the process input
///
/// `TOutput`: the type of the process output
class ProcessChain<TInput, TOutput> with InputOutputTyped<TInput, TOutput> {
  final BuildContext _context;
  final List<ChainLink> _links;
  final void Function(TOutput output) _onEndCallback;

  int _index = 0;
  bool _hasStarted = false;

  /// Creates a new `ProcessChain` using the given [links] and [context]. [links] may not be empty.
  /// [onEndCallback] gets called once the `ProcessChain` runs out of entries in [links] or once a `BreakoutLink` is reached.
  ProcessChain({
    required List<ChainLink> links,
    required BuildContext context,
    required void Function(TOutput output) onEndCallback,
  })  : _links = links,
        _context = context,
        _onEndCallback = onEndCallback;

  /// Starts the first process using the provided [input].
  ///
  /// This may only be called once per `ProcessChain`.
  /// Calling this more than once will cause a `ProcessAlreadyStartedError` to be thrown.
  void start(TInput input) {
    if (_hasStarted) {
      throw ProcessAlreadyStartedError();
    }

    _hasStarted = true;

    _setup();
    _next(input);
  }

  void _setup() {
    _links.forEach(_registerOnEnd);
  }

  void _registerOnEnd(ChainLink link) {
    if (link is DecisionLink) {
      link.onBreakout = (dynamic out) => _onLinkCompleted(out, true);
    }

    link.onEnd = (dynamic out) => _onLinkCompleted(out, link is BreakoutLink);
  }

  void _next(dynamic lastOutput) {
    ChainLink nextLink = _links[_index];

    if (!nextLink.isInputType(lastOutput)) {
      throw TypeIOError(lastOutput, nextLink.inputType);
    }

    if (_links[_index].inputTransformer != null) {
      _links[_index].start(
        _context,
        _links[_index].inputTransformer!.call(lastOutput),
      );

      return;
    }

    _links[_index].start(_context, lastOutput);
  }

  void _onLinkCompleted(dynamic output, bool breakout) {
    if (_isLastLink() || breakout) {
      if (!isOutputType(output)) {
        throw TypeIOError(output, TOutput);
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
