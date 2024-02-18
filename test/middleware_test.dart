import 'package:bloc_process/bloc_process.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'src/process/bloc/test_bloc.dart';
import 'src/process/bloc/test_event.dart';
import 'src/process/bloc/test_state.dart';
import 'src/process/middleware/effect_test_middleware.dart';
import 'src/process/middleware/effect_test_middleware.mocks.dart';
import 'src/process/middleware/error_test_middleware.dart';
import 'src/process/middleware/error_test_middleware.mocks.dart';
import 'src/process/middleware/event_test_middleware.dart';
import 'src/process/middleware/event_test_middleware.mocks.dart';
import 'src/process/middleware/state_test_middleware.dart';
import 'src/process/middleware/state_test_middleware.mocks.dart';
import 'src/process/middleware/test_effect.dart';

void main() {
  group("Middleware Tests", () {
    test("Can mount middleware", () {
      TestBloc bloc = TestBloc(TestState());

      bloc.mountMiddleware([
        EffectTestMiddleware(),
        ErrorTestMiddleware(),
        EventTestMiddleware(),
        StateTestMiddleware(),
      ]);

      expect(bloc, isNotNull);
    });

    test("Triggers effect middleware on effect", () {
      TestBloc bloc = TestBloc(TestState());

      final middleware = MockEffectTestMiddleware();
      final effect = TestEffect();

      bloc.mountMiddleware([
        middleware,
      ]);

      bloc.emitEffect(effect);

      verify(middleware.onEffect(effect));
    });

    test("Triggers error middleware on error", () {
      TestBloc bloc = TestBloc(TestState());

      final middleware = MockErrorTestMiddleware();
      final error = ErrorEvent("test");

      bloc.mountMiddleware([
        middleware,
      ]);

      bloc.emitError(error);

      verify(middleware.onError(error));
    });

    test("Triggers event middleware on event", () {
      TestBloc bloc = TestBloc(TestState());

      final middleware = MockEventTestMiddleware();
      final event = TestEvent();

      bloc.mountMiddleware([
        middleware,
      ]);

      bloc.add(event);

      verify(middleware.onEvent(event));
    });

    test("Triggers state middleware on stateChange", () async {
      TestBloc bloc = TestBloc(TestState());

      final middleware = MockStateTestMiddleware();

      bloc.mountMiddleware([
        middleware,
      ]);

      bloc.add(TestEvent());

      // wait for event to propagate
      await Future.delayed(const Duration(milliseconds: 50));

      verify(middleware.onStateChanged(any));
    });
  });
}
