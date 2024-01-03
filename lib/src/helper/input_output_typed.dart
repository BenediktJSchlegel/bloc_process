mixin InputOutputTyped<TInput, TOutput> {
  bool isInputType(dynamic value) {
    return value is TInput;
  }

  bool isOutputType(dynamic value) {
    return value is TOutput;
  }

  Type get inputType => TInput;
  Type get outputType => TOutput;
}
