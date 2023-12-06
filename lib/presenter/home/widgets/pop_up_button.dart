import 'package:flutter/material.dart';

class PopUpButton extends StatelessWidget {
  final Function(dynamic) onSelected;
  final dynamic value;
  final Widget widget;
  final List<Widget>? children;
  final Widget child;

  const PopUpButton({
    Key? key,
    required this.onSelected,
    this.value,
    required this.widget,
    this.children,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 5,
      offset: const Offset(0, 45),
      icon: widget,
      onSelected: onSelected,
      itemBuilder: (BuildContext context) => <PopupMenuEntry>[
        PopupMenuItem(
          value: value,
          child: child,
          /* Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: children,
          ), */
        ),
      ],
    );
  }
}
