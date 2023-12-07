import 'package:flutter/material.dart';

class ImageWidget extends StatelessWidget {
  final Widget child;
  const ImageWidget({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: SizedBox(
        height: 200,
        width: double.infinity,
        child: ColoredBox(
          color: const Color(0xff263046),
          child: child,
        ),
      ),
    );
  }
}
