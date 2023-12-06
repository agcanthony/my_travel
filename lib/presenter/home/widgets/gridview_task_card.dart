import 'package:flutter/material.dart';
import 'package:my_travels/core/responsive.dart';

class GridviewTaskCard extends StatelessWidget {
  final List<Widget> children;
  const GridviewTaskCard({
    Key? key,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 5.0.wp,
      mainAxisSpacing: 5.0.wp,
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      children: children,
    );
  }
}
