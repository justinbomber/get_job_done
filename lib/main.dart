import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 73, 255, 2)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
      // 此次調用setState通知Flutter框架，在這個State中發生了變化，這導致它重新運行下面的build方法，
      // 以便顯示可以反映更新的值。如果我們在不調用setState()的情況下更改_counter，
      // 那麼build方法將不會再次被調用，因此似乎什麼都沒有發生。
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // 此方法每次調用setState時都會重新運行，例如上面的_incrementCounter方法。

    // Flutter框架已經進行了優化，使得重新運行build方法變得快速，
    // 因此您可以只重新構建需要更新的內容，而不必個別更改小部件的實例。
    return Scaffold(
      appBar: AppBar(
        // 試試這個：在這裡更改顏色為特定的顏色（例如Colors.amber），
        // 然後觸發熱重新加載，看看AppBar的顏色是否改變，而其他顏色保持不變。
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // 在這裡，我們從App.build方法創建的MyHomePage對象中獲取值，
        // 並將其用於設置appbar的標題。
        title: Text(widget.title),
      ),
      body: Center(
        // Center是一個布局小部件。它接收一個子小部件並將其定位在父元素的中間。
        child: Column(
          // Column也是一個布局小部件。它接收一個子小部件列表並垂直排列它們。
          // 默認情況下，它在水平方向上尺寸自適應其子小部件，
          // 並嘗試與父元素一樣高。

          // Column具有各種屬性來控制自身的尺寸和子小部件的位置。
          // 在這裡，我們使用mainAxisAlignment來將子小部件在垂直方向上居中對齊；
          // 這裡的主軸是垂直軸，因為Column是垂直的（橫軸將是水平的）。

          // 試試這個：啟用"debug painting"（在IDE中選擇"Toggle Debug Paint"操作，
          // 或在控制台中按"p"），查看每個小部件的框架線條。
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
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
      ), // 此逗號使build方法的自動格式化更好看。
    );
  }
}
