import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  final List<Expense> expenses;
  final void Function(Expense expense) removeExpense;

  const ExpensesList({
    super.key,
    required this.expenses,
    required this.removeExpense,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder:
          (ctx, index) => Dismissible(
            key: ValueKey(expenses[index].id),
            onDismissed: (direction) => removeExpense(expenses[index]),
            child: ExpensesItem(expenses[index]),
          ),
    );
  }
}
