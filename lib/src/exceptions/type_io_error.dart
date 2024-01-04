/// Indicates that the input or output of a process was not of expected type.
class TypeIOError extends Error {
  final dynamic _provided;
  final Type _expected;

  TypeIOError(this._provided, this._expected);

  @override
  String toString() {
    return "Type mismatch for ChainLink: Provided: $_provided of type ${_provided.runtimeType}. Expected $_expected";
  }

  /// the expected `Type`
  Type get expected => _expected;

  /// the object provided
  dynamic get provided => _provided;
}
