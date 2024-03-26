import 'package:flutter/material.dart';

import '../themes/themes.dart';

/// A custom list tile widget for displaying items with associated dates and amounts.
class MyListTile extends StatelessWidget {
  /// The text to display as the date.
  final String dateText;

  /// The text to display as the item.
  final String itemText;

  /// The text to display as the amount.
  final String amountText;

  /// The color to display on the tile.
  final Color? color;

  /// Constructs a new MyListTile instance.
  ///
  /// [dateText] is the text to display as the date.
  /// [itemText] is the text to display as the item.
  /// [amountText] is the text to display as the amount.
  /// [icon] is the icon to display on the tile.
  const MyListTile(
      {super.key,
      required this.dateText,
      required this.itemText,
      required this.amountText,
      this.color});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      child: ListTile(
        tileColor: textColor,
        title: Text(
          itemText,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 15,
            color: Colors.black87,
          ),
        ),
        subtitle: Text(
          dateText,
          style: const TextStyle(
            fontSize: 15,
            color: textTwo,
          ),
        ),
        trailing: Text(
          amountText,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),

      ),
    );
  }
}
