import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:english_words/english_words.dart';


class DiscData {
  static final _rng = Random();

  final double size; // 圓形圖案的大小
  final Color color; // 圓形圖案的顏色
  final Alignment alignment; // 圓形圖案的對齊方式

  DiscData()
      : size = _rng.nextDouble() * 40 + 10, // 隨機生成圓形圖案的大小
        color = Color.fromARGB(
          _rng.nextInt(200),
          _rng.nextInt(255),
          _rng.nextInt(255),
          _rng.nextInt(255),
        ), // 隨機生成圓形圖案的顏色
        alignment = Alignment(
          _rng.nextDouble() * 2 - 1,
          _rng.nextDouble() * 2 - 1,
        ); // 隨機生成圓形圖案的對齊方式
}
// 這段程式碼定義了一個 DiscData類別，它表示圓形圖案的數據。在 
// DiscData類別中，我們使用了 
// Random類別來隨機生成圓形圖案的大小、顏色和對齊方式
class VariousDiscs extends StatefulWidget {
  final int numberOfDiscs;

  const VariousDiscs(this.numberOfDiscs);

  @override
  State<VariousDiscs> createState() => _VariousDiscsState();
}
// 這個類別 VariousDiscs定義了多個圓形的圖案。在這個類別中，我們定義了一個 
// numberOfDiscs參數，它表示要顯示的圓形數量。在 const關鍵字之前，我們定義了一個 
// StatefulWidget，並在其中定義了一個 _VariousDiscsState類別
void main() async {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          color: const Color(0xFF15202D),
          child: const SizedBox.expand(
            child: VariousDiscs(50),
          ),
        ),
      ),
    ),
  );
}

class MyAppState extends ChangeNotifier { //app的狀態，運行所需要用到的數據 隨時變換
  var current = WordPair.random();
  void getnext(){
    current = WordPair.random();
    notifyListeners();
  }
}
// 這是程式的主要部分，它定義了一個 main函數，並在其中創建了一個 
// MaterialApp Widget。在這個 Widget 中，我們定義了一個 Scaffold
// Widget，並在其中創建了一個 Container Widget。在 Container
//  中，我們設置了背景顏色為 0xFF15202D，並在其中創建了一個 
// VariousDiscs Widget，它會在螢幕上顯示多個圓形的圖案


class _VariousDiscsState extends State<VariousDiscs> {
  final _discs = <DiscData>[]; // 一個保存 DiscData 物件的列表

//   在 _VariousDiscsState類別中，我們定義了一個 _discs
//  列表，用來保存圓形圖案的數據。在 initState()方法中，我們使用 _makeDiscs()
//  方法來生成初始的圓形圖案。在 _makeDiscs()方法中，我們清空 _discs列表，然後使用 
//  DiscData類別來生成指定數量的圓形圖案，並將它們添加到 _discs列表中。

  @override
  void initState() {
    super.initState();
    _makeDiscs(); // 初始化時，生成 DiscData 物件
  }

  void _makeDiscs() {
    _discs.clear(); // 清空現有的 discs 列表
    for (int i = 0; i < widget.numberOfDiscs; i++) {
      _discs.add(DiscData()); // 根據 widget.numberOfDiscs 的值生成 DiscData 物件，並將它們添加到 discs 列表中
    }
  }

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.current;
    final theme = Theme.of(context); // ?取?前主?
    var the_style = theme.textTheme.displayMedium!.copyWith(
      fontSize: 30,
      color: const Color.fromARGB(100, 9, 32, 115),
    );
//     在 build()方法中，我們使用了 Stack和 Positioned來定位和顯示圓形圖案。在 Stack
//  中，我們使用 Center Widget 顯示一個文字，然後使用 GestureDetector
//  Widget 來處理點擊事件。在點擊事件中，我們使用 setState()
//  方法來重新生成新的圓形圖案。在 Stack中，我們使用 for迴圈來遍歷 _discs
//  列表中的每個圓形圖案，並使用 Positioned.fill()和 AnimatedAlign()和 AnimatedContainer()
//  來定位和顯示它們。在 AnimatedAlign()中，我們使用 disc.alignment來指定圓形圖案的對齊方式，在 
// AnimatedContainer()中，我們使用 disc.color和 disc.size來指定圓形圖案的顏色和大小
return Scaffold(
  body: Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('A random idea:', style: the_style),
        Stack(
          children: [
            for (final disc in _discs)
              Positioned.fill(
                child: AnimatedAlign(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                  alignment: disc.alignment,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    decoration: BoxDecoration(
                      color: disc.color,
                      shape: BoxShape.circle,
                    ),
                    height: disc.size,
                    width: disc.size,
                  ),
                ),
              ),
          ],
        ),
        Bigcard(pair: pair),
        ElevatedButton(
          onPressed: () {
            appState.getnext();
            context.findAncestorStateOfType<_VariousDiscsState>()?._makeDiscs();
          },
          child: const Text('Next'),
        ),
        ElevatedButton(
          onPressed: () {
            context.findAncestorStateOfType<_VariousDiscsState>()?._makeDiscs();
          },
          child: const Text('Make Discs'),
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

