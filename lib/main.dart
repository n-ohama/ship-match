import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/components/pages/booking_first_text_fields_screen.dart';
import 'package:myapp/components/pages/booking_second_text_field_screen.dart';
import 'package:myapp/components/pages/booking_detail_screen.dart';
import 'package:myapp/components/pages/booking_list_screen.dart';
import 'package:myapp/components/pages/login_screen.dart';
import 'package:myapp/components/pages/sign_up_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLogin = false;

  @override
  void initState() {
    searchIsLogin();
    super.initState();
  }

  void searchIsLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final getIsLogin = prefs.getBool('isLogin');
    print(getIsLogin);
    setState(() {
      isLogin = getIsLogin ?? false;
    });
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.light(),
      initialRoute: isLogin ? BookingListScreen.routeName : '/signup',
      routes: {
        SignUpScreen.routeName: (_) => SignUpScreen(),
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