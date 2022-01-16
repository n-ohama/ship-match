import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/provider/detail_data_stream_provider.dart';

class BookingDetail extends ConsumerWidget {
  final String bookingId;
  const BookingDetail({Key? key, required this.bookingId}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const bigFontStyle = TextStyle(fontSize: 16);
    final booking = ref.watch(detailDataStreamProvider(bookingId));
    return booking.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => const Center(child: Text('Error')),
      data: (booking) {
        int requireNumber = booking.requireNumber - booking.memberList.length;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView(
            children: [
              Row(
                children: [
                  const Text('現在の参加数', style: bigFontStyle),
                  const SizedBox(width: 32),
                  Text('${booking.memberList.length}名', style: bigFontStyle,),
                  const SizedBox(width: 32),
                  Text('(定員${booking.capacity}名)', style: bigFontStyle),
                ],
              ),
              requireNumber > 0
                ? Text(
                '最低でもあと$requireNumber名参加すれば出港可能です。',
                style: bigFontStyle, // redBigFontStyle
              ) : const Text('出港可能！', style: bigFontStyle), // leaveOkStyle
              ElevatedButton(
                child: const Text('参加する', style: bigFontStyle),
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  primary: booking.memberList.contains(bookingId)
                      ? Colors.grey[300]
                      : Colors.red[300],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('料金 (1人あたり)', style: bigFontStyle),
                  Text('${booking.price}円', style: bigFontStyle),
                ],
              ),
              const Divider(height: 1),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('集合場所', style: bigFontStyle),
                  Text(booking.address, style: bigFontStyle),
                ],
              ),
              const Divider(height: 1),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('日付', style: bigFontStyle),
                  Text('${booking.leaveDateTime}', style: bigFontStyle),
                ],
              ),
            ],
          ),
        );
      }
    );
  }
}
