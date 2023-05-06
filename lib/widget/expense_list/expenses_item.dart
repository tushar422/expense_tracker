import 'package:expense_tracker/model/expense.dart';
import 'package:flutter/material.dart';


class ExpensesItem extends StatelessWidget {
  const ExpensesItem(
    this.expense, {
    super.key,
  });

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 25,
        ),
        child: Row(
          children: [
            Icon(
              CategoryIcons[expense.category],
              size: 40,
            ),
            SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(expense.title),
                Text(
                  expense.formattedDate,
                  textAlign: TextAlign.start,
                ),
                Text(expense.category.name)
              ],
            ),
            Spacer(),
            Text("\$ ${expense.amount}"),
          ],
        ),
      ),
    );
  }
}
