import 'package:flutter/material.dart';

import '../core/app_colors.dart';
import '../core/icons.dart';

List<Icon> getIcons() {
  return [
    const Icon(
      IconData(personIcon, fontFamily: 'MaterialIcons'),
      color: cranberryDarkPink,
    ),
    const Icon(
      IconData(movieIcon, fontFamily: 'MaterialIcons'),
      color: secondaryDark,
    ),
    const Icon(
      IconData(travelIcon, fontFamily: 'MaterialIcons'),
      color: primaryDark,
    ),
    const Icon(
      IconData(moneyIcon, fontFamily: 'MaterialIcons'),
      color: fourSeasonTeal,
    ),
  ];
}
