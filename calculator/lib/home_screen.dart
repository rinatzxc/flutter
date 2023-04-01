import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var num1, num2, sum;
  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();

  void add() {
    num1 = int.parse(t1.text);
    num1 = int.parse(t1.text);
    setState(() {
      sum = num1 + num2;
    });
  }

  void sub() {
    num1 = int.parse(t1.text);
    num1 = int.parse(t1.text);
    setState(() {
      sum = num1 - num2;
    });
  }

   void mul() {
    num1 = int.parse(t1.text);
    num1 = int.parse(t1.text);
    setState(() {
      sum = num1 * num2;
    });
  }

    void div() {
    num1 = int.parse(t1.text);
    num1 = int.parse(t1.text);
    setState(() {
      sum = num1 / num2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text('Ответ: ${sum == null ? 0 : sum}', style: TextStyle(fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.green,),),
            TextField(
              decoration:
                  InputDecoration.collapsed(hintText: 'Введите первое число 1'),
              controller: t1,
              keyboardType: TextInputType.number,
            ),
            TextField(
              decoration:
                  InputDecoration.collapsed(hintText: 'Введите первое число 2'),
              controller: t2,
              keyboardType: TextInputType.number,
            ),
            ElevatedButton(
              onPressed: add,
              child: Text('+'),
            ),
            ElevatedButton(
              onPressed: sub,
              child: Text('-'),
            ),
            ElevatedButton(
              onPressed: mul,
              child: Text('*'),
            ),
            ElevatedButton(
              onPressed: div,
              child: Text('/'),
            ),
          ],
        ),
      ),
    );
  }
}
