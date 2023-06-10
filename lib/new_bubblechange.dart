import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:english_words/english_words.dart';


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();

  void getnext() {
    current = WordPair.random();
    notifyListeners();
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.current;
    final theme = Theme.of(context);
    var the_style = theme.textTheme.displayMedium!.copyWith(
      fontSize: 30,
      color: const Color.fromARGB(100, 9, 32, 115),
    );

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('A random idea:', style: the_style),
            BigCard(pair: pair),
            SizedBox.expand(
              child: VariousDiscs(50),
            ),
            ElevatedButton(
              onPressed: () {
                appState.getnext();
              },
              child: const Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}

class BigCard extends StatelessWidget {
  const BigCard({
    Key? key,
    required this.pair,
  }) : super(key: key);

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cardColor = Color.fromARGB(106, 108, 118, 145);
    final cardLuminance = cardColor.computeLuminance();
    final fontColor = cardLuminance > 0.5 ? Colors.black : Colors.white;
    final style = theme.textTheme.displayMedium!.copyWith(
      fontSize: 30,
      color: fontColor,
    );

    return Card(
      color: cardColor,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(pair.asLowerCase, style: style),
      ),
    );
  }
}

class VariousDiscs extends StatefulWidget {
  final int numberOfDiscs;

  const VariousDiscs(this.numberOfDiscs);

  @override
  State<VariousDiscs> createState() => _VariousDiscsState();
}

class _VariousDiscsState extends State<VariousDiscs> {
  final _discs = <DiscData>[];

  @override
  void initState() {
    super.initState();
    _makeDiscs();
  }

  void _makeDiscs() {
    _discs.clear();
    for (int i = 0; i < widget.numberOfDiscs; i++) {
      _discs.add(DiscData());
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() {
        _makeDiscs();
      }),
      child: Stack(
        children: _discs.map((disc) {
          return Positioned(
            left: disc.x,
            top: disc.y,
            child: Transform.scale(
              scale: disc.scale,
              child: Container(
                width: disc.size,
                height: disc.size,
                decoration: BoxDecoration(
                  color: disc.color,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class DiscData {
  final double x;
  final double y;
  final double size;
  final double scale;
  final Color color;

  DiscData()
      : x = Random().nextDouble() * 300,
        y = Random().nextDouble() * 300,
        size = Random().nextDouble() * 100 + 50,
        scale = Random().nextDouble() * 0.6 + 0.2,
        color = Color.fromARGB(
          255,
          Random().nextInt(256),
          Random().nextInt(256),
          Random().nextInt(256),
        );
}
