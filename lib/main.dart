import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logging/logging.dart';
import 'dart:developer' as developer;

final _log = Logger('Main');

void main() async {
  Logger.root.level = Level.ALL;

  Logger.root.onRecord.listen((record) {
    developer.log(
      '${record.level.name}: ${record.loggerName}: ${record.time}: ${record.message}',
      time: record.time,
      name: record.loggerName,
      error: record.error,
      stackTrace: record.stackTrace,
    );
  });

  WidgetsFlutterBinding.ensureInitialized();

  try {
    await dotenv.load(fileName: ".env");
    final String appTitle = dotenv.env['APP_NAME'] ?? 'Flutter Demo';
    runApp(MainPage(appTitle: appTitle));
  } catch (e) {
    _log.severe('Error loading .env file: ${e.toString()}');
    runApp(ErrorApp(error: e));
  }
}

class MainPage extends StatelessWidget {
  final String appTitle;
  const MainPage({super.key, required this.appTitle});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: MyHomePage(title: appTitle),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

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
