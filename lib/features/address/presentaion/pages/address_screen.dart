import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nutra_nest/core/theme/app_theme.dart';
import 'package:nutra_nest/features/address/data/models/address_model.dart';
import 'package:nutra_nest/features/address/presentaion/bloc/address_bloc/address_bloc.dart';
import 'package:nutra_nest/features/address/presentaion/pages/add__edit_address_screen.dart';
import 'package:nutra_nest/features/address/presentaion/widgets/addres_container.dart';
import 'package:nutra_nest/utity/colors.dart';
import 'package:nutra_nest/utity/navigation.dart';
import 'package:nutra_nest/utity/scaffol_message.dart';
import 'package:nutra_nest/widgets/icons_widget.dart';
import 'package:nutra_nest/widgets/small_text_buttom.dart';

// ignore: must_be_immutable
class ManageAddress extends StatefulWidget {
  bool? isFromCheckout;
  ManageAddress({super.key, this.isFromCheckout});

  @override
  State<ManageAddress> createState() => _ManageAddressState();
}

class _ManageAddressState extends State<ManageAddress> {
  @override
  void initState() {
    context.read<AddressBloc>().add(LoadAddresses());
    if (widget.isFromCheckout != null && widget.isFromCheckout == true) {
      Fluttertoast.showToast(
          msg: 'Choose your default address or add a new ',
          timeInSecForIosWeb: 3);
    }
    super.initState();
  }

  @override
  void didChangeDependencies() {
    context.read<AddressBloc>().add(LoadAddresses());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme(context),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: SizedBox(
            child: BlocListener<AddressBloc, AddressState>(
              listener: (context, state) {
                if (state is AddressDeletionSuccess && state.isNew) {
                  showUpdateNotification(
                      context: context,
                      message: 'Address deleted',
                      color: Colors.red,
                      milliseconds: 1000);
                }
              },
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CustomIcon(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            icon: Icons.arrow_back,
                            iconSize: 26),
                        const SizedBox(
                          width: 0,
                        ),
                        Expanded(
                          child: Text(
                            textAlign: TextAlign.center,
                            'Manage Address',
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
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        BlocBuilder<AddressBloc, AddressState>(
                          builder: (context, state) {
                            if (state is AddressLoaded &&
                                state.addresses.isNotEmpty) {
                              return Text(
                                'Saved Addresses',
                                style: TextStyle(
                                    color: customTextTheme(context),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w800),
                              );
                            } else {
                              return Text(
                                'No Address  ',
                                style: TextStyle(
                                    color: customTextTheme(context),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w800),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    BlocBuilder<AddressBloc, AddressState>(
                      builder: (context, state) {
                        if (state is AddressLoaded &&
                            state.addresses.isNotEmpty) {
                          return Flexible(
                            child: ListView.builder(
                                itemCount: state.addresses.length,
                                itemBuilder: (context, index) {
                                  final address = AddressModel.fromMap(
                                      state.addresses[index]);
                                  return AddresContainer(
                                    setDefault: () {
                                      context
                                          .read<AddressBloc>()
                                          .add(SelectAddress(address.id));
                                    },
                                    addressModel: address,
                                    editAddress: () {
                                      CustomNavigation.push(
                                          context,
                                          AddOrDeleteaddressScreen(
                                            isAddAddress: false,
                                            addressModel: AddressModel.fromMap(
                                                state.addresses[index]),
                                          ));
                                    },
                                    deleteAddress: () {
                                      showModelDeletingAddress(
                                          context, address.id);
                                    },
                                  );
                                }),
                          );
                        } else {
                          return SizedBox(
                            height: deviceHeight(context) / 2,
                            child: Center(
                              child:
                                  Image.asset('assets/Address is empty.webp'),
                            ),
                          );
                        }
                      },
                    ),
                  ]),
            ),
          ),
        ),
      ),
      bottomNavigationBar: BlocBuilder<AddressBloc, AddressState>(
        builder: (context, state) {
          if (state is AddressLoaded && state.addresses.length < 3) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: SizedBox(
                height: 40,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 95),
                  child: SmallTextbutton(
                    buttomColor: CustomColors.green,
                    buttomName: 'Add Address',
                    voidCallBack: () {
                      CustomNavigation.push(
                          context,
                          AddOrDeleteaddressScreen(
                            isAddAddress: true,
                          ));
                    },
                  ),
                ),
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}

void showModelDeletingAddress(BuildContext context, String addressId) async {
  showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: Container(
            width: deviceWidth(context) - deviceWidth(context) / 4,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              border: Border.all(width: 0.5, color: CustomColors.gray),
              color: Colors.black87,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 30),
                const Text(
                  'Address Deleting!',
                  style: TextStyle(
                    decorationThickness: 0,
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                const Flexible(
                  child: Text(
                    'Are you sure you want to delete this address?',
                    style: TextStyle(
                      decorationThickness: 0,
                      color: Colors.grey,
                      fontSize: 15,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: SmallTextbutton(
                          textColor: CustomColors.white,
                          buttomName: 'CANCEL',
                          fontweight: 16,
                          voidCallBack: () {
                            Navigator.of(context).pop(false);
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        child: SmallTextbutton(
                          textColor: CustomColors.white,
                          buttomName: 'Delete',
                          fontweight: 16,
                          voidCallBack: () async {
                            Navigator.of(context).pop(true);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }).then((result) {
    if (result == true) {
      // ignore: use_build_context_synchronously
      context.read<AddressBloc>().add(DeleteAddress(addressId));
    }
  });
}
