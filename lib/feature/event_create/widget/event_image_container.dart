import 'dart:io';

import 'package:etkinlik/base/constant/app_num.dart';
import 'package:flutter/material.dart';

class EventImageContainer extends StatelessWidget {
  const EventImageContainer({
    super.key,
    this.selectedImage,
  });

  final File? selectedImage;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppNum.xSmall),
      ),
      height: 150,
      child: selectedImage != null
          ? Image.memory(
              selectedImage!.readAsBytesSync(),
              fit: BoxFit.cover,
            )
          : Image.asset(
              'assets/image/no_image.jpg',
              fit: BoxFit.cover,
            ),
    );
  }
}
