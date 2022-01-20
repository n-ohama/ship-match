import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/model/booking.dart';
import 'package:myapp/provider/title_text_field_provider.dart';
import 'package:uuid/uuid.dart';

class BookingSecondTextFieldScreen extends ConsumerWidget {
  final Map<String, dynamic> args;
  const BookingSecondTextFieldScreen(this.args);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _provider = ref.watch(titleTextFieldProvider.notifier);
    final _title = ref.watch(titleTextFieldProvider);
    
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.blue),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              child: const Text('投稿する'),
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                shape: const StadiumBorder(),
              ),
              onPressed: _title.trim().isEmpty ? null : () {
                final uuid = const Uuid().v4();
                const owner = 'owner';
                final now = DateTime.now();
                final Booking booking = Booking(
                  id: uuid, title: _title, owner: owner,
                  leaveDateTime: args['leaveDateTime'], price: args['price'],
                  address: args['address'], requireNumber: args['requireNumber'],
                  capacity: args['capacity'], memberList: const [], ownerId: owner,
                  createdAt: now, updatedAt: now);
                FirebaseFirestore.instance.collection('ship_booking').doc(uuid).set(booking.toJson())
                  .then((value) {
                    Navigator.popUntil(context, (route) => route.isFirst);
                  })
                  .catchError((error) => print(error.toString()));
              },
            ),
          ),
        ],
        backgroundColor: Colors.white,
        elevation: .5,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: TextField(
          autofocus: true,
          keyboardType: TextInputType.multiline,
          maxLines: null,
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: '投稿のタイトル',
          ),
          onChanged: (text) => _provider.update((state) => state = text),
        ),
      ),
    );
  }
}
