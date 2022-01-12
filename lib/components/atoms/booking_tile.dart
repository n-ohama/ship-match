import 'package:flutter/material.dart';

class BookingTile extends StatelessWidget {
  const BookingTile({Key? key, required this.title, required this.subtitle}) : super(key: key);
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: const Icon(Icons.flight_land),
          title: Text(title),
          subtitle: Text(subtitle),
          onTap: () => {},
        ),
        const Divider(height: 1),
      ],
    );
  }
}
