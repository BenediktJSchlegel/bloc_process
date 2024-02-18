import 'package:bloc_process/src/effects/effect.dart';
import 'package:bloc_process/src/middleware/effect_middleware.dart';
import 'package:mockito/annotations.dart';

@GenerateNiceMocks([MockSpec<EffectTestMiddleware>()])
class EffectTestMiddleware implements EffectMiddleware {
  @override
  Future<void> onEffect(Effect effect) {
    return Future.value();
  }
}
