import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/components/pages/booking_list_screen.dart';
import 'package:myapp/model/booking.dart';
import 'package:myapp/model/booking_text_field.dart';
import 'package:myapp/provider/title_text_field_provider.dart';
import 'package:uuid/uuid.dart';

class BookingSecondTextFieldScreen extends ConsumerWidget {
  static const routeName = '/bookingSecondTextFieldScreen';
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _provider = ref.watch(titleTextFieldProvider.notifier);
    final _titleTextField = ref.watch(titleTextFieldProvider);
    
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.blue),
          onPressed: () => Navigator.popUntil(context, ModalRoute.withName(BookingListScreen.routeName)),
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
              onPressed: _titleTextField.isEmpty ? null : () {
                final uuid = const Uuid().v4();
                const owner = 'owner';
                final now = DateTime.now();
                final requireTextField = BookingFirstInputs.instance;
                final Booking booking = Booking(
                  id: uuid, title: _titleTextField, owner: owner,
                  leaveDateTime: requireTextField.leaveDay, price: requireTextField.price!,
                  address: requireTextField.address!, requireNumber: requireTextField.requireNumber!,
                  capacity: requireTextField.capacity!, memberList: const [], ownerId: owner,
                  createdAt: now, updatedAt: now);
                FirebaseFirestore.instance.collection('ship_booking').doc('flutterIsTheBest').set(booking.toJson())
                  .then((value) {
                    Navigator.pushReplacementNamed(context, BookingListScreen.routeName);
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
          style: const TextStyle(fontSize: 18),
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
