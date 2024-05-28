import 'dart:io';

import 'package:etkinlik/base/constant/app_num.dart';
import 'package:etkinlik/base/widget/custom_card.dart';
import 'package:etkinlik/feature/event_create/widget/event_button.dart';
import 'package:etkinlik/feature/event_create/widget/event_image_container.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class EventImage extends StatefulWidget {
  const EventImage({
    super.key,
    required this.onImageSelected,
    required this.isLoading,
  });

  final void Function(File? image) onImageSelected;
  final bool isLoading;

  @override
  State<EventImage> createState() => _EventImageState();
}

class _EventImageState extends State<EventImage> {
  File? _selectedImage;

  void _selectImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (image == null) return;

    final CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: image.path,
      aspectRatio: const CropAspectRatio(ratioX: 5, ratioY: 3),
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: Colors.blueAccent,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: true,
        ),
      ],
    );

    if (croppedFile == null) return;

    setState(() {
      _selectedImage = File(croppedFile.path);
      widget.onImageSelected(_selectedImage);
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      padding: const EdgeInsets.symmetric(
        horizontal: AppNum.medium,
        vertical: AppNum.small,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          EventImageContainer(
            selectedImage: _selectedImage,
          ),
          const SizedBox(height: AppNum.small),
          EventButton(
            label: 'Resim Seç',
            onPressed: widget.isLoading ? null : _selectImage,
            icon: const Icon(Icons.image_outlined),
          ),
        ],
      ),
    );
  }
}
