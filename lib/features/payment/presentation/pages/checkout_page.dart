import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nutra_nest/core/theme/app_theme.dart';
import 'package:nutra_nest/features/address/presentaion/pages/address_screen.dart';
import 'package:nutra_nest/features/cart/presentation/model/my_cart_model.dart';
import 'package:nutra_nest/features/payment/presentation/blocs/user_addres/user_address_bloc.dart';
import 'package:nutra_nest/page/razorpay_screen.dart';
import 'package:nutra_nest/utity/colors.dart';
import 'package:nutra_nest/utity/navigation.dart';
import 'package:nutra_nest/widgets/custom_textbutton.dart';
import 'package:nutra_nest/widgets/icons_widget.dart';

class CheckoutPage extends StatefulWidget {
  final List<MyCartModel> cartItems;
  final double shippingCost;
  final double totalAmount;

  const CheckoutPage(
      {super.key,
      required this.cartItems,
      required this.shippingCost,
      required this.totalAmount});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  @override
  void initState() {
    log('${widget.cartItems}');
    log('${widget.shippingCost}');
    log('${widget.totalAmount}');
    log('inti state called form  Checkout page called');
    context.read<UserAddressBloc>().add(const LoadUserAddresses());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme(context),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 10,
              ),
              //! headLine
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
                      'Checkout',
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
              //!
              const SizedBox(
                height: 30,
              ),
              //! ship to different Address section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    textAlign: TextAlign.center,
                    'Ship to a different address ?',
                    style: TextStyle(
                        color: customTextTheme(context),
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                  GestureDetector(
                    onTap: () {
                      CustomNavigation.push(
                          context,
                          ManageAddress(
                            isFromCheckout: true,
                          )).then((_) {
                        context
                            .read<UserAddressBloc>()
                            .add(const LoadUserAddresses());
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                              width: 1, color: customTextTheme(context))),
                      child: Text(
                        textAlign: TextAlign.center,
                        'Click here',
                        style: TextStyle(
                            color: customTextTheme(context),
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),
              //!
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    textAlign: TextAlign.center,
                    'Shipping  Address',
                    style: TextStyle(
                        color: customTextTheme(context),
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              BlocBuilder<UserAddressBloc, UserAddressState>(
                builder: (context, state) {
                  if (state is UserAddressLoading) {
                    return const SizedBox(
                        height: 360,
                        child: Center(
                            child: CircularProgressIndicator(
                          color: CustomColors.green,
                        )));
                  } else if (state is UserAddressLoaded) {
                    var address = state.selectedAddress;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildReadOnlyField(context, address['houseName'] ?? '',
                            'House / Building Name'),
                        const SizedBox(height: 20),
                        _buildReadOnlyField(context,
                            address['postOffice'] ?? '', 'Post Office'),
                        const SizedBox(height: 20),
                        _buildReadOnlyField(context, address['district'] ?? '',
                            'District / City'),
                        const SizedBox(height: 20),
                        _buildReadOnlyField(
                            context, address['state'] ?? '', 'State'),
                        const SizedBox(height: 20),
                        _buildReadOnlyField(context, address['pinCode'] ?? '',
                            'Pincode / ZIP Code'),
                      ],
                    );
                  }
                  return SizedBox(
                    height: 360,
                    width: 300,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            textAlign: TextAlign.center,
                            'Add Address ?',
                            style: TextStyle(
                                color: customTextTheme(context),
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          GestureDetector(
                            onTap: () {
                              CustomNavigation.push(
                                  context,
                                  ManageAddress(
                                    isFromCheckout: true,
                                  )).then((_) {
                                context
                                    .read<UserAddressBloc>()
                                    .add(const LoadUserAddresses());
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(
                                      width: 1,
                                      color: customTextTheme(context))),
                              child: Text(
                                textAlign: TextAlign.center,
                                'Click here',
                                style: TextStyle(
                                    color: customTextTheme(context),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const Expanded(child: SizedBox()),
              BlocBuilder<UserAddressBloc, UserAddressState>(
                builder: (context, state) {
                  bool haveAddress = false;
                  if (state is UserAddressLoaded) {
                    if (state.selectedAddress.isNotEmpty) {
                      haveAddress = true;
                    } else {
                      haveAddress = false;
                    }
                  }
                  return Padding(
                    padding:
                        const EdgeInsets.only(bottom: 40, left: 20, right: 20),
                    child: CustomTextbutton(
                      color: CustomColors.green,
                      nameColor: Colors.white,
                      buttomName: 'PROCEED TO CHECKOUT',
                      voidCallBack: () {
                        if (haveAddress) {
                          CustomNavigation.push(
                              context,
                              Sample(
                                totalAmount: widget.totalAmount,
                              ));
                        } else {
                          Fluttertoast.showToast(
                              msg: 'Please add address first',
                              timeInSecForIosWeb: 3);
                          log('no address address');
                        }
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildReadOnlyField(BuildContext context, String value, String label) {
  return TextFormField(
    initialValue: value,
    style: TextStyle(color: customTextTheme(context)),
    readOnly: true,
    decoration: InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: customTextTheme(context)),
      border: OutlineInputBorder(
          borderSide: BorderSide(width: 2, color: customTextTheme(context))),
    ),
  );
}
