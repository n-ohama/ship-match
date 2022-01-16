import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/components/atoms/booking_tile.dart';
import 'package:myapp/provider/list_data_stream_provider.dart';

class BookingList extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookingList = ref.watch(listDataStreamProvider);
    return bookingList.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => Center(child: Text(error.toString())),
      data: (bookingList) {
        return ListView.separated(
          itemCount: bookingList.length,
          itemBuilder: (_, int index) {
            final booking = bookingList[index];
            return BookingTile(
              id: booking.id, title: booking.title, userName: booking.owner,
            );
          },
          separatorBuilder: (_, __) => const Divider(thickness: .5, height: 1),
        );
      }
    );
  }
}
