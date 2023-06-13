import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
      name: "Macbook Pro 16in",
      amount: 3299.99,
      date: DateTime.now(),
      category: Category.work,
    ),
    Expense(
      name: "Plane Ticket",
      amount: 1099.99,
      date: DateTime.now(),
      category: Category.leisure,
    ),
    Expense(
      name: "Donair",
      amount: 5.45,
      date: DateTime.now(),
      category: Category.food,
    ),
  ];
  @override
  build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("1"),
            Text("2"),
          ],
        ),
      ),
    );
  }
}
