import 'dart:developer';

import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RazorPayService {
  final String _razorKey = 'rzp_test_FXCAwwYAEncXcn';

  late Razorpay _razorpay;
  Razorpay get razorPay => _razorpay;

  static final RazorPayService _instance = RazorPayService._init();
  static RazorPayService get instance => _instance;

  RazorPayService._init() {
    _razorpay = Razorpay();

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void dispose() {
    _razorpay.clear();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(msg: "SUCCESS: " + response.paymentId!, toastLength: Toast.LENGTH_LONG);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "ERROR: " + response.code.toString() + " - " + response.message!, toastLength: Toast.LENGTH_LONG);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(msg: "EXTERNAL_WALLET: " + response.walletName!, toastLength: Toast.LENGTH_LONG);
  }

  Future<bool> payWithPaymentLinks(
      {required double amountCent,
      required String orderId,
      required String companyName,
      required String productDescription,
      required String customerPhone,
      required String customerEmail}) async {
    var options = {
      'key': _razorKey,
      'currency': 'USD',
      'amount': amountCent,
      'name': companyName,
      'order_id': orderId,
      'description': productDescription,
      'timeout': 60,
      'prefill': {
        'contact': customerPhone,
        'email': customerEmail,
      },
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      log("RazorPay Error: ", error: e);
      return false;
    }

    return true;
  }

  Future<bool> testPayWithPaymentLinks() async {
    var options = {
      'key': _razorKey,
      'currency': 'USD',
      'amount': 9999,
      'name': 'Acme Corp.',
      'order_id': 'order_EMBFqjDHEEn80l',
      'description': 'Dog T-Shirt',
      'timeout': 60,
      'prefill': {
        'contact': '8888888888',
        'email': 'test@razorpay.com',
      },
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      log("RazorPay Error: ", error: e);
      return false;
    }

    return true;
  }
}
