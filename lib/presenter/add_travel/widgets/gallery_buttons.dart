import 'package:flutter/material.dart';
import 'package:my_travels/core/app_colors.dart';
import 'package:my_travels/core/primary_text.dart';

class GalleryButtons extends StatelessWidget {
  final VoidCallback camera;
  final VoidCallback gallery;
  const GalleryButtons({
    Key? key,
    required this.camera,
    required this.gallery,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton.icon(
          onPressed: camera,
          icon: Icon(
            Icons.camera_alt_outlined,
            color: lilyWhite,
          ),
          label: PrimaryText('Camera'),
        ),
        ElevatedButton.icon(
          onPressed: gallery,
          icon: Icon(
            Icons.image_outlined,
            color: lilyWhite,
          ),
          label: PrimaryText('Galeria'),
        ),
      ],
    );
  }
}
