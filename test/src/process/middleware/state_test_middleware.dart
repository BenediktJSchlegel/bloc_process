import 'package:bloc_process/src/bloc/interfaces/process_bloc_state.dart';
import 'package:bloc_process/src/middleware/state_middleware.dart';
import 'package:mockito/annotations.dart';

@GenerateNiceMocks([MockSpec<StateTestMiddleware>()])
class StateTestMiddleware implements StateMiddleware {
  @override
  Future<void> onStateChanged(ProcessBlocState state) {
    print("WORKED");
    return Future.value();
  }
}
