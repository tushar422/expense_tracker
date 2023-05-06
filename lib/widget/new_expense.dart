import 'package:expense_tracker/widget/expense_list/expenses_list.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/model/expense.dart';
import 'package:intl/intl.dart';

final dateFormatter = DateFormat.yMd();

class NewExpense extends StatefulWidget {
  const NewExpense({
    super.key,
    required this.onAddExpense,
  });

  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() {
    return _NewExpensesState();
  }
}

class _NewExpensesState extends State<NewExpense> {
  String title = '';

  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _expenseDate = DateTime.now();
  Category _selectedCategory = Category.leisure;

  @override
  Widget build(context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 50, 30, 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _titleController,
            maxLength: 50,
            decoration: const InputDecoration(
              label: Text('Title'),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  maxLength: 50,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: const InputDecoration(
                    prefixText: '\$ ',
                    label: Text('Amount'),
                  ),
                ),
              ),
              SizedBox(width: 30),
              OutlinedButton.icon(
                onPressed: _openDatePicker,
                icon: Icon(Icons.calendar_month_outlined),
                label: Text((_expenseDate == null)
                    ? "Pick Date"
                    : dateFormatter.format(_expenseDate!)),
              )
            ],
          ),
          Row(
            children: [
              DropdownButton(
                value: _selectedCategory,
                items: Category.values
                    .map(
                      (category) => DropdownMenuItem(
                        value: category,
                        child: Text(toBeginningOfSentenceCase(category.name) ??
                            "Error"),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value == null) return;
                  setState(() {
                    _selectedCategory = value;
                  });
                },
              ),
              Spacer(),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: _submitExpenseData,
                child: Text("Save"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _submitExpenseData() {
    var title = _titleController.text.trim();
    var amount = double.tryParse(_amountController.text);

    final isValid = title.isNotEmpty &&
        amount != null &&
        amount > 0 &&
        _expenseDate != null;
    if (!isValid) {
      showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text('Invalid Input'),
            content:
                Text('Make sure a valid title, amount and date is selected.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: Text('Okay'),
              ),
            ],
          );
        },
      );
      return;
    }
    widget.onAddExpense(
      Expense(
        title: title,
        amount: amount,
        date: _expenseDate!,
        category: _selectedCategory,
      ),
    );
    Navigator.pop(context);
  }

  void _openDatePicker() async {
    final now = DateTime.now();
    final first = now.subtract(Duration(days: 365));
    final last = now.add(Duration(days: 365));
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: _expenseDate ?? now,
      firstDate: first,
      lastDate: last,
    );
    setState(() {
      _expenseDate = selectedDate;
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }
}
