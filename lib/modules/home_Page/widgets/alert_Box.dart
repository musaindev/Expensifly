import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expensifly/data/models/user.dart';
import 'package:expensifly/modules/home_Page/expense_logics/expenseLogic.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sync_ease/sync_ease.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../../data/models/expense_model.dart';
import '../../../themes/themes.dart';

/// A widget representing an alert dialog box for adding or editing an expense.
class AlertBox extends StatelessWidget {
  final bool isEdit;
  final Expense? expense;
  final TextEditingController dateController = TextEditingController();
  final TextEditingController itemController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final FirebaseFirestore fireExpense = FirebaseFirestore.instance;
  final Ease<String> _selectedStatus = Ease("d");
  final Ease<String> _selectedUserId = Ease("");

  final ExpenseLogic expenseLogic = SyncEaseLogic.get(ExpenseLogic());

  AlertBox({super.key,  this.isEdit = false, this.expense});

  @override
  Widget build(BuildContext context) {
    if (isEdit) {
      dateController.text = expense!.date;
      itemController.text = expense!.item;
      amountController.text = expense!.amount.toString();
      _selectedStatus.value = expense!.status;
    }
    return AlertDialog(
      backgroundColor: Theme.of(context).primaryColor,
      title: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(isEdit ? "Edit Expense" : "Add Expense"),
      ),
      titleTextStyle: const TextStyle(
        fontSize: 18,
        color: textColor,
        fontWeight: FontWeight.bold,
      ),
      content: SingleChildScrollView(
        child: ListBody(
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: InkWell(
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    firstDate: DateTime.parse("2020-01-01"),
                    lastDate: DateTime.parse("2040-01-01"),
                  );
                  if (pickedDate != null) {
                    var formattedDate =
                    DateFormat('dd-MM-yyyy').format(pickedDate);
                    dateController.text = formattedDate;
                  }
                },
                child: TextFormField(
                  enabled: false,
                  onTap: () async {},
                  controller: dateController,
                  keyboardType: TextInputType.datetime,
                  decoration: InputDecoration(
                    disabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: textColor),
                    ),
                    border: const OutlineInputBorder(),
                    hintText: "Date",
                    suffixIcon: const Icon(Icons.calendar_month_outlined),
                    suffixIconColor: Theme.of(context).primaryColor,
                    hintStyle: const TextStyle(
                      color: Colors.white54,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: TextFormField(
                controller: itemController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "remark",
                  hintStyle: TextStyle(
                    color: Colors.white54,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Amount",
                  hintStyle: TextStyle(
                    color: Colors.white54,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: EaseBuilder(
                ease: _selectedStatus,
                builder: (BuildContext context, String value) {
                  return Column(
                    children: [
                      ToggleSwitch(
                        minWidth: 107.0,
                        initialLabelIndex: value == "c" ? 0 : 1,
                        cornerRadius: 10.0,
                        activeFgColor: Colors.white,
                        inactiveBgColor: Colors.grey,
                        inactiveFgColor: Colors.white,
                        totalSwitches: 2,
                        labels: const ['Credit', 'Debit'],
                        icons: const [
                          Icons.arrow_circle_down,
                          Icons.arrow_circle_up
                        ],
                        activeBgColors: const [
                          [Colors.green],
                          [Colors.red]
                        ],
                        onToggle: (index) async {
                          if (index == 0) {
                            _selectedStatus.value = 'c';
                          } else {
                            _selectedStatus.value = 'd';
                          }
                        },
                      ),
                      value == 'c'
                          ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: EaseBuilder(
                          ease: _selectedUserId,
                          builder: (BuildContext context, String value) {
                            return SizedBox(
                              height: 60,
                              child: DropdownButtonFormField(
                                icon: const Icon(Icons.arrow_drop_down_circle_outlined),
                                iconSize: 28,
                                iconEnabledColor: textColor,

                                decoration: const InputDecoration(
                                  hintText: "users",
                                  border: OutlineInputBorder(),
                                  prefixIcon: Icon(Icons.person_outline_rounded,size: 28,),

                                  prefixIconColor: textColor,
                                  hintStyle: TextStyle(
                                    color: Colors.white54,
                                  )

                                ),
                                items: expenseLogic.users
                                    .map((User user) {
                                  return DropdownMenuItem(
                                    value: user.userId,
                                    child: Text(user.userName),
                                  );
                                })
                                    .toList(),
                                onChanged: (newValue) {
                                  _selectedUserId.value = newValue as String;
                                },
                              ),
                            );
                          },
                        ),
                      )
                          : const SizedBox(),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
      actions: [

        TextButton(
          onPressed: () {
            Navigator.pop(context, 'Cancel');
          },
          child: const Text(
            "Cancel",
            style: TextStyle(
              fontSize: 18,
              color: textColor,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        TextButton(
          onPressed: () async {
            if (dateController.text.isEmpty ||
                itemController.text.isEmpty ||
                amountController.text.isEmpty) {
              return;
            } else {
              if (isEdit) {
                expenseLogic.update(
                  date: dateController.text,
                  item: itemController.text,
                  amount: amountController.text,
                  status: _selectedStatus.value,
                  userId: _selectedUserId.value,
                );
              } else {
                expenseLogic.addExpenses(
                  date: dateController.text,
                  item: itemController.text,
                  amount: amountController.text,
                  status: _selectedStatus.value,
                  userId: _selectedUserId.value,
                );
              }
              Navigator.pop(context);
            }



          },
          child: Text(
            isEdit ? "Update" : "Add",
            style: const TextStyle(
              fontSize: 18,
              color: textColor,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ],
    );
  }
}
