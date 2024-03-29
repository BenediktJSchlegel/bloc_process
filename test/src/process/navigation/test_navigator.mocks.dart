// Mocks generated by Mockito 5.4.4 from annotations
// in bloc_process/test/src/process/navigation/test_navigator.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:mockito/mockito.dart' as _i1;

import '../bloc/test_bloc.dart' as _i3;
import '../bloc/test_state.dart' as _i4;
import 'test_navigator.dart' as _i2;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

/// A class which mocks [TestNavigator].
///
/// See the documentation for Mockito's code generation for more information.
class MockTestNavigator extends _i1.Mock implements _i2.TestNavigator {
  @override
  void onEnd(_i3.TestBloc? bloc) => super.noSuchMethod(
        Invocation.method(
          #onEnd,
          [bloc],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void onRevive(_i3.TestBloc? bloc) => super.noSuchMethod(
        Invocation.method(
          #onRevive,
          [bloc],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void onStart(_i3.TestBloc? bloc) => super.noSuchMethod(
        Invocation.method(
          #onStart,
          [bloc],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void onStateChanged(
    _i3.TestBloc? bloc,
    _i4.TestState? state,
  ) =>
      super.noSuchMethod(
        Invocation.method(
          #onStateChanged,
          [
            bloc,
            state,
          ],
        ),
        returnValueForMissingStub: null,
      );
}
