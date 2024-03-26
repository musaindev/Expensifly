import 'package:flutter/material.dart';

/// A custom button widget with a text title.
class MySwitchButton extends StatelessWidget {
  /// The title text of the button.
  final String? title;

  /// The callback function to be called when the button is pressed.
  final void Function()? onPressed;

  /// The color of the title text.
  final Color? titleColor;

  /// The width of the container surrounding the button.
  final double? containerWidth;

  /// The height of the container surrounding the button.
  final double? containerHeight;

  /// The decoration of the container surrounding the button.
  final BoxDecoration? containerDecoration;

  /// The child widget to be displayed alongside the title text.
  final Widget? child;

  /// The alignment of the main axis of the button.
  final MainAxisAlignment? mainAxisAlignments;

  /// Constructs a new MySwitchButton instance.
  ///
  /// [title] is the title text of the button.
  /// [onPressed] is the callback function to be called when the button is pressed.
  /// [titleColor] is the color of the title text.
  /// [containerWidth] is the width of the container surrounding the button.
  /// [containerHeight] is the height of the container surrounding the button.
  /// [containerDecoration] is the decoration of the container surrounding the button.
  /// [child] is the child widget to be displayed alongside the title text.
  /// [mainAxisAlignments] is the alignment of the main axis of the button.
  const MySwitchButton({
    super.key,
    this.title,
    this.onPressed,
    this.titleColor,
    this.containerWidth,
    this.containerHeight,
    this.containerDecoration,
    this.child,
    this.mainAxisAlignments,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: containerWidth,
        height: containerHeight,
        decoration: containerDecoration,
        child: TextButton(
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: mainAxisAlignments ?? MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  title!,
                  style: TextStyle(color: titleColor, fontWeight: FontWeight.bold),
                ),
              ),
              if (child != null) child!,
            ],
          ),
        ),
      ),
    );
  }
}
