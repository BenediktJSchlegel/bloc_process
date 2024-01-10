import 'package:bloc_process/bloc_process.dart';
import 'package:example/processes/registration/state/bloc/registration_process_bloc.dart';
import 'package:example/processes/registration/state/chain/registration_link.dart';
import 'package:example/processes/registration/state/controller/registration_process_controller.dart';
import 'package:example/processes/registration/state/navigation/registration_process_navigator.dart';
import 'package:example/processes/registration/state/result/registration_process_result.dart';
import 'package:example/processes/showcase/showcase_link_input.dart';
import 'package:example/processes/showcase/showcase_link_output.dart';
import 'package:example/processes/showcase/state/bloc/showcase_bloc.dart';
import 'package:example/processes/showcase/state/chain/showcase_link.dart';
import 'package:example/processes/showcase/state/navigation/showcase_navigator.dart';
import 'package:flutter/material.dart';

import 'processes/showcase/state/controller/showcase_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _startProcessChainShowcase(BuildContext context) {
    final ShowcaseBloc one = ShowcaseBloc();
    final ShowcaseBloc two = ShowcaseBloc();
    final ShowcaseBloc three = ShowcaseBloc();
    final ShowcaseBloc four = ShowcaseBloc();
    final ShowcaseBloc five = ShowcaseBloc();
    final ShowcaseBloc six = ShowcaseBloc();
    final ShowcaseBloc seven = ShowcaseBloc();

    final oneController = ShowcaseController(
      bloc: one,
      navigationBuilder: (ctx) => ShowcaseNavigator(one, ctx),
      persistAfterCompletion: true,
    );

    final twoController = ShowcaseController(
      bloc: two,
      navigationBuilder: (ctx) => ShowcaseNavigator(two, ctx),
      persistAfterCompletion: true,
    );

    final threeController = ShowcaseController(
      bloc: three,
      navigationBuilder: (ctx) => ShowcaseNavigator(three, ctx),
      persistAfterCompletion: true,
    );

    final fourController = ShowcaseController(
      bloc: four,
      navigationBuilder: (ctx) => ShowcaseNavigator(four, ctx),
      persistAfterCompletion: true,
    );

    final fiveController = ShowcaseController(
      bloc: five,
      navigationBuilder: (ctx) => ShowcaseNavigator(five, ctx),
      persistAfterCompletion: true,
    );

    final sixController = ShowcaseController(
      bloc: six,
      navigationBuilder: (ctx) => ShowcaseNavigator(six, ctx),
      persistAfterCompletion: true,
    );

    final sevenController = ShowcaseController(
      bloc: seven,
      navigationBuilder: (ctx) => ShowcaseNavigator(seven, ctx),
      persistAfterCompletion: true,
    );

    ProcessChain<ShowcaseLinkInput, ShowcaseLinkOutput> chain =
        ProcessChain<ShowcaseLinkInput, ShowcaseLinkOutput>(
      links: [
        ShowcaseLink(
          oneController,
          outputTransformer: (output) => _transformOutput(
            output,
            "Second Process",
            "Continue to third",
            Colors.red,
          ),
        ),
        ShowcaseLink(
          twoController,
          inputTransformer: (input) {
            input as ShowcaseLinkInput;

            return ShowcaseLinkInput(
              input.previousProcessNames,
              input.previousProcessName,
              input.headerText,
              input.continueText,
              input.color,
              true,
              false,
              input.previousAction,
            );
          },
          outputTransformer: (output) => _transformOutput(
            output,
            "Third Process",
            "Continue to fourth",
            Colors.yellow,
          ),
        ),
        DecisionLink(
          condition: (input) => input.previousAction == "skip",
          then: PassLink(
            outputTransformer: (output) {
              // output is a showcase-input since PassLink just forwards the input as the output
              // must alter the input so it fits the next process
              output as ShowcaseLinkInput;

              return ShowcaseLinkInput(
                output.previousProcessNames,
                output.previousProcessName,
                "Fourth Process",
                "Continue to fifth",
                Colors.purple,
                false,
                false,
                output.previousAction,
              );
            },
          ),
          elseThen: ShowcaseLink(
            threeController,
            outputTransformer: (output) => _transformOutput(
              output,
              "Fourth Process",
              "Continue to fifth",
              Colors.purple,
            ),
          ),
        ),
        ShowcaseLink(
          fourController,
          inputTransformer: (input) {
            input as ShowcaseLinkInput;

            return ShowcaseLinkInput(
              input.previousProcessNames,
              input.previousProcessName,
              input.headerText,
              input.continueText,
              input.color,
              false,
              true,
              input.previousAction,
            );
          },
          outputTransformer: (output) => _transformOutput(
            output,
            "Fifth Process",
            "Continue to sixth",
            Colors.pinkAccent,
          ),
        ),
        DecisionLink(
          condition: (input) => input.previousAction == "breakout",
          then: BreakoutLink(
            outputTransformer: (output) {
              return ShowcaseLinkOutput(output, "", "");
            },
          ),
          elseThen: PassLink(
            outputTransformer: (output) {
              // output is a showcase-input since PassLink just forwards the input as the output
              // must alter the input so it fits the next process
              output as ShowcaseLinkInput;

              return ShowcaseLinkInput(
                output.previousProcessNames,
                output.previousProcessName,
                "Fifth Process",
                "Continue to sixth",
                Colors.purple,
                false,
                false,
                output.previousAction,
              );
            },
          ),
        ),
        ShowcaseLink(
          fiveController,
          inputTransformer: (input) {
            return ShowcaseLinkInput(
              input.previousProcessNames,
              input.previousProcessName,
              input.headerText,
              input.continueText,
              input.color,
              true,
              true,
              input.previousAction,
            );
          },
          outputTransformer: (output) => _transformOutput(
            output,
            "Sixth Process",
            "Continue to seventh",
            Colors.white24,
          ),
        ),
        DecisionLink(
          condition: (input) => input.previousAction == "breakout",
          then: BreakoutLink(
            outputTransformer: (output) {
              return ShowcaseLinkOutput(output, "", "");
            },
          ),
          elseThen: DecisionLink(
            condition: (input) => input.previousAction == "skip",
            then: PassLink(
              outputTransformer: (output) {
                // output is a showcase-input since PassLink just forwards the input as the output
                // must alter the input so it fits the next process
                output as ShowcaseLinkInput;

                return ShowcaseLinkInput(
                  output.previousProcessNames,
                  output.previousProcessName,
                  "Seventh Process",
                  "end chain",
                  Colors.teal,
                  false,
                  false,
                  output.previousAction,
                );
              },
            ),
            elseThen: ShowcaseLink(
              sixController,
              outputTransformer: (output) => _transformOutput(
                output,
                "Seventh Process",
                "end chain",
                Colors.teal,
              ),
            ),
          ),
        ),
        ShowcaseLink(sevenController),
      ],
      context: context,
      onEndCallback: (_) => {print("finished process")},
    );

    chain.start(ShowcaseLinkInput(
      [],
      "",
      "First Process",
      "Continue to second Process",
      Colors.blue,
      false,
      false,
      "",
    ));
  }

  ShowcaseLinkInput _transformOutput(
      ShowcaseLinkOutput output, String header, String text, Color color) {
    return ShowcaseLinkInput(
      output.input.previousProcessNames,
      output.processName,
      header,
      text,
      color,
      false,
      false,
      output.action,
    );
  }

  void _startProcess(BuildContext context) {
    final RegistrationProcessBloc bloc = RegistrationProcessBloc();
    final processController = RegistrationProcessController(
      bloc: bloc,
      navigationBuilder: (ctx) => RegistrationProcessNavigator(ctx, bloc),
    );

    processController.start(
      context,
      "This is the process input",
      _onRegistrationCompleted,
    );
  }

  void _onRegistrationCompleted(RegistrationProcessResult result) {
    print("Done");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("BloC Process Example"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton(
              child: const Text("Process Demo",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              onPressed: () => _startProcess(context),
            ),
            TextButton(
              child: const Text("ProcessChain Demo",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              onPressed: () => _startProcessChainShowcase(context),
            ),
          ],
        ),
      ),
    );
  }
}
