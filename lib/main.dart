import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/components/pages/booking_detail_screen.dart';
import 'package:myapp/components/pages/booking_list_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.light(),
      home: BookingListScreen(),
      routes: {
        BookingListScreen.routeName: (_) => BookingListScreen(),
        BookingDetailScreen.routeName: (_) => BookingDetailScreen(),
      },
    );
  }
}

// TODO: ログイン画面を作る
// TODO: 新規投稿画面を作る(改行ありのタイトルを入力できるようにする)