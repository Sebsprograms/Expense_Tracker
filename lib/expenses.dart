import 'package:expense_tracker/components/expenses_list.dart';
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
    Expense(
      name: "Gold Pan",
      amount: 30,
      date: DateTime.now(),
      category: Category.leisure,
    ),
  ];
  @override
  build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                color: Colors.green,
                width: double.infinity,
                height: 100,
                child: const Center(child: Text("Chart"))),
            ExpensesList(expenses: _registeredExpenses),
          ],
        ),
      ),
    );
  }
}
