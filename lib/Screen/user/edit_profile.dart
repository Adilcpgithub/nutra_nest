import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nutra_nest/auth/auth_service.dart';
import 'package:nutra_nest/model/user_model.dart';
import 'package:nutra_nest/screen/bottom_navigation/account_screen.dart';
import 'package:nutra_nest/screen/bottom_navigation/bottom_navigation_screen.dart';
import 'package:nutra_nest/screen/user/delete_screen.dart';
import 'package:nutra_nest/widgets/model_text_form_feild.dart';
import 'package:nutra_nest/widgets/small_text_buttom.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  AuthService authService = AuthService();
  UserStatus userStatus = UserStatus();
  final TextEditingController _nameCountroller = TextEditingController();
  final TextEditingController _mobileNumberCountroller =
      TextEditingController();
  final TextEditingController _emailCountroller = TextEditingController();
  File? _selectedImage;
  Image? _defaulImage;
  String? imagePath;
  UserModel? userModel;

  @override
  void initState() {
    log('init state calling');
    _defaulImage = Image.asset('assets/image copy 15.png');
    _fetUserData();
    super.initState();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    final userId = await userStatus.getUserId();
    if (pickedFile != null) {
      // File imageFile = File(pickedFile.path);
      // String fileName = 'users/$userId/profile_image.jpg';
      try {
        log(1.toString());
        log(pickedFile.path);
        // final uploadTask =
        //     await FirebaseStorage.instance.ref(fileName).putFile(imageFile);
        // final downloadUrl = await uploadTask.ref.getDownloadURL();

        String datas = pickedFile.path;
        await _firestore.collection('users').doc(userId).update({
          'imageUrl': datas,
        });
        log(pickedFile.path);
        log(2.toString());
        setState(() {
          imagePath = pickedFile.path;
        });
        final data = await _firestore.collection('users').doc(userId).get();
        log(data.toString());

        //  print("Image uploaded successfully: $downloadUrl");
      } catch (e) {
        print("Failed to upload image: $e");
      }
    }
  }

  Future<void> _fetUserData() async {
    final snapshot =
        await authService.getUserData(await userStatus.getUserId());
    setState(() async {
      log(snapshot.toString());
      if (snapshot != null) {
        userModel = UserModel.fromMap(snapshot, await userStatus.getUserId());
      }
      log(snapshot.toString());

      _nameCountroller.text = userModel!.name;
      _emailCountroller.text = userModel!.email;
      _mobileNumberCountroller.text = userModel!.phoneNumber;
      if (userModel?.imageUrl != null) {
        imagePath = userModel!.imageUrl;
      }
    });
  }

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
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  const MyHomePage(
                            setIndex: 3,
                          ),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            var curvedAnimation = CurvedAnimation(
                              parent: animation,
                              curve: Curves.easeInOut, // Choose any curve here
                            );

                            return FadeTransition(
                              opacity: curvedAnimation,
                              child: child,
                            );
                          },
                        ),
                      );
                    },
                    child: Container(
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
                  ),
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
              Stack(
                children: [
                  Container(
                    height: 135,
                    width: 135,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(width: 1.8),
                        borderRadius: BorderRadius.circular(5)),
                    child: Padding(
                      padding: EdgeInsets.all(imagePath != null ? 0 : 35),
                      child: imagePath != null
                          ? Image.asset(imagePath!)
                          : Image.asset('assets/image copy 15.png'),
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
                        child: GestureDetector(
                            onTap: () async {
                              print('hkjhkjhkobject');
                              await _pickImage();
                              _fetUserData();
                            },
                            child: Image.asset('assets/image copy 16.png')),
                      ),
                    ),
                  )
                ],
              ),
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
                      child: modelTextFormFeild(countroller: _nameCountroller)
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
                        modelTextFormFeild(
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
                        modelTextFormFeild(countroller: _emailCountroller),
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
                            ),
                          ),
                        )
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
                    voidCallBack: () {
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  DeleteScreen(),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            var curvedAnimation = CurvedAnimation(
                              parent: animation,
                              curve: Curves.easeInOut, // Choose any curve here
                            );

                            return FadeTransition(
                              opacity: curvedAnimation,
                              child: child,
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
