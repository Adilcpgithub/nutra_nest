import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:nutra_nest/Widgets/custom_textbutton.dart';
import 'package:nutra_nest/Widgets/textformfield.dart';

class SignScreen extends StatefulWidget {
  const SignScreen({super.key});

  @override
  State<SignScreen> createState() => _SignScreenState();
}

class _SignScreenState extends State<SignScreen> {
  bool _isPickerVisible = false;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: deviceHeight / 3,
              child: Center(
                child: Image.asset(
                  'assets/NutraNestPo.png',
                  height: 220,
                ),
              ),
            ),
            Container(
              height: deviceHeight * 2 / 3,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 0, 0, 0),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 45),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 20, bottom: 20),
                      child: Text(
                        'Sign Up',
                        style: TextStyle(color: Colors.white, fontSize: 32),
                      ),
                    ),
                    //1///////////////////////
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: deviceHeight * 0.002),
                      child: CustomTextFormField(
                        controller: _nameController,
                        labelText: ' Name  ',
                        keyboardType: TextInputType.number,
                      ),
                      //   TextFormField(
                      //     keyboardType: TextInputType.number,
                      //     style: const TextStyle(
                      //       fontSize: 18,
                      //       color: Colors.white,
                      //     ),
                      //     decoration: InputDecoration(
                      //         floatingLabelBehavior: FloatingLabelBehavior.never,
                      //         labelText: ' Name  ',
                      //         labelStyle: const TextStyle(
                      //             fontSize: 18,
                      //             color: Color.fromARGB(255, 137, 137, 137)),
                      //         border: OutlineInputBorder(
                      //             borderSide: const BorderSide(
                      //                 width: 5, color: Colors.white),
                      //             borderRadius: BorderRadius.circular(19)),
                      //         focusedBorder: OutlineInputBorder(
                      //             borderSide: const BorderSide(
                      //                 color: Color.fromARGB(255, 187, 206, 221)),
                      //             borderRadius: BorderRadius.circular(19))),
                      //   ),
                    ),
                    //2//////////////////
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: deviceHeight * 0.002),
                      child: CustomTextFormField(
                        controller: _phoneController,
                        labelText: 'Phone Number',
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CountryCodePicker(
                                onChanged: (countryCode) {
                                  setState(() {
                                    _isPickerVisible = false;
                                  });
                                },
                                initialSelection: 'US',
                                favorite: const ['+1', 'IN'],
                                showFlag: false,
                                showCountryOnly: false,
                                showOnlyCountryWhenClosed: false,
                                alignLeft: false,
                                textStyle: const TextStyle(
                                  color: Colors
                                      .white, // Change the color of the country code text
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                      ),
                    ),
                    //3///////////////////
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: deviceHeight * 0.002),
                      child: CustomTextFormField(
                        controller: _emailController,
                        labelText: ' Email  ',
                        keyboardType: TextInputType.number,
                      ),
                      // TextFormField(
                      //   keyboardType: TextInputType.number,
                      //   style: const TextStyle(
                      //     fontSize: 18,
                      //     color: Colors.white,
                      //   ),
                      //   decoration: InputDecoration(
                      //       floatingLabelBehavior: FloatingLabelBehavior.never,
                      //       labelText: ' Email  ',
                      //       labelStyle: const TextStyle(
                      //           fontSize: 18,
                      //           color: Color.fromARGB(255, 137, 137, 137)),
                      //       border: OutlineInputBorder(
                      //           borderSide: const BorderSide(
                      //               width: 5, color: Colors.white),
                      //           borderRadius: BorderRadius.circular(19)),
                      //       focusedBorder: OutlineInputBorder(
                      //           borderSide: const BorderSide(
                      //               color: Color.fromARGB(255, 187, 206, 221)),
                      //           borderRadius: BorderRadius.circular(19))),
                      // ),
                    ),
                    //4////////////////////////
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: deviceHeight * 0.002),
                      child: CustomTextFormField(
                        controller: _passwordController,
                        labelText: ' Password  ',
                        keyboardType: TextInputType.number,
                      ),
                      // TextFormField(
                      //   keyboardType: TextInputType.number,
                      //   style: const TextStyle(
                      //     fontSize: 18,
                      //     color: Colors.white,
                      //   ),
                      //   decoration: InputDecoration(
                      //       floatingLabelBehavior: FloatingLabelBehavior.never,
                      //       labelText: ' Password  ',
                      //       labelStyle: const TextStyle(
                      //           fontSize: 18,
                      //           color: Color.fromARGB(255, 137, 137, 137)),
                      //       border: OutlineInputBorder(
                      //           borderSide: const BorderSide(
                      //               width: 5, color: Colors.white),
                      //           borderRadius: BorderRadius.circular(19)),
                      //       focusedBorder: OutlineInputBorder(
                      //           borderSide: const BorderSide(
                      //               color: Color.fromARGB(255, 187, 206, 221)),
                      //           borderRadius: BorderRadius.circular(19))),
                      // ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: deviceHeight * 0.002),
                      child: CustomTextbutton(
                          buttomName: 'SING UP', voidCallBack: () {}),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: deviceHeight * 0.002),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: deviceHeight * 0.02),
                            child: const Text(
                              'Already having an account?   ',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 11),
                            ),
                          ),
                          GestureDetector(
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                            onTap: () {},
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(
                        top: 10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Text(
                                'By continuing, you agree to Perfect match’s',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w300),
                              ),
                              Text(
                                'Terms of Service, Privacy Policy',
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    decorationColor: Colors.white,
                                    decorationThickness: 1.5,
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
