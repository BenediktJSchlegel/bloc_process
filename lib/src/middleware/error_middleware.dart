import '../../bloc_process.dart';

abstract interface class ErrorMiddleware<TError extends ErrorEvent>
    implements Middleware {
  Future<void> onError(TError error);
}
