import 'package:flutter/material.dart';
import 'package:my_travels/core/app_colors.dart';

import '../shared/custom_material_color.dart';

class AppTheme {
  const AppTheme._();

  // Cores comuns
  static const Color primaryColor = Color(0xFF6200EE);
  static const Color secondaryColor = Color(0xFF03DAC6);
  static const Color backgroundColor = Color(0xFFF5F5F5);

  // Tema Light
  static final light = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: CustomMaterialColor.createMaterialColor(purple),
      accentColor: secondaryColor,
      backgroundColor: backgroundColor,
      cardColor: Color(0xFFDEE6F8),
      errorColor: Colors.red,
      brightness: Brightness.light,
    ),
    textSelectionTheme:
        const TextSelectionThemeData(cursorColor: secondaryColor),
    primaryColor: primaryColor,
    scaffoldBackgroundColor: backgroundColor,
    appBarTheme: const AppBarTheme(
      iconTheme: IconThemeData(color: lilyWhite),
      backgroundColor: primaryColor,
      centerTitle: true,
      elevation: 0,
      titleTextStyle: TextStyle(
        color: lilyWhite,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(150, 50),
        backgroundColor: primaryColor,
        foregroundColor: lilyWhite,
        elevation: 5,
      ),
    ),
    iconTheme: const IconThemeData(
      color: primaryColor,
    ),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: const TextStyle(color: primaryColor),
      prefixIconColor:
          MaterialStateColor.resolveWith((Set<MaterialState> states) {
        if (states.contains(MaterialState.focused)) {
          return secondaryColor;
        }
        if (states.contains(MaterialState.error)) {
          return Colors.red;
        }
        return secondaryColor.withOpacity(0.5);
      }),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(50),
        borderSide: const BorderSide(
          color: secondaryColor,
          width: 2,
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(50),
        borderSide: const BorderSide(
          color: secondaryColor,
          width: 2,
        ),
      ),
    ),
    cardTheme: const CardTheme(
      color: Color(0xFFDEE6F8),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: primaryColor,
      elevation: 5,
      selectedIconTheme: IconThemeData(
        color: lilyWhite,
      ),
      selectedLabelStyle: TextStyle(
        color: lilyWhite,
      ),
      selectedItemColor: lilyWhite,
    ),
  );

  // Tema Dark
  static final dark = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: CustomMaterialColor.createMaterialColor(purple),
      accentColor: secondaryColor,
      backgroundColor: scaffoldDarkBackground,
      cardColor: Color.fromARGB(255, 33, 33, 33),
      errorColor: Colors.red,
      brightness: Brightness.dark,
    ),
    textSelectionTheme:
        const TextSelectionThemeData(cursorColor: secondaryColor),
    primaryColor: primaryColor,
    scaffoldBackgroundColor: scaffoldDarkBackground,
    appBarTheme: const AppBarTheme(
      backgroundColor: scaffoldDarkBackground,
      elevation: 0.0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: lilyWhite,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(150, 50),
        backgroundColor: redDark,
        elevation: 5,
        foregroundColor: lilyWhite,
      ),
    ),
    iconTheme: const IconThemeData(
      color: secondaryColor,
    ),
    inputDecorationTheme: InputDecorationTheme(
      prefixIconColor:
          MaterialStateColor.resolveWith((Set<MaterialState> states) {
        if (states.contains(MaterialState.focused)) {
          return primaryColor;
        }
        if (states.contains(MaterialState.error)) {
          return Colors.red;
        }
        return secondaryColor;
      }),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(50),
        borderSide: const BorderSide(
          color: lilyWhite,
          width: 2,
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(50),
        borderSide: const BorderSide(
          color: primaryColor,
          width: 2,
        ),
      ),
    ),
    cardTheme: const CardTheme(
      color: Color.fromARGB(255, 33, 33, 33),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: darkTheme,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: defaultIconColor,
    ),
    chipTheme: ChipThemeData(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(50),
        ),
      ),
      showCheckmark: true,
      elevation: 5,
      pressElevation: 5,
      padding: const EdgeInsets.all(4),
      labelPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      disabledColor: lilyWhite,
      surfaceTintColor: lilyWhite,
      checkmarkColor: lilyWhite,
    ),
  );
}


