/// Mixin that supports generic type checking
mixin InputOutputTyped<TInput, TOutput> {
  /// Tests if the value is of type `TInput`
  bool isInputType(dynamic value) {
    return value is TInput;
  }

  /// Tests if the value is of type `TOutput`
  bool isOutputType(dynamic value) {
    return value is TOutput;
  }

  /// Returns the Type of `TInput`
  Type get inputType => TInput;

  /// Returns the Type of `TOutput`
  Type get outputType => TOutput;
}
