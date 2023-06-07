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
      // �����ե�setState�q��Flutter�ج[�A�b�o��State���o�ͤF�ܤơA�o�ɭP�����s�B��U����build��k�A
      // �H�K��ܥi�H�ϬM��s���ȡC�p�G�ڭ̦b���ե�setState()�����p�U���_counter�A
      // ����build��k�N���|�A���Q�եΡA�]�����G���򳣨S���o�͡C
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // ����k�C���ե�setState�ɳ��|���s�B��A�Ҧp�W����_incrementCounter��k�C

    // Flutter�ج[�w�g�i��F�u�ơA�ϱo���s�B��build��k�ܱo�ֳt�A
    // �]���z�i�H�u���s�c�ػݭn��s�����e�A�Ӥ����ӧO���p���󪺹�ҡC
    return Scaffold(
      appBar: AppBar(
        // �ոճo�ӡG�b�o�̧���C�⬰�S�w���C��]�ҦpColors.amber�^�A
        // �M��Ĳ�o�����s�[���A�ݬ�AppBar���C��O�_���ܡA�Ө�L�C��O�����ܡC
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // �b�o�̡A�ڭ̱qApp.build��k�Ыت�MyHomePage��H������ȡA
        // �ñN��Ω�]�mappbar�����D�C
        title: Text(widget.title),
      ),
      body: Center(
        // Center�O�@�ӥ����p����C�������@�Ӥl�p����ñN��w��b�������������C
        child: Column(
          // Column�]�O�@�ӥ����p����C�������@�Ӥl�p����C��ë����ƦC���̡C
          // �q�{���p�U�A���b������V�W�ؤo�۾A����l�p����A
          // �ù��ջP�������@�˰��C

          // Column�㦳�U���ݩʨӱ���ۨ����ؤo�M�l�p���󪺦�m�C
          // �b�o�̡A�ڭ̨ϥ�mainAxisAlignment�ӱN�l�p����b������V�W�~������F
          // �o�̪��D�b�O�����b�A�]��Column�O�������]��b�N�O�������^�C

          // �ոճo�ӡG�ҥ�"debug painting"�]�bIDE�����"Toggle Debug Paint"�ާ@�A
          // �Φb����x����"p"�^�A�d�ݨC�Ӥp���󪺮ج[�u���C
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
      ), // ���r����build��k���۰ʮ榡�Ƨ�n�ݡC
    );
  }
}
