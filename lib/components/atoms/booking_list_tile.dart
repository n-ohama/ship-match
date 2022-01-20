import 'package:flutter/material.dart';
import 'package:myapp/components/pages/booking_detail_screen.dart';

class BookingListTile extends StatelessWidget {
  const BookingListTile({
    Key? key, required this.id, required this.title, required this.userName,
  }) : super(key: key);
  final String id;
  final String title;
  final String userName;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: const EdgeInsets.all(8),
        width: double.infinity,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.account_circle_outlined, size: 48),
            const SizedBox(width: 4),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 17,
                        child: Text(
                          userName, style: const TextStyle(fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const Expanded(flex: 3, child: Text('9時間', style: TextStyle(color: Colors.grey))),
                    ],
                  ),
                  Text(title),
                ],
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => BookingDetailScreen(id)),
        );
      },
    );
  }
}
