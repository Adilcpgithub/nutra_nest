import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutra_nest/core/theme/app_theme.dart';
import 'package:nutra_nest/features/address/data/models/address_model.dart';
import 'package:nutra_nest/features/address/presentaion/bloc/address_bloc/address_bloc.dart';
import 'package:nutra_nest/features/address/presentaion/widgets/address_textform.dart';
import 'package:nutra_nest/utity/scaffol_message.dart';
import 'package:nutra_nest/widgets/icons_widget.dart';
import 'package:nutra_nest/widgets/small_text_buttom.dart';

// ignore: must_be_immutable
class AddOrDeleteaddressScreen extends StatefulWidget {
  final bool isAddAddress;
  AddressModel? addressModel;
  AddOrDeleteaddressScreen(
      {super.key, required this.isAddAddress, this.addressModel});

  @override
  State<AddOrDeleteaddressScreen> createState() => _AddaddressScreenState();
}

class _AddaddressScreenState extends State<AddOrDeleteaddressScreen> {
  // Add controllers
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _houseNameController = TextEditingController();
  final TextEditingController _postOfficeController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _pinCodeController = TextEditingController();
  @override
  void initState() {
    if (!widget.isAddAddress) {
      fetEditData();
    }
    super.initState();
  }

  fetEditData() {
    if (widget.addressModel != null) {
      _houseNameController.text = widget.addressModel!.houseName;
      _postOfficeController.text = widget.addressModel!.postOffice;
      _districtController.text = widget.addressModel!.district;
      _stateController.text = widget.addressModel!.state;
      _pinCodeController.text = widget.addressModel!.pinCode;
    }
  }

  @override
  void dispose() {
    // Dispose controllers
    _houseNameController.dispose();
    _postOfficeController.dispose();
    _districtController.dispose();
    _stateController.dispose();
    _pinCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme(context),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: SingleChildScrollView(
              child: SizedBox(
                height: deviceHeight(context),
                child: Form(
                  key: _formKey,
                  child: BlocListener<AddressBloc, AddressState>(
                    listener: (context, state) async {
                      if (state is AddAddressSuccess && state.isNew) {
                        Future.delayed(const Duration(milliseconds: 500), () {
                          showUpdateNotification(
                              // ignore: use_build_context_synchronously
                              context: context,
                              message: 'New address added',
                              milliseconds: 1200);
                        }).then((_) {
                          // ignore: use_build_context_synchronously
                          Navigator.of(context).pop();
                        });
                      }
                      if (state is UpdatedAddressSuccess && state.isNew) {
                        Future.delayed(const Duration(milliseconds: 500), () {
                          showUpdateNotification(
                              // ignore: use_build_context_synchronously
                              context: context,
                              message: 'Address updated',
                              milliseconds: 1200);
                        }).then((_) {
                          // ignore: use_build_context_synchronously
                          Navigator.of(context).pop();
                        });
                      }
                      if (state is AddressError) {
                        Future.delayed(const Duration(milliseconds: 500), () {
                          showUpdateNotification(
                              // ignore: use_build_context_synchronously
                              context: context,
                              message: state.message,
                              color: Colors.red,
                              milliseconds: 1200);
                        }).then((_) {
                          // ignore: use_build_context_synchronously
                          Navigator.of(context).pop();
                        });
                      }
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
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
                                widget.isAddAddress
                                    ? 'New Address'
                                    : 'Edit Address',
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
                          height: 40,
                        ),
                        AddressTextform(
                          controller: _houseNameController,
                          headline: 'House Name',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'House name cannot be empty';
                            }
                            if (value.length < 3) {
                              return 'Must be at least 3 characters long';
                            }
                            return null;
                          },
                        ),
                        AddressTextform(
                          controller: _postOfficeController,
                          headline: 'Post Office',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Post office cannot be empty';
                            }
                            if (value.length < 3) {
                              return 'Must be at least 3 characters long';
                            }
                            return null;
                          },
                        ),
                        AddressTextform(
                          controller: _districtController,
                          headline: 'District',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'District cannot be empty';
                            }
                            if (value.length < 3) {
                              return 'Must be at least 3 characters long';
                            }
                            return null;
                          },
                        ),
                        AddressTextform(
                          controller: _stateController,
                          headline: 'State',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'State cannot be empty';
                            }
                            if (value.length < 3) {
                              return 'Must be at least 3 characters long';
                            }
                            return null;
                          },
                        ),
                        AddressTextform(
                          controller: _pinCodeController,
                          headline: 'Pin Code',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Pin code cannot be empty';
                            }
                            if (value.length != 6) {
                              return 'Pin code must be 6 digits';
                            }
                            if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                              return 'Pin code must contain only numbers';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: SmallTextbutton(
                                  textColor: customTextTheme(context),
                                  width: 1.5,
                                  buttomColor: appTheme(context),
                                  buttomName: 'CANCEL',
                                  voidCallBack: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Flexible(
                                child: BlocBuilder<AddressBloc, AddressState>(
                                  builder: (context, state) {
                                    bool showLoading;
                                    if (state is AddressLoading) {
                                      showLoading = true;
                                    } else {
                                      showLoading = false;
                                    }
                                    return SmallTextbutton(
                                      showcircleavatar: showLoading,
                                      width: 1.5,
                                      buttomColor: appTheme(context),
                                      buttomName: widget.isAddAddress
                                          ? 'Save Address'
                                          : 'Update Address',
                                      textColor: customTextTheme(context),
                                      voidCallBack: () async {
                                        if (_formKey.currentState?.validate() ??
                                            false) {
                                          String addressId = '';
                                          if (!widget.isAddAddress) {
                                            addressId =
                                                widget.addressModel?.id ?? '';
                                          }
                                          final addressModel = AddressModel(
                                            id: addressId, // This will be set by your backend
                                            houseName: _houseNameController.text
                                                .trim(),
                                            postOffice: _postOfficeController
                                                .text
                                                .trim(),
                                            district:
                                                _districtController.text.trim(),
                                            state: _stateController.text.trim(),
                                            pinCode:
                                                _pinCodeController.text.trim(),
                                          );
                                          if (widget.isAddAddress) {
                                            log('editing fuction called');
                                            context.read<AddressBloc>().add(
                                                AddAddress(
                                                    addressModel.toMap()));
                                          } else {
                                            log('editing fuction called');
                                            context.read<AddressBloc>().add(
                                                EditAddress(
                                                    addressId, addressModel));
                                          }
                                        }
                                      },
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
