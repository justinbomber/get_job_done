import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:english_words/english_words.dart';


class DiscData {
  static final _rng = Random();

  final double size; // ��ιϮת��j�p
  final Color color; // ��ιϮת��C��
  final Alignment alignment; // ��ιϮת�����覡

  DiscData()
      : size = _rng.nextDouble() * 40 + 10, // �H���ͦ���ιϮת��j�p
        color = Color.fromARGB(
          _rng.nextInt(200),
          _rng.nextInt(255),
          _rng.nextInt(255),
          _rng.nextInt(255),
        ), // �H���ͦ���ιϮת��C��
        alignment = Alignment(
          _rng.nextDouble() * 2 - 1,
          _rng.nextDouble() * 2 - 1,
        ); // �H���ͦ���ιϮת�����覡
}
// �o�q�{���X�w�q�F�@�� DiscData���O�A����ܶ�ιϮת��ƾڡC�b 
// DiscData���O���A�ڭ̨ϥΤF 
// Random���O���H���ͦ���ιϮת��j�p�B�C��M����覡
class VariousDiscs extends StatefulWidget {
  final int numberOfDiscs;

  const VariousDiscs(this.numberOfDiscs);

  @override
  State<VariousDiscs> createState() => _VariousDiscsState();
}
// �o�����O VariousDiscs�w�q�F�h�Ӷ�Ϊ��ϮסC�b�o�����O���A�ڭ̩w�q�F�@�� 
// numberOfDiscs�ѼơA����ܭn��ܪ���μƶq�C�b const����r���e�A�ڭ̩w�q�F�@�� 
// StatefulWidget�A�æb�䤤�w�q�F�@�� _VariousDiscsState���O
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

class MyAppState extends ChangeNotifier { //app�����A�A�B��һݭn�Ψ쪺�ƾ� �H���ܴ�
  var current = WordPair.random();
  void getnext(){
    current = WordPair.random();
    notifyListeners();
  }
}
// �o�O�{�����D�n�����A���w�q�F�@�� main��ơA�æb�䤤�ЫؤF�@�� 
// MaterialApp Widget�C�b�o�� Widget ���A�ڭ̩w�q�F�@�� Scaffold
// Widget�A�æb�䤤�ЫؤF�@�� Container Widget�C�b Container
//  ���A�ڭ̳]�m�F�I���C�⬰ 0xFF15202D�A�æb�䤤�ЫؤF�@�� 
// VariousDiscs Widget�A���|�b�ù��W��ܦh�Ӷ�Ϊ��Ϯ�


class _VariousDiscsState extends State<VariousDiscs> {
  final _discs = <DiscData>[]; // �@�ӫO�s DiscData ���󪺦C��

//   �b _VariousDiscsState���O���A�ڭ̩w�q�F�@�� _discs
//  �C��A�ΨӫO�s��ιϮת��ƾڡC�b initState()��k���A�ڭ̨ϥ� _makeDiscs()
//  ��k�ӥͦ���l����ιϮסC�b _makeDiscs()��k���A�ڭ̲M�� _discs�C��A�M��ϥ� 
//  DiscData���O�ӥͦ����w�ƶq����ιϮסA�ñN���̲K�[�� _discs�C���C

  @override
  void initState() {
    super.initState();
    _makeDiscs(); // ��l�ƮɡA�ͦ� DiscData ����
  }

  void _makeDiscs() {
    _discs.clear(); // �M�Ų{���� discs �C��
    for (int i = 0; i < widget.numberOfDiscs; i++) {
      _discs.add(DiscData()); // �ھ� widget.numberOfDiscs ���ȥͦ� DiscData ����A�ñN���̲K�[�� discs �C��
    }
  }

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.current;
    final theme = Theme.of(context); // ?��?�e�D?
    var the_style = theme.textTheme.displayMedium!.copyWith(
      fontSize: 30,
      color: const Color.fromARGB(100, 9, 32, 115),
    );
//     �b build()��k���A�ڭ̨ϥΤF Stack�M Positioned�өw��M��ܶ�ιϮסC�b Stack
//  ���A�ڭ̨ϥ� Center Widget ��ܤ@�Ӥ�r�A�M��ϥ� GestureDetector
//  Widget �ӳB�z�I���ƥ�C�b�I���ƥ󤤡A�ڭ̨ϥ� setState()
//  ��k�ӭ��s�ͦ��s����ιϮסC�b Stack���A�ڭ̨ϥ� for�j��ӹM�� _discs
//  �C�����C�Ӷ�ιϮסA�èϥ� Positioned.fill()�M AnimatedAlign()�M AnimatedContainer()
//  �өw��M��ܥ��̡C�b AnimatedAlign()���A�ڭ̨ϥ� disc.alignment�ӫ��w��ιϮת�����覡�A�b 
// AnimatedContainer()���A�ڭ̨ϥ� disc.color�M disc.size�ӫ��w��ιϮת��C��M�j�p
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

