import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expensifly/component/my_ListTile.dart';
import 'package:expensifly/component/my_switch_button.dart';
import 'package:expensifly/modules/auth_modules/logics/auth_logics.dart';
import 'package:expensifly/modules/home_Page/expense_logics/expenseLogic.dart';
import 'package:flutter/material.dart';
import 'package:sync_ease/sync_ease.dart';

import '../../themes/themes.dart';

class FilterScreen extends StatelessWidget {
  FilterScreen({super.key});

  final TextEditingController toDateController = TextEditingController();
  final TextEditingController fromDateController = TextEditingController();
  final ExpenseLogic expenseLogic = SyncEaseLogic.get(ExpenseLogic());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).secondaryHeaderColor,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 350,
                height: 250,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Theme.of(context).primaryColor),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () async {
                        DateTime? lastDate = await showDatePicker(
                            context: (context),
                            firstDate: DateTime.parse("2020-01-01"),
                            lastDate: DateTime.parse("2040-01-01"));
                        if (lastDate != null) {
                          fromDateController.text = lastDate.toString();
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 10),
                        child: TextFormField(
                          enabled: false,
                          controller: fromDateController,
                          decoration: InputDecoration(
                            fillColor: textColor,
                            suffixIcon: const Icon(
                              Icons.calendar_month_outlined,
                            ),
                            suffixIconColor: Theme.of(context).primaryColor,
                            filled: true,
                            hintText: "To Date",
                            hintStyle: const TextStyle(color: Colors.black38),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        DateTime? lastDate = await showDatePicker(
                            context: (context),
                            firstDate: DateTime.parse("2020-01-01"),
                            lastDate: DateTime.parse("2040-01-01"));
                        if (lastDate != null) {
                          toDateController.text = lastDate.toString();
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextFormField(
                          enabled: false,
                          controller: toDateController,
                          decoration: InputDecoration(
                            fillColor: textColor,
                            suffixIcon: const Icon(
                              Icons.calendar_month_outlined,
                            ),
                            suffixIconColor: Theme.of(context).primaryColor,
                            filled: true,
                            hintText: "To Date",
                            hintStyle: const TextStyle(color: Colors.black38),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: MySwitchButton(
                            containerHeight: 40,
                            containerWidth: 100,
                            containerDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: switchBgColor),
                            title: "Submit",
                            titleColor: textColor,
                            onPressed: () {
                              expenseLogic.getExpenseData(
                                  fromDate: fromDateController.text,
                                  toDate: toDateController.text);
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: MySwitchButton(
                            containerHeight: 40,
                            containerWidth: 100,
                            containerDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: switchBgColor),
                            title: "Clear",
                            titleColor: textColor,
                            onPressed: () {
                              //   dataList.clear();
                              //   setState(() {});
                              // },
                            }
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // Expanded(
            //   child: EaseBuilder<List<QueryDocumentSnapshot>>(
            //       ease:expenseLogic.dataList ,
            //       builder: ( BuildContext context, dataList){
            //         return
            //           ListView.builder(
            //               itemCount: dataList.length,
            //               itemBuilder: (context, index) {
            //                 return MyListTile(
            //                     dateText: dataList[index].get('date'),
            //                     dateTextColor: textColor,
            //                     itemText: dataList[index].get('item'),
            //                     itemTextColor: textColor,
            //                     amountText: dataList[index].get('amount'),
            //                     amountTextColor: textColor,
            //                     icon: Icon(
            //                       dataList[index].get("status") == "d"
            //                           ? Icons.arrow_upward
            //                           : Icons.arrow_downward,
            //                       size: 18,
            //                       color: dataList[index].get("status") == "c"
            //                           ? Colors.green
            //                           : Colors.red,
            //                     ));
            //               }),
            //       })
            // )
          ],
        ),
      ),
    );
  }
}
