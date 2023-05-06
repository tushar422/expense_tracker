import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

const uid = Uuid();
final formatter = DateFormat.yMd();

enum Category { food, travel, leisure, health }

const CategoryIcons = {
  Category.food: Icons.fastfood_rounded,
  Category.travel: Icons.flight_takeoff_rounded,
  Category.leisure: Icons.sports_football_rounded,
  Category.health: Icons.health_and_safety_sharp,
};

class Expense {
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  String get formattedDate {
    return formatter.format(date);
  }
}
