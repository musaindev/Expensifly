import 'package:expensifly/themes/themes.dart';
import 'package:flutter/material.dart';

/// Widget to display total balance information.
class TotalBalance extends StatelessWidget {
  /// Today's expense amount.
  final String todayAmount;

  /// Monthly expense amount.
  final String monthlyAmount;

  /// Constructor for TotalBalance.
  const TotalBalance({
    Key? key,
    required this.todayAmount,
    required this.monthlyAmount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Container(
        width: 350,
        height: 150,
        decoration: BoxDecoration(
          color: textColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Overview",
                  style: TextStyle(
                    fontSize: 20,
                    color: textColorBk,
                    fontWeight: FontWeight.w600
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text(
                      'Today Expense',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: textTwo,
                      ),
                    ),

                  ],
                ),
                Column(
                  children: [
                    Text(
                      'Monthly Expense',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: textTwo,
                      ),
                    ),

                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    '₹ $todayAmount',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.red
                    ),
                  ),
                  Text(
                    '₹ $monthlyAmount',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
