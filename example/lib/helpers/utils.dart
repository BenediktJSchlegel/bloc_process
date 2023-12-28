import 'package:flutter/material.dart';

class Utils {
  late BuildContext context;

  Utils(this.context);

  void showErrorDialog(String message) {
    final AlertDialog dialog = AlertDialog(
      title: Text(message),
      icon: const Icon(Icons.error),
      actions: [
        TextButton(
          child: const Text("Ok"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );

    showDialog(context: context, builder: (_) => dialog);
  }
}
