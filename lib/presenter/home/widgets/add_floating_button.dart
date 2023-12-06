import 'package:flutter/material.dart';

class AddFloatingButton extends StatelessWidget {
  final VoidCallback onTap;
  final Color backgroundColor;
  final Color iconColor;
  final IconData iconData;

  const AddFloatingButton({
    Key? key,
    required this.onTap,
    required this.backgroundColor,
    required this.iconColor,
    required this.iconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onTap,
      backgroundColor: backgroundColor,
      child: Icon(
        iconData,
        color: iconColor,
        weight: 15,
      ),
    );
  }
}
