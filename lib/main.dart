import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:macos_first/helpers/scrren_size/screen_size.dart';
import 'package:window_size/window_size.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    setWindowTitle('Flutter Demo');
    setWindowMinSize(const Size(200, 300));
    setWindowMaxSize(Size.infinite);
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Choice> choices = <Choice>[
    const Choice(title: 'Home', icon: Icons.home),
    const Choice(title: 'Contact', icon: Icons.contacts),
    const Choice(title: 'Map', icon: Icons.map),
    const Choice(title: 'Phone', icon: Icons.phone),
    const Choice(title: 'Camera', icon: Icons.camera_alt),
    const Choice(title: 'Setting', icon: Icons.settings),
    const Choice(title: 'Album', icon: Icons.photo_album),
    const Choice(title: 'WiFi', icon: Icons.wifi),
  ];

  @override
  Widget build(BuildContext context) {
    final screenSize = getSize(context);
    log(screenSize.toString());
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/image.webp'), fit: BoxFit.fitHeight),
        ),
        child: GridView.count(
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: screenSize == ScreenSize.small
              ? 1
              : screenSize == ScreenSize.normal
                  ? 2
                  : screenSize == ScreenSize.large
                      ? 3
                      : 4,
          mainAxisSpacing: 1.0,
          childAspectRatio: 5 / 3,
          children: List.generate(
            choices.length,
            (index) {
              return Center(
                child: SelectCard(choice: choices[index]),
              );
            },
          ),
        ),
      ),
    );
  }
}

class Choice {
  const Choice({required this.title, required this.icon});

  final String title;
  final IconData icon;
}

class SelectCard extends StatelessWidget {
  const SelectCard({Key? key, required this.choice}) : super(key: key);
  final Choice choice;

  @override
  Widget build(BuildContext context) {
    final TextStyle? textStyle = Theme.of(context).textTheme.bodyText1;
    return Card(
        color: Colors.orange,
        child: Center(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: Icon(choice.icon, size: 50.0, color: textStyle?.color),
                ),
                Text(choice.title, style: textStyle),
              ]),
        ));
  }
}
