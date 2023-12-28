abstract interface class ChainEntry<TInput, TOutput> {
  final void Function(TOutput output) onCompleted;
  void start(TInput input);

  ChainEntry(this.onCompleted);
}
