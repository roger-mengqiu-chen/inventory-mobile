import 'package:flutter/material.dart';


class ErrorApp extends StatelessWidget {
  final Object error;

  const ErrorApp ({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Builder(
          builder: (context) {
            return AlertDialog(
              icon: const Icon(Icons.error, color: Colors.red),
              title: const Text('Initialization Error'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget> [
                    const Text(
                      'The app failed to start. Please contact for support',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Details: ${error.runtimeType}',
                      style: const TextStyle(color: Colors.redAccent),
                    ),
                    Text('Message: ${error.toString()}'),
                  ],
                ),
              ),
            );
          },
        )
    );
  }
}
