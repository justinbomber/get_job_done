import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget { //app的主要界面框架
  const MyApp({super.key});

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

class MyAppState extends ChangeNotifier { //app的狀態，運行所需要用到的數據 隨時變換
  var current = WordPair.random();
  void getnext(){
    current = WordPair.random();
    notifyListeners();
  }
}

class MyHomePage extends StatelessWidget { //app的主要部件
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.current;
    final theme = Theme.of(context); // ?取?前主?
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
            Bigcard(pair: pair),
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


class Bigcard extends StatelessWidget {
  const Bigcard({
    super.key,
    required this.pair,
  });

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
