import 'package:expense_tracker/model/expense.dart';
import 'package:expense_tracker/widget/expense_list/expenses_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({
    super.key,
    required this.expenses,
    required this.onRemoveExpenses,
  });

  final List<Expense> expenses;
  final void Function(Expense expense) onRemoveExpenses;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (context, index) {
        return Dismissible(
          key: ValueKey(expenses[index]),
          onDismissed: (direction) {
            onRemoveExpenses(expenses[index]);
          },
          child: ExpensesItem(expenses[index]),
        );
      },
    );
  }
}
