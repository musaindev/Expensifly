import 'package:expensifly/component/my_card.dart';
import 'package:expensifly/component/my_ListTile.dart';
import 'package:expensifly/modules/home_Page/expense_logics/expenseLogic.dart';
import 'package:expensifly/modules/home_Page/widgets/total_balance.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sync_ease/sync_ease.dart';

import '../../../themes/themes.dart';
import 'alert_Box.dart';

/// Widget for displaying the list of expenses.
class ListExpense extends StatefulWidget {
  const ListExpense({
    Key? key,
  }) : super(key: key);

  @override
  State<ListExpense> createState() => _ListExpenseState();
}

class _ListExpenseState extends State<ListExpense> {
  final ExpenseLogic _expenseLogic = SyncEaseLogic.reg(ExpenseLogic());



  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          LogicBuilder(
            logic: _expenseLogic,
            builder: (BuildContext context) {
              return Column(
                children: [
                  TotalBalance(
                    monthlyAmount: _expenseLogic.monthlyExpense.toString(),
                    todayAmount: _expenseLogic.todayExpense.toString(),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Deposit Account",
                          style: TextStyle(
                              fontSize: 15,
                              color: textColorBk,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    height: 150,

                    child: PageView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _expenseLogic.users.length,
                      itemBuilder: (BuildContext context, int index) {
                        if (_expenseLogic.users.isNotEmpty && index < _expenseLogic.users.length) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              MyCard(
                                userName: _expenseLogic.users[index].userName,
                                deposit: '₹ ${_expenseLogic.users[index].deposit}'.toString(),
                                date: _expenseLogic.expenses[index].date,
                                status: _expenseLogic.expenses[index].status,
                              ),
                            ],
                          );
                        } else {
                          // Handle empty or out of bounds case
                          return Container(); // or any other widget you want to display
                        }
                      },
                    )


                  ),

                  const SizedBox(
                    height: 8,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('All Expenses',
                            style: TextStyle(
                                fontSize: 16,
                                color: textColorBk,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 5,),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: _expenseLogic.expenses.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Slidable(
                            endActionPane: ActionPane(
                              motion: const StretchMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (context) {
                                    _expenseLogic.deleteExpense(index);
                                  },
                                  icon: Icons.delete,
                                  padding: const EdgeInsets.all(8),
                                  backgroundColor: Colors.red,
                                  label: "Delete",
                                  autoClose: true,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ],
                            ),
                            startActionPane: ActionPane(
                              motion: const StretchMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (context) {
                                    showSyncAlertBox(builder: (builder) {
                                      return AlertBox(
                                        isEdit: true,
                                        expense: _expenseLogic.expenses[index],
                                      );
                                    });
                                  },
                                  foregroundColor: textColor,
                                  icon: Icons.edit,
                                  backgroundColor: Colors.lightBlueAccent,
                                  label: "Edit",
                                  autoClose: true,
                                  padding: const EdgeInsets.all(8),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ],
                            ),
                            child: MyListTile(
                              dateText: _expenseLogic.expenses[index].date,
                              itemText: _expenseLogic.expenses[index].item,
                              amountText:
                              '₹ ${_expenseLogic.expenses[index].amount}',
                              color:_expenseLogic.expenses[index].status=='c'?Colors.green[800]:Colors.red[800],

                            ),
                          ),

                        ],
                      );
                    },
                  )
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
