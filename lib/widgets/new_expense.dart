import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewExpense extends StatefulWidget {
  final void Function(Expense epense) addExpenseData;

  const NewExpense({required this.addExpenseData, super.key});

  @override
  State<StatefulWidget> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _pickedDate;
  Category? _selectedCategory;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );

    if (pickedDate != null) {
      setState(() {
        _pickedDate = pickedDate;
      });
    }
  }

  void _summitExpenseDate() {
    final enteredAmount = double.tryParse(
      _amountController.text,
    ); // double 로 변환되지 않을 경우, null
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;

    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _pickedDate == null ||
        _selectedCategory == null) {
      // show a error message
      showDialog(
        context: context,
        builder:
            (ctx) => AlertDialog(
              title: const Text('잘못된 입력값 입니다.'),
              content: const Text('Please make make sure valid values'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // showDialog 의 context
                  },
                  child: const Text('확인'),
                ),
              ],
            ),
      );
      return;
    }

    widget.addExpenseData(
      Expense(
        title: _titleController.text,
        amount: enteredAmount,
        date: _pickedDate!,
        category: _selectedCategory!,
      ),
    );

    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 46, 16, 16),
      child: Column(
        children: <Widget>[
          TextField(
            controller: _titleController,
            maxLength: 50,
            // label 적용을 위해서는 decoration 사용
            decoration: InputDecoration(label: const Text('제목')),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    label: const Text('금액'),
                    prefixText: '\$',
                  ),
                ),
              ),
              // Date input
              const SizedBox(width: 16),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      _pickedDate == null
                          ? '날짜 선택'
                          : formatter.format(_pickedDate!),
                    ),
                    IconButton(
                      onPressed: _presentDatePicker,
                      icon: const Icon(Icons.calendar_month),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: <Widget>[
              DropdownButton(
                value: _selectedCategory,
                hint: const Text('카테고리'),
                items:
                    Category.values
                        .map(
                          (category) => DropdownMenuItem(
                            value: category,
                            child: Text(category.name.toUpperCase()),
                          ),
                        )
                        .toList(),
                onChanged: (value) {
                  setState(() {
                    if (value == null) {
                      return;
                    }
                    setState(() {
                      _selectedCategory = value;
                    });
                  });
                },
              ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('취소'),
              ),
              ElevatedButton(
                onPressed: _summitExpenseDate,
                child: const Text('저장'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
