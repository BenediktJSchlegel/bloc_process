import 'package:bloc_process/bloc_process.dart';
import 'package:mockito/annotations.dart';

@GenerateNiceMocks([MockSpec<ErrorTestMiddleware>()])
class ErrorTestMiddleware implements ErrorMiddleware {
  @override
  Future<void> onError(ErrorEvent effect) {
    return Future.value();
  }
}
