import 'package:bloc_process/src/bloc/interfaces/process_bloc_event.dart';
import 'package:bloc_process/src/middleware/event_middleware.dart';
import 'package:mockito/annotations.dart';

@GenerateNiceMocks([MockSpec<EventTestMiddleware>()])
class EventTestMiddleware implements EventMiddleware {
  @override
  Future<void> onEvent(ProcessBlocEvent event) {
    return Future.value();
  }
}
