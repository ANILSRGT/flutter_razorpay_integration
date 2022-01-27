import 'package:flutter/material.dart';
import 'package:razorpay_integration_flutter_1/services/razorpay/razorpay_service.dart';

class RazorPayTest extends StatefulWidget {
  const RazorPayTest({Key? key}) : super(key: key);

  @override
  _RazorPayTestState createState() => _RazorPayTestState();
}

class _RazorPayTestState extends State<RazorPayTest> {
  late RazorPayService _razorPayService;
  @override
  void initState() {
    super.initState();
    _razorPayService = RazorPayService.instance;
  }

  @override
  void dispose() {
    _razorPayService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () => _razorPayService.testPayWithPaymentLinks(),
          child: const Text("Pay"),
        ),
      ),
    );
  }
}
