import 'package:flutter/material.dart';

import '../themes/themes.dart';

/// A custom icon button widget.
class MyIconButton extends StatelessWidget {
  /// The path to the image asset.
  final String imagePath;

  /// The callback function to be executed when the button is pressed.
  final void Function()? onPressed;

  /// Constructs a new MyIconButton instance.
  ///
  /// [imagePath] is the path to the image asset.
  /// [onPressed] is the callback function to be executed when the button is pressed.
  const MyIconButton(this.imagePath, this.onPressed, {super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Container(
        padding: const EdgeInsets.all(8),
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Image.asset(
          imagePath,
          color: textColor,
        ),
      ),
    );
  }
}
