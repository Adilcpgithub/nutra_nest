import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:nutra_nest/Widgets/custom_textbutton.dart';
import 'package:nutra_nest/core/theme/app_theme.dart';
import 'package:nutra_nest/features/cart/presentation/model/my_cart_model.dart';
import 'package:nutra_nest/features/home/presentation/pages/home_screen.dart';
import 'package:nutra_nest/page/bottom_navigation/bottom_navigation_screen.dart';
import 'package:nutra_nest/page/bottom_navigation/order/presentation/bloc/user_order_bloc/user_order_bloc.dart';
import 'package:nutra_nest/utity/colors.dart';
import 'package:nutra_nest/utity/navigation.dart';
import 'package:nutra_nest/widgets/icons_widget.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

const String razorpayApiKey = 'rzp_test_jIotm3SaZbXO9x';

class RazorpayScreen extends StatefulWidget {
  final List<MyCartModel> cartItems;
  final double shippingCost;
  final double totalAmount;
  final Map<String, dynamic> address;

  const RazorpayScreen(
      {super.key,
      required this.totalAmount,
      required this.cartItems,
      required this.shippingCost,
      required this.address});

  @override
  State<RazorpayScreen> createState() => _RazorpayScreenState();
}

class _RazorpayScreenState extends State<RazorpayScreen> {
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
    showPaymentSuccessDialog(context).then((_) {
      log('then called ');
      context.read<UserOrderBloc>().add(
            PlaceUserOrder(
              orderId: "ORDER_${DateTime.now().millisecondsSinceEpoch}",
              address: widget.address,
              products: widget.cartItems, // List<MyCartModel>
              totalPrice: widget.totalAmount,
            ),
          );
      CustomNavigation.pushAndRemoveUntil(
          context,
          const MyHomePage(
            setIndex: 3,
          ));
      log('then completed ');
    });
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
            horizontal:
                isMobile(context) ? 25 : MediaQuery.of(context).size.width / 4,
          ),
          child: Column(
            children: [
              const SizedBox(height: 10),
              _buildHeader(context),
              const SizedBox(height: 20),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildOrderItems(),
                      const SizedBox(height: 20),
                      _buildPriceSummary(),
                    ],
                  ),
                ),
              ),
              _buildPaymentButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        CustomIcon(
          onTap: () => Navigator.of(context).pop(),
          icon: Icons.arrow_back,
          iconSize: 26,
        ),
        Expanded(
          child: Text(
            'Payment Details',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: customTextTheme(context),
              fontSize: 19,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(width: 40), // For balance
      ],
    );
  }

  Widget _buildOrderItems() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Order Items',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: customTextTheme(context),
          ),
        ),
        const SizedBox(height: 15),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: widget.cartItems.length,
          itemBuilder: (context, index) {
            final item = widget.cartItems[index];
            return Card(
              margin: const EdgeInsets.only(bottom: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    // Product Image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        item.imageUrl,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          width: 60,
                          height: 60,
                          color: Colors.grey[200],
                          child: const Icon(Icons.error),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Product Details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.name,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: customTextTheme(context),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${item.productCount}x ₹${item.price}',
                            style: TextStyle(
                              fontSize: 13,
                              color: customTextTheme(context).withOpacity(0.7),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Price
                    Text(
                      '₹${item.subtotal.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: CustomColors.green,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildPriceSummary() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Price Details',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: customTextTheme(context),
            ),
          ),
          const SizedBox(height: 15),
          _buildPriceRow('Subtotal',
              '₹${(widget.totalAmount - widget.shippingCost).toStringAsFixed(2)}'),
          const SizedBox(height: 8),
          _buildPriceRow(
              'Shipping', '₹${widget.shippingCost.toStringAsFixed(2)}'),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Divider(),
          ),
          _buildPriceRow(
            'Total Amount',
            '₹${widget.totalAmount.toStringAsFixed(2)}',
            isTotal: true,
          ),
        ],
      ),
    );
  }

  Widget _buildPriceRow(String label, String amount, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 16 : 14,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: customTextTheme(context),
          ),
        ),
        Text(
          amount,
          style: TextStyle(
            fontSize: isTotal ? 18 : 15,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
            color: isTotal ? CustomColors.green : customTextTheme(context),
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: CustomTextbutton(
        color: CustomColors.green,
        nameColor: Colors.white,
        buttomName: 'PROCEED TO PAY',
        voidCallBack: () => makepayment(widget.totalAmount),
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

  showPaymentSuccessDialog(BuildContext context) {
    return showDialog(
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
