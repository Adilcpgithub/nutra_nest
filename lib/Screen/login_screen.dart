import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
// No default country code
  bool _isPickerVisible = false;
  bool _isEmailVisibel = false;
  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.start, // Change to start for better layout
          children: [
            // This can also be in a Container to manage spacing better
            SizedBox(
              height: deviceHeight / 2,
              child: Center(
                child: Image.asset(
                  'assets/NutraNestPo.png',
                  height: 220,
                ),
              ),
            ),
            // The country code picker
            _isPickerVisible
                ? _showCountryCodePicker()
                : Container(
                    height: deviceHeight / 2,
                    width: deviceWidth > 400 ? 600 : deviceWidth,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 0, 0, 0),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 20, bottom: 20),
                            child: Text(
                              'Log In',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 32),
                            ),
                          ),
                          ///////1
                          TextFormField(
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.white, // The text inside the field
                            ),
                            controller: _phoneController,
                            decoration: InputDecoration(
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              prefixIcon: _isEmailVisibel
                                  ? null
                                  : Padding(
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
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
                                            favorite: ['+1', 'IN'],
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
                              labelText: _isEmailVisibel
                                  ? ' Abc11@gamil.com'
                                  : 'Phone Number',
                              labelStyle: const TextStyle(
                                fontSize: 18,
                                color: Color.fromARGB(255, 137, 137, 137),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(19),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 187, 206, 221)),
                                borderRadius: BorderRadius.circular(19),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                const Text(
                                  'or  ',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 13),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _isEmailVisibel = !_isEmailVisibel;
                                    });
                                  },
                                  child: Text(
                                    'Use Email     ',
                                    style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        decorationColor: Colors.white,
                                        decorationThickness: 2.0,
                                        color: Colors.white,
                                        fontSize: 13),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          //////2
                          TextFormField(
                            keyboardType: TextInputType.number,
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                            decoration: InputDecoration(
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                labelText: ' Password  ',
                                labelStyle: const TextStyle(
                                    fontSize: 18,
                                    color: Color.fromARGB(255, 137, 137, 137)),
                                border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: 5, color: Colors.white),
                                    borderRadius: BorderRadius.circular(19)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color:
                                            Color.fromARGB(255, 187, 206, 221)),
                                    borderRadius: BorderRadius.circular(19))),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 15, bottom: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  '      Forgot Password ? ',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 13),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 57, // Fixed height for button
                            child: TextButton(
                              style: TextButton.styleFrom(
                                minimumSize: const Size(double.infinity, 57),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(19)),
                                backgroundColor:
                                    const Color.fromARGB(255, 92, 90, 90),
                              ),
                              onPressed: () {},
                              child: const Text(
                                'LOG IN',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15, bottom: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Don’t have an account?  ',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 13),
                                ),
                                GestureDetector(
                                  child: const Text(
                                    'Sign Up',
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
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Login as',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12),
                                ),
                                GestureDetector(
                                  child: const Text(
                                    ' Guest',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  onTap: () {},
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget _showCountryCodePicker() {
    return CountryCodePicker(
      onChanged: (countryCode) {
        setState(() {});
      },
      initialSelection: 'US', // Default to US
      favorite: ['+1', 'IN'], // Favorite country codes
      showFlag: false,
      showCountryOnly: false,
      showOnlyCountryWhenClosed: false,
    );
  }
}
