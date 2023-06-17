import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
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
      category: Category.travel,
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

  void createExpense({
    required String title,
    required double amount,
    required DateTime date,
    required Category category,
  }) {
    setState(() {
      _registeredExpenses.add(Expense(
        name: title,
        amount: amount,
        date: date,
        category: category,
      ));
    });
  }

  void showAddExpenseOverlay() {
    showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return NewExpense(
            createExpense: createExpense,
          );
        });
  }

  @override
  build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Personal Expense Tracker"),
        actions: [
          IconButton(
            onPressed: showAddExpenseOverlay,
            icon: const Icon(Icons.add),
          )
        ],
      ),
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
