import 'package:flutter/material.dart';
import 'package:nutra_nest/widgets/text_buttom.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController _nameCountroller = TextEditingController();

  final TextEditingController _mobileNumberCountroller =
      TextEditingController();
  final TextEditingController _emailIdCountroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
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
                      'Edit Profile',
                      style:
                          TextStyle(fontSize: 19, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Stack(children: [
                Container(
                  height: 135,
                  width: 135,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(width: 1.8),
                      borderRadius: BorderRadius.circular(5)),
                  child: Padding(
                    padding: const EdgeInsets.all(35.0),
                    child: Image.asset(
                      'assets/image copy 15.png',
                    ),
                  ),
                ),
                Positioned(
                    bottom: 8,
                    right: 10,
                    child: Container(
                        height: 22,
                        width: 22,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(5)),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 5, bottom: 6, left: 6, right: 5),
                          child: Image.asset('assets/image copy 16.png'),
                        )))
              ]),
              const SizedBox(
                height: 30,
              ),
              //-----------------
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //----------------------------
                  const Text(
                    'Full Name:',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  SizedBox(
                      height: 42,
                      child: _modelTextFormFeild(countroller: _nameCountroller)
                      //--------------------------
                      ),
                  const SizedBox(
                    height: 4,
                  ),
                  //-------------------------------
                  const Text('Mobile Number:'),
                  const SizedBox(
                    height: 4,
                  ),
                  SizedBox(
                      height: 42,
                      child: Stack(children: [
                        _modelTextFormFeild(
                            countroller: _mobileNumberCountroller),
                        Positioned(
                            top: 12,
                            bottom: 13,
                            right: 13,
                            child: SizedBox(
                                height: 18,
                                width: 58,
                                child: Container(
                                  padding: const EdgeInsets.only(left: 10),
                                  decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(3)),
                                  height: 30,
                                  width: 60,
                                  child: const Text(
                                    'Update',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w400),
                                  ),
                                )))
                      ])
                      //--------------------------
                      ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text('Email ID:'),
                  const SizedBox(
                    height: 4,
                  ),
                  SizedBox(
                      height: 42,
                      child: Stack(children: [
                        _modelTextFormFeild(
                            countroller: _mobileNumberCountroller),
                        Positioned(
                            top: 12,
                            bottom: 13,
                            right: 13,
                            child: SizedBox(
                                height: 18,
                                width: 58,
                                child: Container(
                                  padding: const EdgeInsets.only(left: 10),
                                  decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(3)),
                                  height: 30,
                                  width: 60,
                                  child: const Text(
                                    'Update',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w400),
                                  ),
                                )))
                      ])
                      //--------------------------
                      ),
                ],
              ),

              const SizedBox(
                height: 28,
              ),
              SizedBox(
                height: 43,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 95),
                  child: SmallTextbutton(
                    buttomName: 'SUBMIT',
                    voidCallBack: () {},
                  ),
                ),
              ),
              const SizedBox(
                height: 28,
              ),
              SizedBox(
                height: 43,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 95),
                  child: SmallTextbutton(
                    buttomColor: Colors.white,
                    textColor: Colors.black,
                    buttomName: 'Delete Account',
                    voidCallBack: () {},
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _modelTextFormFeild({required TextEditingController countroller}) {
    return TextFormField(
        controller: countroller,
        decoration: InputDecoration(
          fillColor: const Color.fromARGB(132, 158, 158, 158),
          filled: true,
          hintText: "Type here",
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 12),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(width: 2, color: Colors.black),

            // Remove border for clean look
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(),
          ),
        ));
  }
}
