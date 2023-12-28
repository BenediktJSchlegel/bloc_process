import 'package:example/state/bloc/registration_process_bloc.dart';
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
  void _startProcess(BuildContext context) {
    final RegistrationProcessBloc bloc = RegistrationProcessBloc();
    final processController = RegistrationProcessController(
      bloc: bloc,
      navigationBuilder: (ctx) => RegistrationProcessNavigator(ctx, bloc),
    );

    processController.start(
        context, "This is the process input", _onRegistrationCompleted);
  }

  void _onRegistrationCompleted(RegistrationProcessResult result) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("BloC Process Example"),
      ),
      body: Center(
        child: IconButton(
          icon: const Icon(Icons.start),
          onPressed: () => _startProcess(context),
        ),
      ),
    );
  }
}
