import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:my_travels/core/responsive.dart';

import '../../../core/app_colors.dart';

class AddCard extends StatelessWidget {
  final VoidCallback onTap;
  const AddCard({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width - 12.0.wp;
    final changeTheme = Theme.of(context).brightness == Brightness.dark;
    return SizedBox(
      height: size / 2,
      width: size / 2,
      child: InkWell(
        onTap: onTap,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          child: DottedBorder(
            color: changeTheme ? lilyWhite : black,
            strokeWidth: 2,
            dashPattern: const [10, 8],
            radius: const Radius.circular(10),
            child: const Center(
              child: Icon(
                Icons.add,
                size: 50,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
