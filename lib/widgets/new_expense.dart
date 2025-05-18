import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key});

  @override
  State<StatefulWidget> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: const Column(
        children: <Widget>[
          TextField(
            maxLength: 50,
            // label 적용을 위해서는 decoration 사용
            decoration: InputDecoration(
              label: Text('제목')
            ),
          )
        ],
      ),
    );
  }
}
