import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:nutra_nest/widgets/model_text_form_feild.dart';
import 'package:nutra_nest/widgets/small_text_buttom.dart';

class AddAddress extends StatefulWidget {
  const AddAddress({super.key});

  @override
  State<AddAddress> createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  final TextEditingController _emailIdCountroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 57,
              ),
              Row(
                children: [
                  Container(
                      height: 39,
                      width: 39,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10)),
                      child: const Icon(
                        Icons.arrow_back,
                        size: 26,
                        color: Colors.white,
                      )),
                  const SizedBox(
                    width: 92.5,
                  ),
                  const Expanded(
                    child: Text(
                      'New Address',
                      style:
                          TextStyle(fontSize: 19, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //-----------------------------------------------
                  const Text(
                    'Full Name:',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  SizedBox(
                      height: 42,
                      child:
                          modelTextFormFeild(countroller: _emailIdCountroller)),
                  const SizedBox(
                    height: 4,
                  ),
                  //--------------------------
                  //-----------------------------------------------
                  const Text(
                    'House Name:',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  SizedBox(
                      height: 42,
                      child:
                          modelTextFormFeild(countroller: _emailIdCountroller)),
                  const SizedBox(
                    height: 4,
                  ),
                  //--------------------------  //-----------------------------------------------
                  const Text(
                    'Street:',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  SizedBox(
                      height: 42,
                      child:
                          modelTextFormFeild(countroller: _emailIdCountroller)),
                  const SizedBox(
                    height: 4,
                  ),
                  //--------------------------  //-----------------------------------------------
                  const Text(
                    'City:',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  SizedBox(
                      height: 42,
                      child:
                          modelTextFormFeild(countroller: _emailIdCountroller)),
                  const SizedBox(
                    height: 4,
                  ),
                  //--------------------------  //-----------------------------------------------
                  const Text(
                    'Postal Code:',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  SizedBox(
                      height: 42,
                      child:
                          modelTextFormFeild(countroller: _emailIdCountroller)),
                  const SizedBox(
                    height: 4,
                  ),
                  //--------------------------  //-----------------------------------------------
                  const Text(
                    'Country:',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  SizedBox(
                      height: 42,
                      child:
                          modelTextFormFeild(countroller: _emailIdCountroller)),
                  const SizedBox(
                    height: 30,
                  ),
                  //--------------------------
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    SmallTextbutton(
                      buttomName: 'Cancel',
                      voidCallBack: () {},
                      buttomColor: Colors.white,
                      textColor: Colors.black,
                    ),
                    const SizedBox(
                      width: 18,
                    ),
                    SmallTextbutton(
                        buttomName: 'Save Address', voidCallBack: () {})
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
