import 'dart:math';

import 'package:expense_tracker/widget/expense_list/expenses_list.dart';
import 'package:expense_tracker/widget/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/model/expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  @override
  Widget build(context) {
    Widget emptyBody = const Center(
      child: Text('No expenses :)'),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text("Minimal Expenses Tracker"),
        actions: [
          IconButton(
            onPressed: _openBottomSheetOverlay,
            icon: Icon(Icons.add_box_rounded),
          ),
        ],
      ),
      body: Column(
        children: [
          Text(" THE EXPENSE LIST : "),
          Expanded(
            child: (_registeredExpenses.isNotEmpty)
                ? ExpensesList(
                    expenses: _registeredExpenses,
                    onRemoveExpenses: _deleteExpense,
                  )
                : emptyBody,
          ),
        ],
      ),
    );
  }

  void _openBottomSheetOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) {
        return NewExpense(
          onAddExpense: _addExpense,
        );
      },
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _deleteExpense(Expense expense) {
    final idx = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 7),
        content: Text('Expense Deleted.'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(idx, expense);
            });
          },
        ),
      ),
    );
  }

  final List<Expense> _registeredExpenses = [
    Expense(
      title: "Flutter Course",
      amount: 51.20,
      date: DateTime.now(),
      category: Category.leisure,
    ),
    Expense(
      title: "Medicine",
      amount: 123.20,
      date: DateTime.now(),
      category: Category.health,
    ),
    Expense(
      title: "Flight",
      amount: 1005.89,
      date: DateTime.now(),
      category: Category.travel,
    ),
    Expense(
      title: "Flutter Course",
      amount: 51.20,
      date: DateTime.now(),
      category: Category.leisure,
    ),
    Expense(
      title: "Medicine",
      amount: 123.20,
      date: DateTime.now(),
      category: Category.health,
    ),
    Expense(
      title: "Flight",
      amount: 1005.89,
      date: DateTime.now(),
      category: Category.travel,
    ),
    Expense(
      title: "Flutter Course",
      amount: 51.20,
      date: DateTime.now(),
      category: Category.leisure,
    ),
    Expense(
      title: "Medicine",
      amount: 123.20,
      date: DateTime.now(),
      category: Category.health,
    ),
    Expense(
      title: "Flight",
      amount: 1005.89,
      date: DateTime.now(),
      category: Category.travel,
    ),
    Expense(
      title: "Flutter Course",
      amount: 51.20,
      date: DateTime.now(),
      category: Category.leisure,
    ),
    Expense(
      title: "Medicine",
      amount: 123.20,
      date: DateTime.now(),
      category: Category.health,
    ),
    Expense(
      title: "Flight",
      amount: 1005.89,
      date: DateTime.now(),
      category: Category.travel,
    ),
    Expense(
      title: "Flutter Course",
      amount: 51.20,
      date: DateTime.now(),
      category: Category.leisure,
    ),
    Expense(
      title: "Medicine",
      amount: 123.20,
      date: DateTime.now(),
      category: Category.health,
    ),
    Expense(
      title: "Flight",
      amount: 1005.89,
      date: DateTime.now(),
      category: Category.travel,
    ),
  ];
}
