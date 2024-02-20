// Mocks generated by Mockito 5.4.4 from annotations
// in bloc_process/test/src/process/chain/test_link.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:bloc_process/bloc_process.dart' as _i3;
import 'package:flutter/cupertino.dart' as _i4;
import 'package:mockito/mockito.dart' as _i1;

import '../io/test_input.dart' as _i5;
import 'test_link.dart' as _i2;

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

class _FakeType_0 extends _i1.SmartFake implements Type {
  _FakeType_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [TestLink].
///
/// See the documentation for Mockito's code generation for more information.
class MockTestLink extends _i1.Mock implements _i2.TestLink {
  @override
  set onBackOut(
          void Function(
                  _i3.ProcessLink<
                      dynamic,
                      _i3.ProcessBlocEvent,
                      _i3.ProcessBlocState,
                      dynamic,
                      _i3.ProcessBloc<dynamic, _i3.ProcessBlocEvent,
                          _i3.ProcessBlocState, dynamic>,
                      _i3.ProcessNavigator<
                          _i3.ProcessBloc<dynamic, _i3.ProcessBlocEvent,
                              _i3.ProcessBlocState, dynamic>,
                          _i3.ProcessBlocState>,
                      _i3.ProcessController<
                          dynamic,
                          _i3.ProcessBlocEvent,
                          _i3.ProcessBlocState,
                          dynamic,
                          _i3.ProcessBloc<dynamic, _i3.ProcessBlocEvent,
                              _i3.ProcessBlocState, dynamic>,
                          _i3.ProcessNavigator<
                              _i3.ProcessBloc<dynamic, _i3.ProcessBlocEvent,
                                  _i3.ProcessBlocState, dynamic>,
                              _i3.ProcessBlocState>>>)?
              _onBackOut) =>
      super.noSuchMethod(
        Invocation.setter(
          #onBackOut,
          _onBackOut,
        ),
        returnValueForMissingStub: null,
      );

  @override
  set backOutReference(
          _i3.ProcessLink<
                  dynamic,
                  _i3.ProcessBlocEvent,
                  _i3.ProcessBlocState,
                  dynamic,
                  _i3.ProcessBloc<dynamic, _i3.ProcessBlocEvent,
                      _i3.ProcessBlocState, dynamic>,
                  _i3.ProcessNavigator<
                      _i3.ProcessBloc<dynamic, _i3.ProcessBlocEvent,
                          _i3.ProcessBlocState, dynamic>,
                      _i3.ProcessBlocState>,
                  _i3.ProcessController<
                      dynamic,
                      _i3.ProcessBlocEvent,
                      _i3.ProcessBlocState,
                      dynamic,
                      _i3.ProcessBloc<dynamic, _i3.ProcessBlocEvent,
                          _i3.ProcessBlocState, dynamic>,
                      _i3.ProcessNavigator<
                          _i3.ProcessBloc<dynamic, _i3.ProcessBlocEvent,
                              _i3.ProcessBlocState, dynamic>,
                          _i3.ProcessBlocState>>>?
              _backOutReference) =>
      super.noSuchMethod(
        Invocation.setter(
          #backOutReference,
          _backOutReference,
        ),
        returnValueForMissingStub: null,
      );

  @override
  set onEnd(void Function(dynamic)? _onEnd) => super.noSuchMethod(
        Invocation.setter(
          #onEnd,
          _onEnd,
        ),
        returnValueForMissingStub: null,
      );

  @override
  Type get inputType => (super.noSuchMethod(
        Invocation.getter(#inputType),
        returnValue: _FakeType_0(
          this,
          Invocation.getter(#inputType),
        ),
        returnValueForMissingStub: _FakeType_0(
          this,
          Invocation.getter(#inputType),
        ),
      ) as Type);

  @override
  Type get outputType => (super.noSuchMethod(
        Invocation.getter(#outputType),
        returnValue: _FakeType_0(
          this,
          Invocation.getter(#outputType),
        ),
        returnValueForMissingStub: _FakeType_0(
          this,
          Invocation.getter(#outputType),
        ),
      ) as Type);

  @override
  void start(
    _i4.BuildContext? context,
    _i5.TestInput? input,
  ) =>
      super.noSuchMethod(
        Invocation.method(
          #start,
          [
            context,
            input,
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
  bool isStarted() => (super.noSuchMethod(
        Invocation.method(
          #isStarted,
          [],
        ),
        returnValue: false,
        returnValueForMissingStub: false,
      ) as bool);

  @override
  bool isInputType(dynamic value) => (super.noSuchMethod(
        Invocation.method(
          #isInputType,
          [value],
        ),
        returnValue: false,
        returnValueForMissingStub: false,
      ) as bool);

  @override
  bool isOutputType(dynamic value) => (super.noSuchMethod(
        Invocation.method(
          #isOutputType,
          [value],
        ),
        returnValue: false,
        returnValueForMissingStub: false,
      ) as bool);
}
