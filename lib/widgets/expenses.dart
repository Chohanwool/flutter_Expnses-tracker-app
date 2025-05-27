import 'package:expense_tracker/data/expenseList.dart';
import 'package:expense_tracker/widgets/chart/chart.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = expenseList;

  // appBar 메뉴 버튼
  void _openAddExpenseOverlay() {
    // State 상속받으면 context를 사용할 수 있다.
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(addExpenseData: _addExpense),
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);

    setState(() {
      _registeredExpenses.remove(expense);
    });

    //
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(milliseconds: 2000),
        content: Text('지출내역 : ${expense.title} 삭제'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              //_registeredExpenses.add(expense);
              _registeredExpenses.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // 메인컨텐츠 영역 동적으로 할당
    Widget? mainContent;

    // 지출 내역 등록 여부에 따라 분기 처리
    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registeredExpenses,
        removeExpense: _removeExpense,
      );
    } else {
      mainContent = const Center(
        child: Text('No expenses found. Start adding some!'),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Expense Tracker'),
        // toolBar의 사용되는 버튼들을 지정하는데 보통 사용한다
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Chart(expenses: _registeredExpenses),
            Expanded(child: mainContent),
          ],
        ),
      ),
    );
  }
}
