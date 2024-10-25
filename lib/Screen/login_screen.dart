import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutra_nest/Blocs/LoginBloc/bloc/login_bloc.dart';
import 'package:nutra_nest/Widgets/custom_textbutton.dart';
import 'package:nutra_nest/Widgets/textformfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isPickerVisible = false;
  bool _isEmailVisibel = false;
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
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
                state.isPickerVisible
                    //  _isPickerVisible
                    ? _showCountryCodePicker(context)
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
                                padding: EdgeInsets.only(top: 15, bottom: 15),
                                child: Text(
                                  'Log In',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 32),
                                ),
                              ),
                              ///////1
                              CustomTextFormField(
                                controller: _phoneController,
                                labelText: state.isEmailVisible
                                    ? ' Email'
                                    : 'Phone Number',
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
                                                context.read<LoginBloc>().add(
                                                    ToggleEmailVisibility());
                                              },
                                              initialSelection: 'US',
                                              favorite: const ['+1', 'IN'],
                                              showFlag: false,
                                              showCountryOnly: false,
                                              showOnlyCountryWhenClosed: false,
                                              alignLeft: false,
                                              textStyle: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                              ),

                              Padding(
                                padding: EdgeInsets.only(
                                    top: deviceHeight * 0.01,
                                    bottom: deviceHeight * 0.01),
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
                                        context
                                            .read<LoginBloc>()
                                            .add(ToggleEmailVisibility());
                                      },
                                      child: Text(
                                        state.isEmailVisible
                                            ? 'Use Phone'
                                            : 'Use Email',
                                        style: const TextStyle(
                                            decoration:
                                                TextDecoration.underline,
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
                              CustomTextFormField(
                                controller: _passwordController,
                                labelText: ' Password  ',
                                keyboardType: TextInputType.number,
                              ),

                              Padding(
                                padding: EdgeInsets.only(
                                    top: deviceHeight * 0.01,
                                    bottom: deviceHeight * 0.01),
                                child: const Row(
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

                              CustomTextbutton(
                                  buttomName: 'LOG IN', voidCallBack: () {}),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: deviceHeight * 0.019,
                                    bottom: deviceHeight * 0.019),
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
                                padding: EdgeInsets.only(
                                    bottom: deviceHeight * 0.012),
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
            );
          },
        ),
      ),
    );
  }

  Widget _showCountryCodePicker(BuildContext context) {
    return CountryCodePicker(
      onChanged: (countryCode) {
        context
            .read<LoginBloc>()
            .add(UpdatePhoneNumber(countryCode.toString()));
        setState(() {});
      },
      initialSelection: 'US',
      favorite: const ['+1', 'IN'],
      showFlag: false,
      showCountryOnly: false,
      showOnlyCountryWhenClosed: false,
    );
  }
}
