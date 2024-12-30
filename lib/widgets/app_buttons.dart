import 'package:flutter/material.dart';

final ButtonStyle _buttonStyle = ButtonStyle(
  fixedSize: WidgetStateProperty.all<Size>(const Size(200, 60)),
  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
    RoundedRectangleBorder(borderRadius: BorderRadius.circular(13.0)),
  ),
);

class AppButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;

  const AppButton({
    super.key,
    this.onPressed,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed, style: _buttonStyle, child: child);
  }
}

class AppTextButton extends StatelessWidget {
  final VoidCallback? onPressed;

  final String text;
  final Color fontColor;
  final double fontSize;

  final double width;
  final double height;

  const AppTextButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.width = 200.0,
    this.height = 60.0,
    this.fontSize = 20.0,
    this.fontColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    var buttonStyle = ButtonStyle(
      fixedSize: WidgetStateProperty.all<Size>(Size(width, height)),
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(13.0)),
      ),
      padding: WidgetStateProperty.all<EdgeInsetsDirectional>(
        const EdgeInsetsDirectional.only(start: 10.0, end: 10.0),
      ),
    );

    return ElevatedButton(
      onPressed: onPressed,
      style: buttonStyle,
      child: Text(
        text,
        style: TextStyle(
          color: fontColor,
          fontSize: fontSize,
        ),
      ),
    );
  }
}
