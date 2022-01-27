import 'package:flutter/material.dart';
import 'package:razorpay_integration_flutter_1/screens/test/pay/razorpay_test.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Material App',
      home: RazorPayTest(),
    );
  }
}
