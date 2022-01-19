import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/components/pages/booking_first_text_fields_screen.dart';
import 'package:myapp/components/pages/booking_second_text_field_screen.dart';
import 'package:myapp/components/pages/booking_detail_screen.dart';
import 'package:myapp/components/pages/booking_list_screen.dart';
import 'package:myapp/components/pages/login_screen.dart';

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
      initialRoute: LoginScreen.routeName,
      routes: {
        LoginScreen.routeName: (_) => LoginScreen(),
        BookingListScreen.routeName: (_) => BookingListScreen(),
        BookingDetailScreen.routeName: (_) => BookingDetailScreen(),
        BookingFirstTextFieldsScreen.routeName: (_) => BookingFirstTextFieldsScreen(),
        BookingSecondTextFieldScreen.routeName: (_) => BookingSecondTextFieldScreen(),
      },
    );
  }
}

// TODO: ログイン画面を作る
// TODO: 新規投稿画面でleaveDayを