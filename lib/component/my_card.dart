import 'package:expensifly/themes/themes.dart';
import 'package:flutter/material.dart';

/// A widget representing a card item with user details.
class MyCard extends StatelessWidget {
  /// The name of the user.
  final String userName;

  /// The deposit amount.
  final String deposit;

  /// The date of the transaction.
  final String date;

  /// The status of the transaction.
  final String status;

  /// Constructs a `MyCard` instance.
  ///
  /// [userName] is required.
  /// [deposit] is required.
  /// [date] is required.
  /// [status] is required.

  const MyCard({
    super.key,
    required this.userName,
    required this.deposit,
    required this.date,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12),
      child: Container(
        width: 220,
        height: 130,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5), color: textColor),
        child: Stack(
          children: [
            const Padding(
              padding: EdgeInsets.all(5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CircleAvatar(
                      backgroundColor: Color(0xFFCAEFB1),
                      child: Icon(
                        Icons.arrow_downward,
                        color: Colors.green,
                        size: 28,
                      ))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Text(
                    userName,
                    style: const TextStyle(
                      color: textTwo,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 8,),
                  Text(
                    deposit,
                    style: const TextStyle(
                      color: Colors.green,
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8,),
                  Text(
                    date,
                    style: const TextStyle(
                      color: textTwo,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            )

          ],
        ),
      ),
    );
  }
}
