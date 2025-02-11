import 'package:flutter/material.dart';
import 'package:nutra_nest/core/theme/app_theme.dart';
import 'package:nutra_nest/features/address/data/models/address_model.dart';

import 'package:nutra_nest/utity/colors.dart';

// ignore: must_be_immutable
class AddresContainer extends StatelessWidget {
  final AddressModel addressModel;
  VoidCallback deleteAddress;
  VoidCallback setDefault;
  VoidCallback editAddress;

  AddresContainer(
      {super.key,
      required this.addressModel,
      required this.editAddress,
      required this.deleteAddress,
      required this.setDefault});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: isDark(context)
                      ? CustomColors.white
                      : CustomColors.lightWhite,
                  borderRadius: BorderRadius.circular(9)),
              padding: const EdgeInsets.all(10),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'House Name: ${addressModel.houseName}',
                        style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: customTextTheme(context)),
                      ),
                    ],
                  ),
                  Text(
                    'PostOffice: ${addressModel.postOffice}',
                    style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: customTextTheme(context)),
                  ),
                  Text(
                    'District: ${addressModel.district}',
                    style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: customTextTheme(context)),
                  ),
                  Text(
                    'State: ${addressModel.state}',
                    style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: customTextTheme(context)),
                  ),
                  Text(
                    'PinCode: ${addressModel.pinCode}',
                    style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: customTextTheme(context)),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 11,
              right: 11,
              child: GestureDetector(
                onTap: () => deleteAddress(),
                child: Container(
                  height: 22,
                  width: 22,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(5)),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 5, bottom: 6, left: 6, right: 5),
                    child: Image.asset('assets/image copy 17.png'),
                  ),
                ),
              ),
            ),
            Positioned(
              right: 11,
              top: 57,
              child: GestureDetector(
                onTap: () => setDefault(),
                child: Text(
                  addressModel.isPrimary
                      ? 'Default Address'
                      : 'make it default',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      color: addressModel.isPrimary
                          ? const Color.fromARGB(255, 47, 250, 54)
                          : customTextTheme(context)),
                ),
              ),
            ),
            Positioned(
              bottom: 11,
              right: 11,
              child: GestureDetector(
                onTap: () => editAddress(),
                child: Container(
                  padding: const EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(3)),
                  height: 19,
                  width: 70,
                  child: const Center(
                    child: Text(
                      'Edit  ',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
