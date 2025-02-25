import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:nutra_nest/Widgets/custom_textbutton.dart';
import 'package:nutra_nest/core/theme/app_theme.dart';
import 'package:nutra_nest/features/home/presentation/pages/home_screen.dart';
import 'package:nutra_nest/utity/colors.dart';
import 'package:nutra_nest/widgets/icons_widget.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

const String razorpayApiKey = 'rzp_test_jIotm3SaZbXO9x';

class Sample extends StatefulWidget {
  final double totalAmount;
  const Sample({super.key, required this.totalAmount});

  @override
  State<Sample> createState() => _SampleState();
}

class _SampleState extends State<Sample> {
  void makepayment(double amount) {
    var options = {
      'key': razorpayApiKey,
      'amount': (amount * 100).toInt(), // Convert to paisa
      'name': 'Rider spot',
      'description': 'payment for order',
      'prefill': {
        'contact': '8590747471',
        'email': 'contact@protocoderspoint.com'
      },
      'external': {
        'wallets': ['paytm']
      }
    };
    try {
      _razorpay?.open(options);
    } catch (e) {
      log(e.toString());
    }
  }

  succsss(PaymentSuccessResponse response) {
    log('Payment Success: ${response.paymentId}');
    //   Fluttertoast.showToast(
    //       msg: 'Payment Success: ${response.paymentId}', timeInSecForIosWeb: 2);
    //   showUpdateNotification(
    //       context: context, message: 'success', color: Colors.green);
    showPaymentSuccessDialog(context);
  }

  void failed(PaymentFailureResponse response) {
    // Fluttertoast.showToast(
    //     msg: 'Payment Failed: ${response.message}', timeInSecForIosWeb: 2);
    log('Payment Failed: ${response.message}');
    showPaymentFailedDialog(context);
  }

  externalwallet(ExternalWalletResponse response) {
    log('External Wallet Used: ${response.walletName}');
    Fluttertoast.showToast(
        msg: 'External Wallet Used: ${response.walletName}',
        timeInSecForIosWeb: 2);
  }

  Razorpay? _razorpay;
  @override
  void initState() {
    _razorpay = Razorpay();
    _razorpay?.on(Razorpay.EVENT_PAYMENT_SUCCESS,
        (PaymentSuccessResponse response) => succsss(response));
    _razorpay?.on(Razorpay.EVENT_PAYMENT_ERROR,
        (PaymentFailureResponse response) => failed(response));
    _razorpay?.on(Razorpay.EVENT_EXTERNAL_WALLET,
        (ExternalWalletResponse response) => externalwallet(response));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme(context),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: isMobile(context)
                  ? 25
                  : MediaQuery.of(context).size.width / 4),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ), //! headLine
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomIcon(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icons.arrow_back,
                      iconSize: 26),
                  Expanded(
                    child: Text(
                      textAlign: TextAlign.center,
                      'Secure Payment',
                      style: TextStyle(
                          color: customTextTheme(context),
                          fontSize: 19,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
              //!   //

              //! remove this text this is for only testing purpose !!!!
              // GestureDetector(
              //   onTap: () {},
              //   child: const Text(
              //     'ssss',
              //     style: TextStyle(color: Colors.red, fontSize: 35),
              //   ),
              // ),
              //!  //
              const Expanded(child: SizedBox()),
              Padding(
                padding: const EdgeInsets.only(bottom: 40, left: 20, right: 20),
                child: CustomTextbutton(
                  color: CustomColors.green,
                  nameColor: Colors.white,
                  buttomName: 'PROCEED TO PAY',
                  voidCallBack: () {
                    makepayment(widget.totalAmount);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showPaymentFailedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Column(
            children: [
              SizedBox(
                height: 180,
                child: Lottie.asset(
                  height: 180,
                  'assets/payment_failed_lottie.json',
                ),
              ),
            ],
          ),
          actions: [
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context); // Navigate back or reset UI
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text('CLOSE', style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void showPaymentSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Column(
            children: [
              Lottie.asset(
                height: 100,
                'assets/payment_success_lotte.json',
              ),
              const SizedBox(height: 10),
              Text(
                'Payment Successful!',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: customTextTheme(context)),
              ),
            ],
          ),
          content: Text(
            'Your order has been placed successfully.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: customTextTheme(context)),
          ),
          actions: [
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context); // Navigate back or reset UI
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text('CLOSE', style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
