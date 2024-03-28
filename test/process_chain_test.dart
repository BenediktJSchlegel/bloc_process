import 'package:bloc_process/bloc_process.dart';
import 'package:flutter/material.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'src/process/bloc/test_bloc.dart';
import 'src/process/bloc/test_state.dart';
import 'src/process/chain/test_link.dart';
import 'src/process/chain/test_link.mocks.dart';
import 'src/process/io/test_input.dart';
import 'src/process/io/test_output.dart';
import 'src/process/navigation/test_navigator.dart';
import 'src/process/test_process_controller.dart';

class MockBuildContext extends Mock implements BuildContext {}

void main() {
  group("ProcessChain tests", () {
    test("Can be created", () {
      final chain = ProcessChain(
        context: MockBuildContext(),
        links: [],
      );

      expect(chain, isNotNull);
    });

    test("Can be created with ProcessLink", () {
      final chain = ProcessChain(
        context: MockBuildContext(),
        links: [MockTestLink()],
      );

      expect(chain, isNotNull);
    });

    test("Can start", () {
      final link = MockTestLink();

      when(link.inputType).thenReturn(TestInput);
      when(link.isInputType(any)).thenReturn(true);

      final chain = ProcessChain(
        context: MockBuildContext(),
        links: [link],
      );

      chain.start(TestInput(), (output) async {});

      verify(link.start(any, any));
    });

    test("Throws IOError when input type is mismatch", () {
      final link = MockTestLink();

      when(link.inputType).thenReturn(TestInput);
      when(link.isInputType(any)).thenReturn(false);

      final chain = ProcessChain(
        context: MockBuildContext(),
        links: [link],
      );

      expect(() => chain.start(TestInput(), (output) async {}), throwsA(isA<TypeIOError>()));
    });

    test("Starts next link when first completes", () async {
      final bloc = TestBloc(TestState());
      final navigator = TestNavigator();
      final controller = TestProcessController(
        bloc: bloc,
        navigationBuilder: (context) => navigator,
      );

      final firstLink = TestLink(
        controller,
        outputTransformer: (output) => TestInput(),
      );

      final secondLink = MockTestLink();

      when(secondLink.inputType).thenReturn(TestInput);
      when(secondLink.isInputType(any)).thenReturn(true);

      final chain = ProcessChain(
        context: MockBuildContext(),
        links: [firstLink, secondLink],
      );

      chain.start(TestInput(), (output) async {});

      bloc.complete(TestOutput());

      await Future.delayed(const Duration(milliseconds: 250));

      verify(secondLink.start(any, any));
    });

    test("Throws error when output of first link does not match input of second", () {
      final bloc = TestBloc(TestState());
      final navigator = TestNavigator();
      final controller = TestProcessController(
        bloc: bloc,
        navigationBuilder: (context) => navigator,
      );

      final firstLink = TestLink(
        controller,
        outputTransformer: (output) => "bad output",
      );

      final secondLink = MockTestLink();

      when(secondLink.inputType).thenReturn(TestInput);
      when(secondLink.isInputType(any)).thenReturn(false);

      final chain = ProcessChain(
        context: MockBuildContext(),
        links: [firstLink, secondLink],
      );

      chain.start(TestInput(), (output) async {});

      expect(() => bloc.complete(TestOutput()), throwsA(isA<TypeIOError>()));
    });

    test("When DecisionLink condition is true, starts then-Link", () {
      final firstLink = MockTestLink();
      final secondLink = MockTestLink();

      when(firstLink.inputType).thenReturn(TestInput);
      when(firstLink.isInputType(any)).thenReturn(true);

      when(secondLink.inputType).thenReturn(TestInput);
      when(secondLink.isInputType(any)).thenReturn(true);

      final chain = ProcessChain(
        context: MockBuildContext(),
        links: [DecisionLink(condition: (input) => true, then: firstLink, elseThen: secondLink)],
      );

      chain.start(TestInput(), (output) async {});

      verifyNever(secondLink.start(any, any));
      verify(firstLink.start(any, any));
    });

    test("When DecisionLink condition is false, starts then-Link", () {
      final firstLink = MockTestLink();
      final secondLink = MockTestLink();

      when(firstLink.inputType).thenReturn(TestInput);
      when(firstLink.isInputType(any)).thenReturn(true);

      when(secondLink.inputType).thenReturn(TestInput);
      when(secondLink.isInputType(any)).thenReturn(true);

      final chain = ProcessChain(
        context: MockBuildContext(),
        links: [DecisionLink(condition: (input) => false, then: firstLink, elseThen: secondLink)],
      );

      chain.start(TestInput(), (output) async {});

      verifyNever(firstLink.start(any, any));
      verify(secondLink.start(any, any));
    });

    test("When BreakoutLink is hit, calls end callback", () {
      bool called = false;

      final chain = ProcessChain(
        context: MockBuildContext(),
        links: [BreakoutLink()],
      );

      chain.start(TestInput(), (output) async {
        called = true;
      });

      expect(called, true);
    });
  });
}
