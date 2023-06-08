import 'dart:math';
import 'package:flutter/material.dart';

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
// 這是程式的主要部分，它定義了一個 main函數，並在其中創建了一個 
// MaterialApp Widget。在這個 Widget 中，我們定義了一個 Scaffold
// Widget，並在其中創建了一個 Container Widget。在 Container
//  中，我們設置了背景顏色為 0xFF15202D，並在其中創建了一個 
// VariousDiscs Widget，它會在螢幕上顯示多個圓形的圖案
class VariousDiscs extends StatefulWidget {
  final int numberOfDiscs;

  const VariousDiscs(this.numberOfDiscs);

  @override
  State<VariousDiscs> createState() => _VariousDiscsState();
}
// 這個類別 VariousDiscs定義了多個圓形的圖案。在這個類別中，我們定義了一個 
// numberOfDiscs參數，它表示要顯示的圓形數量。在 const關鍵字之前，我們定義了一個 
// StatefulWidget，並在其中定義了一個 _VariousDiscsState類別

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
//     在 build()方法中，我們使用了 Stack和 Positioned來定位和顯示圓形圖案。在 Stack
//  中，我們使用 Center Widget 顯示一個文字，然後使用 GestureDetector
//  Widget 來處理點擊事件。在點擊事件中，我們使用 setState()
//  方法來重新生成新的圓形圖案。在 Stack中，我們使用 for迴圈來遍歷 _discs
//  列表中的每個圓形圖案，並使用 Positioned.fill()和 AnimatedAlign()和 AnimatedContainer()
//  來定位和顯示它們。在 AnimatedAlign()中，我們使用 disc.alignment來指定圓形圖案的對齊方式，在 
// AnimatedContainer()中，我們使用 disc.color和 disc.size來指定圓形圖案的顏色和大小
    return Stack(
      children: [
        const Center(
          child: Text(
            'eat my',
            style: TextStyle(color: Colors.white, fontSize: 50),
          ),
        ),
        GestureDetector(
          onTap: () => setState(() {
            _makeDiscs(); // 在點擊手勢時，生成新的 DiscData 物件並更新狀態
          }),
          child: Stack(children: [
            for (final disc in _discs)
              Positioned.fill(
                child: AnimatedAlign(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                  alignment: disc.alignment, // 使用 disc 物件的對齊方式
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    decoration: BoxDecoration(
                      color: disc.color, // 使用 disc 物件的顏色
                      shape: BoxShape.circle,
                    ),
                    height: disc.size, // 使用 disc 物件的大小
                    width: disc.size,
                  ),
                ),
              ),
          ]),
        ),
      ],
    );
  }
}
