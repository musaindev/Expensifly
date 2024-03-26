import 'package:expensifly/themes/themes.dart';
import 'package:flutter/material.dart';

/// A square tile widget commonly used for displaying icons.
class SquareTile extends StatelessWidget {
  /// The file path of the image asset to be displayed.
  final String imagePath;

  /// Constructs a new SquareTile instance.
  ///
  /// [imagePath] is the file path of the image asset to be displayed.
  const SquareTile({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
        border: Border.all(color: textColor),
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey[200],
      ),
      child: Image.asset(
        imagePath,
        height: 40,
      ),
    );
  }
}
