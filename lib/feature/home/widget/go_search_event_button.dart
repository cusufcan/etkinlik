import 'package:etkinlik/feature/event_search/event_search_view.dart';
import 'package:flutter/material.dart';

class GoSearchEventButton extends StatelessWidget {
  const GoSearchEventButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton.icon(
        icon: const Icon(Icons.search_outlined),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => const EventSearchView(),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        label: const Text('Etkinlik Ara'),
      ),
    );
  }
}
