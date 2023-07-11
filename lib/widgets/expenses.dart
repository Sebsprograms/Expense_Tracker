import 'package:expense_tracker/widgets/chart/chart.dart';
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

  void addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void showAddExpenseOverlay() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx) {
          return NewExpense(
            addExpense: addExpense,
          );
        });
  }

  void _removeExpense(Expense expense) {
    final index = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text("Successfully deleted."),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(index, expense);
            });
          },
        ),
      ),
    );
  }

  @override
  build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    Widget mainContent = const Expanded(
      child: Center(
        child: Text("No Expense found. Start adding some!"),
      ),
    );

    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registeredExpenses,
        removeExpense: _removeExpense,
      );
    }
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
          child: width < 600
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Chart(expenses: _registeredExpenses),
                    mainContent,
                  ],
                )
              : Row(
                  children: [
                    Expanded(
                      child: Chart(expenses: _registeredExpenses),
                    ),
                    mainContent,
                  ],
                )),
    );
  }
}
