import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:nutra_nest/widgets/custom_textbutton.dart';

// class OtpVerificationScreen extends StatefulWidget {
//   const OtpVerificationScreen({super.key});

//   @override
//   State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
// }

// class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
//   TextEditingController _passwordController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           // crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               ' Verification',
//               style: TextStyle(
//                   color: Colors.black,
//                   fontSize: 27,
//                   fontWeight: FontWeight.bold),
//             ),
//             Text(
//               ' Enter the verification code wejust sent you on \n                                 your email id',
//               style: TextStyle(
//                 color: Colors.black,
//                 fontSize: 12,
//                 // fontWeight: FontWeight.bold
//               ),
//             ),
//             Row(
//               children: [
//                 Expanded(
//                   child: CustomTextFormField(
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter password';
//                       }
//                       if (value.length < 6) {
//                         return 'Password must be 6 or more numbers';
//                       }
//                       return null;
//                     },
//                     controller: _passwordController,
//                     labelText: ' Password  ',
//                     keyboardType: TextInputType.number,
//                   ),
//                 ),
//                 Expanded(
//                   child: CustomTextFormField(
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter password';
//                       }
//                       if (value.length < 6) {
//                         return 'Password must be 6 or more numbers';
//                       }
//                       return null;
//                     },
//                     controller: _passwordController,
//                     labelText: ' Password  ',
//                     keyboardType: TextInputType.number,
//                   ),
//                 ),
//                 Expanded(
//                   child: CustomTextFormField(
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter password';
//                       }
//                       if (value.length < 6) {
//                         return 'Password must be 6 or more numbers';
//                       }
//                       return null;
//                     },
//                     controller: _passwordController,
//                     labelText: ' Password  ',
//                     keyboardType: TextInputType.number,
//                   ),
//                 ),
//                 Expanded(
//                   child: CustomTextFormField(
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter password';
//                       }
//                       if (value.length < 6) {
//                         return 'Password must be 6 or more numbers';
//                       }
//                       return null;
//                     },
//                     controller: _passwordController,
//                     labelText: ' Password  ',
//                     keyboardType: TextInputType.number,
//                   ),
//                 ),
//                 Expanded(
//                   child: CustomTextFormField(
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter password';
//                       }
//                       if (value.length < 6) {
//                         return 'Password must be 6 or more numbers';
//                       }
//                       return null;
//                     },
//                     controller: _passwordController,
//                     labelText: ' Password  ',
//                     keyboardType: TextInputType.number,
//                   ),
//                 ),
//                 Expanded(
//                   child: Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 10),
//                     child: CustomTextFormField(
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter password';
//                         }
//                         if (value.length < 6) {
//                           return 'Password must be 6 or more numbers';
//                         }
//                         return null;
//                       },
//                       controller: _passwordController,
//                       labelText: ' Password  ',
//                       keyboardType: TextInputType.number,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  // Controllers and FocusNodes for each OTP field
  final List<TextEditingController> _otpControllers =
      List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());

  @override
  void dispose() {
    // Dispose all controllers and focus nodes
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  // Function to build individual OTP field
  Widget _buildOTPField(int index) {
    return Flexible(
      child: SizedBox(
        width: 49,
        child: TextFormField(
          controller: _otpControllers[index],
          focusNode: _focusNodes[index],
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          maxLength: 1,
          onChanged: (value) {
            if (value.isNotEmpty && index < _focusNodes.length - 1) {
              // Move to next field if input is not empty and within bounds
              FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
            } else if (value.isEmpty && index > 0) {
              // Move to previous field if input is deleted
              FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
            }
          },
          decoration: InputDecoration(
            counterText: "",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(width: 3.0, color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(
                color: Colors.black,
                width: 2,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(color: Colors.grey, width: 2),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Verification',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 27,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              'Enter the verification code we just sent you on your phone',
              style: TextStyle(
                color: Colors.black,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 69),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(6, (index) => _buildOTPField(index)),
              ),
            ),
            const SizedBox(height: 60),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: CustomTextbutton(
                color: Colors.black,
                buttomName: 'VIRIFY CODE',
                voidCallBack: () {
                  print('button pressed');
                  String opt = _otpControllers
                      .map((countroller) => countroller.text)
                      .join();
                  log(opt);
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Resend code ?',
              style: TextStyle(
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.black,
                  decorationThickness: 1.3,
                  color: Colors.black,
                  fontSize: 14),
            )

            // TextButton(
            //     onPressed: () {
            //       print('button pressed');
            //       String opt = _otpControllers
            //           .map((countroller) => countroller.text)
            //           .join();
            //       log(opt);
            //     },
            //     child: Text('press'))
          ],
        ),
      ),
    );
  }
}
