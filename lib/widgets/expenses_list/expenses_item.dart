import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class ExpensesItem extends StatelessWidget {
  final Expense expense;

  const ExpensesItem(this.expense, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
        child: Column(
          children: <Widget>[
            Text(expense.title),
            const SizedBox(height: 4),
            Row(
              children: <Widget>[
                Text(
                  '\$${expense.amount.toStringAsFixed(2)}', // 두 자리 수까지 표현 12.3433 => 12.34
                ),
                const Spacer(),
                Row(
                  children: [
                    Icon(categoryIcons[expense.category]),
                    const SizedBox(width: 8,),
                    Text(expense.formattedDate)
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
