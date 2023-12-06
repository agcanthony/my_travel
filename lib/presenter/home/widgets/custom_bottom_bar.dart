import 'package:flutter/material.dart';

class CustomBottomBar extends StatelessWidget {
  final Function(int) onTap;
  final int currentIndex;

  const CustomBottomBar(
      {Key? key, required this.onTap, required this.currentIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BottomNavigationBar(
          onTap: onTap,
          currentIndex: currentIndex,
          showSelectedLabels: true,
          showUnselectedLabels: false,
          items: const [
            BottomNavigationBarItem(
              label: 'Home',
              icon: Icon(Icons.home_rounded),
            ),
            BottomNavigationBarItem(
              label: 'Progresso',
              icon: Icon(Icons.data_usage),
            ),
          ],
        ),
      ),
    );
  }
}
