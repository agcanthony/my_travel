import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_travels/core/responsive.dart';

import '../../../core/app_colors.dart';
import '../../../core/primary_text.dart';
import '../../home/home_controller.dart';

class PickDateTravel extends StatelessWidget {
  final VoidCallback onTap;
  const PickDateTravel({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final changeTheme = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: double.infinity,
        height: 60,
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            border: Border.all(
              color: changeTheme ? lilyWhite : Color(0xFF03DAC6),
              width: 0.5,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      PrimaryText(
                        DateFormat('dd-MM-yyyy')
                            .format(HomeController.to.dateRange.value.start)
                            .toString(),
                        size: 10.0.tx,
                        color: changeTheme ? lilyWhite : black,
                      ),
                      Text(' / '),
                      PrimaryText(
                        DateFormat('dd-MM-yyyy')
                            .format(HomeController.to.dateRange.value.end)
                            .toString(),
                        size: 10.0.tx,
                        color: changeTheme ? lilyWhite : black,
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.calendar_month_outlined,
                  color: defaultIconColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
