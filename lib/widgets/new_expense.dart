import 'dart:io';

import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({
    super.key,
    required this.addExpense,
  });

  final void Function(Expense expense) addExpense;

  @override
  State<StatefulWidget> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;

  void _selectDate() async {
    final now = DateTime.now();
    final lastYear = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: lastYear,
      lastDate: now,
    );
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _showDialogForPlatform() {
    if (Platform.isIOS || Platform.isMacOS) {
      showCupertinoDialog(
        context: context,
        builder: (ctx) => CupertinoAlertDialog(
          title: const Text("Invalid Entry"),
          content:
              const Text("Please enter a title, amount, category and date."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text("Okay"),
            ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("Invalid Entry"),
          content:
              const Text("Please enter a title, amount, category and date."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text("Okay"),
            ),
          ],
        ),
      );
    }
  }

  void _submitExpense() {
    final amount = double.tryParse(_amountController.text);
    final bool isValidAmount = amount != null && amount > 0;
    if (_titleController.text.trim().isEmpty ||
        !isValidAmount ||
        _selectedDate == null) {
      _showDialogForPlatform();
      return;
    }
    widget.addExpense(Expense(
      name: _titleController.text,
      amount: amount,
      category: _selectedCategory,
      date: _selectedDate!,
    ));
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
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(builder: (ctx, constraints) {
      final width = constraints.maxWidth;
      final isHorizontal = width > 600;
      return SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              16,
              16,
              16,
              16 + keyboardHeight,
            ),
            child: Column(
              children: [
                if (isHorizontal)
                  Row(children: [
                    Expanded(
                      child: TextField(
                        controller: _titleController,
                        maxLength: 50,
                        decoration: const InputDecoration(
                          label: Text("Enter title..."),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: TextField(
                        controller: _amountController,
                        maxLength: 10,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        decoration: const InputDecoration(
                          prefix: Text("\$"),
                          label: Text("Amount"),
                        ),
                      ),
                    )
                  ])
                else
                  TextField(
                    controller: _titleController,
                    maxLength: 50,
                    decoration: const InputDecoration(
                      label: Text("Enter title..."),
                    ),
                  ),
                if (isHorizontal)
                  Row(
                    children: [
                      DropdownButton(
                          value: _selectedCategory,
                          items: Category.values
                              .map((e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(e.name.toUpperCase()),
                                  ))
                              .toList(),
                          onChanged: (category) {
                            if (category == null) return;
                            setState(() {
                              _selectedCategory = category;
                            });
                          }),
                      const Spacer(),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              _selectedDate == null
                                  ? "Selected a Date"
                                  : formatter.format(_selectedDate!),
                            ),
                            IconButton(
                              onPressed: _selectDate,
                              icon: const Icon(Icons.calendar_month),
                            )
                          ],
                        ),
                      ),
                    ],
                  )
                else
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _amountController,
                          maxLength: 10,
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          decoration: const InputDecoration(
                            prefix: Text("\$"),
                            label: Text("Amount"),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              _selectedDate == null
                                  ? "Selected a Date"
                                  : formatter.format(_selectedDate!),
                            ),
                            IconButton(
                              onPressed: _selectDate,
                              icon: const Icon(Icons.calendar_month),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                Row(
                  children: [
                    if (!isHorizontal)
                      DropdownButton(
                          value: _selectedCategory,
                          items: Category.values
                              .map((e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(e.name.toUpperCase()),
                                  ))
                              .toList(),
                          onChanged: (category) {
                            if (category == null) return;
                            setState(() {
                              _selectedCategory = category;
                            });
                          }),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: _submitExpense,
                      child: const Text("Save Expense"),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Cancel"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
