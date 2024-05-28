import 'package:flutter/material.dart';

class EventDetailImage extends StatelessWidget {
  const EventDetailImage({
    super.key,
    required this.id,
    required this.url,
  });

  final String id;
  final String url;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: FadeInImage(
        placeholder: const AssetImage(
          'assets/image/no_image.jpg',
        ),
        image: NetworkImage(url),
        fit: BoxFit.cover,
      ),
    );
  }
}
