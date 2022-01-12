import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/provider/detail_data_stream_provider.dart';

class BookingDetail extends ConsumerWidget {
  const BookingDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final booking = ref.watch(detailDataStreamProvider('id'));
    return booking.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => const Center(child: Text('Error')),
      data: (booking) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView(
            children: [
              Row(
                children: [
                  const Text('現在の参加数', style: TextStyle(fontSize: 16)),
                  const SizedBox(width: 32),
                  Consumer(
                      builder: (_, ref, __) {
                        final count = ref.watch(detailDataStreamProvider('id'));
                      }
                  ),
                  const SizedBox(width: 32),
                  Text('(定員${selectedBook.capacity}名)', style: bigFontStyle),
                ],
              ),
              Consumer<Books>(builder: (_, bookProvider, __) {
                int requireNumber = bookProvider.findById(args['id']).requireNumber -
                    bookProvider.findById(args['id']).memberList.length;
                return requireNumber > 0
                    ? Text(
                  '最低でもあと$requireNumber名参加すれば出港可能です。',
                  style: redBigFontStyle,
                )
                    : Text('出港可能！', style: leaveOkStyle);
              }),
              Consumer<Books>(builder: (_, bookProvider, __) {
                return ElevatedButton(
                  onPressed: bookProvider.findById(args['id']).ownerId == args['uid']
                      ? null
                      : () async {
                    if (args['isLogin']) {
                      if (bookProvider.findById(args['id']).memberList.contains(args['uid'])) {
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: Text('参加をキャンセルしますか？'),
                            actions: [
                              ElevatedButton(
                                child: Text('Yes'),
                                style: ElevatedButton.styleFrom(primary: Colors.blue),
                                onPressed: () {
                                  Provider.of<Books>(context, listen: false).cancelBook(
                                      bookProvider.findById(args['id']), args['uid']);
                                  Navigator.of(ctx).pop();
                                },
                              ),
                              ElevatedButton(
                                child: Text('No'),
                                style: ElevatedButton.styleFrom(primary: Colors.red[300]),
                                onPressed: () {
                                  Navigator.of(ctx).pop();
                                },
                              ),
                            ],
                          ),
                        );
                      } else {
                        await Provider.of<Books>(context, listen: false)
                            .joinBook(bookProvider.findById(args['id']), args['uid'], context);
                      }
                    } else {
                      showUpModal(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: bookProvider.findById(args['id']).memberList.contains(args['uid'])
                        ? Colors.grey[300]
                        : Colors.red[300],
                  ),
                  child: Text(
                    '参加する',
                    style: TextStyle(fontSize: 16),
                  ),
                );
              }),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('オーナー', style: bigFontStyle),
                  Text('${selectedBook.owner}', style: bigFontStyle),
                ],
              ),
              Divider(thickness: 1),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('料金(参加者で割り勘)', style: bigFontStyle),
                  Text('${selectedBook.price}円', style: bigFontStyle),
                ],
              ),
              Divider(thickness: 1),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('集合場所', style: bigFontStyle),
                  Text('${selectedBook.address}', style: bigFontStyle),
                ],
              ),
              Divider(thickness: 1),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('日付', style: bigFontStyle),
                  Text('${selectedBook.leaveDay}', style: bigFontStyle),
                ],
              ),
              Divider(thickness: 1),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('狙い', style: bigFontStyle),
                  Text('${selectedBook.target}', style: bigFontStyle),
                ],
              ),
              Divider(thickness: 1),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('釣具', style: bigFontStyle),
                  selectedBook.isRequiredTool
                      ? Text(
                    '持参です',
                    style: bigFontStyle,
                  )
                      : Text('貸し出せます', style: bigFontStyle),
                ],
              ),
              Divider(thickness: 1),
              if (selectedBook.note.isNotEmpty)
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('備考', style: bigFontStyle),
                      SizedBox(height: 16),
                      Text('${selectedBook.note}', style: bigFontStyle),
                      Divider(thickness: 1),
                    ],
                  ),
                ),
            ],
          ),
        );
      }
    );
  }
}
