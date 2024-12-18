import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutra_nest/Blocs/SignUp/bloc/sign_up_bloc.dart';
import 'package:nutra_nest/Widgets/custom_textbutton.dart';
import 'package:nutra_nest/Widgets/textformfield.dart';
import 'package:nutra_nest/auth/auth_service.dart';

class SignScreen extends StatelessWidget {
  SignScreen({super.key});

  final _formKey = GlobalKey<FormState>();
//  AuthService authService = AuthService();
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
      body: BlocBuilder<SignUpBloc, SignUpState>(
        builder: (context, state) {
          final signUpBloc = context.read<SignUpBloc>();
          return SingleChildScrollView(
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
                Form(
                  //  autovalidateMode: AutovalidateMode.always,
                  key: _formKey,
                  child: Container(
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
                              style:
                                  TextStyle(color: Colors.white, fontSize: 32),
                            ),
                          ),
                          //1///////////////////////
                          Flexible(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: deviceHeight * 0.002),
                              child: CustomTextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter Name';
                                  }
                                  return null;
                                },
                                controller: _nameController,
                                onChanged: (name) =>
                                    signUpBloc.add(NameChanged(name)),
                                labelText: ' Name  ',
                                keyboardType: TextInputType.number,
                              ),
                            ),
                          ),
                          //2//////////////////
                          Flexible(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: deviceHeight * 0.002),
                              child: CustomTextFormField(
                                controller: _phoneController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter Phone';
                                  }
                                  return null;
                                },
                                labelText: 'Phone Number',
                                onChanged: (phone) =>
                                    signUpBloc.add(PhoneChanged(phone)),
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      CountryCodePicker(
                                        onChanged: (countryCode) {
                                          context
                                              .read<SignUpBloc>()
                                              .add(TogglePickerVisibility());
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
                            ),
                          ),
                          //3///////////////////
                          Flexible(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: deviceHeight * 0.002),
                              child: CustomTextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter Email';
                                  }
                                  return null;
                                },
                                controller: _emailController,
                                labelText: ' Email  ',
                                onChanged: (email) =>
                                    signUpBloc.add(EmailChanged(email)),
                                keyboardType: TextInputType.number,
                              ),
                            ),
                          ),
                          //4////////////////////////
                          Flexible(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: deviceHeight * 0.002),
                              child: CustomTextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter Password';
                                  }
                                  return null;
                                },
                                controller: _passwordController,
                                labelText: ' Password  ',
                                onChanged: (password) =>
                                    signUpBloc.add(PasswordChanged(password)),
                                keyboardType: TextInputType.number,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: deviceHeight * 0.002),
                            child: CustomTextbutton(
                                buttomName: 'SING UP',
                                voidCallBack: () {
                                  //  _submittion();
                                }),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: deviceHeight * 0.002),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: deviceHeight * 0.02),
                                  child: const Text(
                                    'Already having an account?   ',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 11),
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
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  void _submittion() {
    if (_formKey.currentState!.validate()) {
      // authService.createUserWithEmailAndPassword(
      //     email: _emailController.text, password: _passwordController.text);
    }
  }
}
