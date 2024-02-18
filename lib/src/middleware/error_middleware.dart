import 'package:bloc_process/src/middleware/middleware.dart';

import '../../bloc_process.dart';

abstract interface class ErrorMiddleware<TError extends ErrorEvent>
    implements Middleware {
  Future<void> onError(TError error);
}
