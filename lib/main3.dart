import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/thirdPage': (context) => ThirdPage(),
        ExtractScreenArguments.routeName: (context) => ExtractScreenArguments(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == PassScreenArguments.routeName) {
          final args = settings.arguments as ScreenArguments;

          return MaterialPageRoute(
            builder: (context) {
              return PassScreenArguments(
                title: args.title,
                message: args.message,
              );
            },
          );
        }

        assert(false, 'Need to give required variable');
        return null;
      },
      title: 'Navigation with Arguments',
      home: ThirdPage(),
    );
  }
}

class ThirdPage extends StatelessWidget {
  const ThirdPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Page'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  ExtractScreenArguments.routeName,
                  arguments: ScreenArguments(
                    'Ini title yang di send',
                    'ini message yang di send dari screen argument',
                  ),
                );
              },
              child: Text('Pass data from argument manually'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  PassScreenArguments.routeName,
                  arguments: ScreenArguments(
                    'Ini title yang di send',
                    'ini message yang di send dari pass screen argument',
                  ),
                );
              },
              child: Text('Pass data from pass argument'),
            ),
          ],
        ),
      ),
    );
  }
}

class ScreenArguments {
  final String title;
  final String message;

  ScreenArguments(this.title, this.message);
}

class ExtractScreenArguments extends StatelessWidget {
  const ExtractScreenArguments({Key? key}) : super(key: key);
  static const routeName = '/extractScreenArguments';

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(args.title),
      ),
      body: Center(
        child: Text(args.message),
      ),
    );
  }
}

class PassScreenArguments extends StatelessWidget {
  static const routeName = '/passScreenArguments';
  final String title;
  final String message;

  const PassScreenArguments(
      {Key? key, required this.title, required this.message})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Text(
          message,
        ),
      ),
    );
  }
}