/* class AppTheme {
  const AppTheme._();

  static final light = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryLight,
      onPrimary: primaryLight,
      primary: primaryLight,
      secondary: secondaryLight,
      onSecondary: secondaryLight,
      outline: secondaryLight,
      onTertiary: secondaryLight,
    ),
    textSelectionTheme:
        const TextSelectionThemeData(cursorColor: secondaryDark),
    primarySwatch: CustomMaterialColor.createMaterialColor(primaryLight),
    primaryColor: primaryLight,
    scaffoldBackgroundColor: kColorLavander,
    appBarTheme: const AppBarTheme(
      iconTheme: IconThemeData(color: lilyWhite),
      backgroundColor: kColorLavander,
      centerTitle: true,
      elevation: 0,
      titleTextStyle: TextStyle(
        color: primaryDark,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(150, 50),
        backgroundColor: primaryLight,
        elevation: 5,
        splashFactory: NoSplash.splashFactory,
      ),
    ),
    iconTheme: const IconThemeData(
      color: primaryDark,
    ),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: const TextStyle(color: primaryDark),
      prefixIconColor:
          MaterialStateColor.resolveWith((Set<MaterialState> states) {
        if (states.contains(MaterialState.focused)) {
          return secondaryLight;
        }
        if (states.contains(MaterialState.error)) {
          return redDark;
        }
        return secondaryLight.withOpacity(0.5);
      }),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(50),
        borderSide: const BorderSide(
          color: secondaryLight,
          width: 2,
        ),
      ),
    ),
    cardTheme: const CardTheme(
      color: Color(0xFFDEE6F8),
    ),
    snackBarTheme: const SnackBarThemeData(),
    drawerTheme: const DrawerThemeData(),
    textTheme: const TextTheme(),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: defaultIconColor,
      elevation: 5,
      selectedIconTheme: IconThemeData(
        color: lilyWhite,
      ),
      selectedLabelStyle: TextStyle(
        color: lilyWhite,
      ),
      selectedItemColor: lilyWhite,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: lilyWhite,
    ),
  );

  static final dark = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryDark,
      onPrimary: primaryDark,
      brightness: Brightness.dark,
      primary: lilyWhite,
      secondary: secondaryDark,
      onSecondary: primaryDark,
      outline: secondaryDark,
      onTertiary: primaryDark,
    ),
    primaryColorDark: primaryDark,
    textSelectionTheme:
        const TextSelectionThemeData(cursorColor: secondaryDark),
    brightness: Brightness.dark,
    primaryColor: primaryDark,
    scaffoldBackgroundColor: scaffolfdBackground,
    canvasColor: secondaryDark,
    primarySwatch: CustomMaterialColor.createMaterialColor(primaryDark),
    inputDecorationTheme: InputDecorationTheme(
      prefixIconColor:
          MaterialStateColor.resolveWith((Set<MaterialState> states) {
        if (states.contains(MaterialState.focused)) {
          return primaryDark;
        }
        if (states.contains(MaterialState.error)) {
          return redDark;
        }
        return secondaryDark;
      }),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(50),
        borderSide: const BorderSide(
          color: primaryDark,
          width: 2,
        ),
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: scaffolfdBackground,
      elevation: 0.0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: lilyWhite,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(150, 50),
        backgroundColor: const Color.fromARGB(255, 81, 78, 135),
        elevation: 5,
        splashFactory: NoSplash.splashFactory,
      ),
    ),
    iconTheme: const IconThemeData(
      color: secondaryDark,
    ),
    cardTheme: const CardTheme(
      color: Color.fromARGB(255, 81, 78, 135),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: darkTheme,
    ),
  );
} */
