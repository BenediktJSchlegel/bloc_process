import 'package:bloc_process/src/effects/effect.dart';
import 'package:bloc_process/src/middleware/middleware.dart';

abstract interface class EffectMiddleware<TEffect extends Effect>
    implements Middleware {
  Future<void> onEffect(TEffect effect);
}
