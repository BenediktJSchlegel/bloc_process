mixin IsTyped<T> {
  bool isSubtypeOf(dynamic value) {
    return value is T;
  }
}
