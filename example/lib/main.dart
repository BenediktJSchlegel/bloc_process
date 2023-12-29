import 'package:bloc_process/bloc_process.dart';
import 'package:example/state/bloc/registration_process_bloc.dart';
import 'package:example/state/chain/registration_link.dart';
import 'package:example/state/controller/registration_process_controller.dart';
import 'package:example/state/navigation/registration_process_navigator.dart';
import 'package:example/state/result/registration_process_result.dart';
import 'package:flutter/material.dart';

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
  void _startProcessChain(BuildContext context) {
    final RegistrationProcessBloc one = RegistrationProcessBloc();
    final RegistrationProcessBloc two = RegistrationProcessBloc();
    final RegistrationProcessBloc three = RegistrationProcessBloc();

    final oneController = RegistrationProcessController(
      bloc: one,
      navigationBuilder: (ctx) => RegistrationProcessNavigator(ctx, one),
    );

    final twoController = RegistrationProcessController(
      bloc: two,
      navigationBuilder: (ctx) => RegistrationProcessNavigator(ctx, two),
    );

    final threeController = RegistrationProcessController(
      bloc: three,
      navigationBuilder: (ctx) => RegistrationProcessNavigator(ctx, three),
    );

    final ProcessChain<String, String> chain = ProcessChain<String, String>(
      context: context,
      onEndCallback: _onChainEnd,
      links: [
        RegistrationLink(oneController, transformer: _transformLinkResult),
        RegistrationLink(twoController, transformer: _transformLinkResult),
        RegistrationLink(threeController, transformer: _transformLinkResult),
      ],
    );

    String input = "This is the chain input";

    chain.start(input);
  }

  String _transformLinkResult(RegistrationProcessResult result) {
    return "This is the output from another link";
  }

  void _onChainEnd(void _) {
    print("Chain done");
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
            IconButton(
              icon: const Icon(Icons.start, size: 48),
              onPressed: () => _startProcess(context),
            ),
            IconButton(
              icon: const Icon(Icons.list_alt, size: 48),
              onPressed: () => _startProcessChain(context),
            ),
          ],
        ),
      ),
    );
  }
}
