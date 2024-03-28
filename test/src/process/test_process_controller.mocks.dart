// Mocks generated by Mockito 5.4.4 from annotations
// in bloc_process/test/src/process/test_process_controller.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i6;

import 'package:flutter/widgets.dart' as _i4;
import 'package:mockito/mockito.dart' as _i1;

import 'bloc/test_bloc.dart' as _i2;
import 'io/test_input.dart' as _i5;
import 'io/test_output.dart' as _i7;
import 'test_process_controller.dart' as _i3;

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

class _FakeTestBloc_0 extends _i1.SmartFake implements _i2.TestBloc {
  _FakeTestBloc_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [TestProcessController].
///
/// See the documentation for Mockito's code generation for more information.
class MockTestProcessController extends _i1.Mock
    implements _i3.TestProcessController {
  @override
  _i2.TestBloc get bloc => (super.noSuchMethod(
        Invocation.getter(#bloc),
        returnValue: _FakeTestBloc_0(
          this,
          Invocation.getter(#bloc),
        ),
        returnValueForMissingStub: _FakeTestBloc_0(
          this,
          Invocation.getter(#bloc),
        ),
      ) as _i2.TestBloc);

  @override
  set bloc(_i2.TestBloc? _bloc) => super.noSuchMethod(
        Invocation.setter(
          #bloc,
          _bloc,
        ),
        returnValueForMissingStub: null,
      );

  @override
  void start(
    _i4.BuildContext? context,
    _i5.TestInput? input,
    _i6.Future<void> Function(_i7.TestOutput)? callback, [
    _i6.Future<void> Function()? backOut,
  ]) =>
      super.noSuchMethod(
        Invocation.method(
          #start,
          [
            context,
            input,
            callback,
            backOut,
          ],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void revive() => super.noSuchMethod(
        Invocation.method(
          #revive,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void fullyClose() => super.noSuchMethod(
        Invocation.method(
          #fullyClose,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i6.Future<void> cancel(_i7.TestOutput? output) => (super.noSuchMethod(
        Invocation.method(
          #cancel,
          [output],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);

  @override
  _i6.Future<void> cancelWithoutOutput() => (super.noSuchMethod(
        Invocation.method(
          #cancelWithoutOutput,
          [],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);

  @override
  bool isStarted() => (super.noSuchMethod(
        Invocation.method(
          #isStarted,
          [],
        ),
        returnValue: false,
        returnValueForMissingStub: false,
      ) as bool);
}
