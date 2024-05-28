import 'package:etkinlik/feature/event_create/event_create_view.dart';
import 'package:flutter/material.dart';

class GoCreateEventButton extends StatelessWidget {
  const GoCreateEventButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton.icon(
        icon: const Icon(Icons.add_outlined),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => const EventCreateView(),
          ));
        },
        label: const Text('Etkinlik Oluştur'),
      ),
    );
  }
}
