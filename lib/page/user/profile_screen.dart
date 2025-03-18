import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutra_nest/auth/auth_service.dart';
import 'package:nutra_nest/blocs/LoginBloc/bloc/profil_bloc/bloc/profil_bloc.dart';
import 'package:nutra_nest/core/theme/app_theme.dart';
import 'package:nutra_nest/model/user_model.dart';
import 'package:nutra_nest/page/bottom_navigation/bottom_navigation_screen.dart';
import 'package:nutra_nest/page/user/delete_screen.dart';
import 'package:nutra_nest/utity/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutra_nest/widgets/icons_widget.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  AuthService authService = AuthService();
  UserStatus userStatus = UserStatus();
  final TextEditingController _nameCountroller = TextEditingController();
  final TextEditingController _mobileNumberCountroller =
      TextEditingController();
  final TextEditingController _emailCountroller = TextEditingController();

  String? imagePath;
  UserModel? userModel;

  @override
  void initState() {
    log('init state calling');
    _fetUserData();
    context.read<ProfilBloc>().add(GetImageUrlEvent());

    super.initState();
  }

  Future<void> _fetUserData() async {
    await userStatus.getUserId();

    var data = await authService.getUserData();
    _nameCountroller.text = data?['name'] ?? '';
    _emailCountroller.text = data?['email'] ?? '';
    _mobileNumberCountroller.text = data?['phoneNumber'] ?? '';
    log(data.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme(context),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 10),
                _buildHeader(),
                const SizedBox(height: 40),
                _buildProfileImage(),
                const SizedBox(height: 30),
                _buildEditFields(),
                const SizedBox(height: 28),
                _buildActionButtons(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        CustomIcon(
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                    builder: (_) => const MyHomePage(setIndex: 3)),
              );
            },
            icon: Icons.arrow_back,
            iconSize: 26),
        const SizedBox(width: 92.5),
        Expanded(
          child: Text(
            'Profile',
            style: GoogleFonts.poppins(
              fontSize: 19,
              fontWeight: FontWeight.w600,
              color: customTextTheme(context),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProfileImage() {
    return Stack(
      children: [
        BlocBuilder<ProfilBloc, ProfilState>(
          builder: (context, state) {
            String imageUrl =
                'assets/default_profil_image.jpg'; // Default image
            bool isLoading = state is ProfileImageLoading;

            if (state is ProfilImageSuccessful) {
              imageUrl = state.imageUrl;
            }

            return Container(
              height: 160,
              width: 160,
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(20), // Make it a perfect circle
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(255, 179, 188, 183)
                        // ignore: deprecated_member_use
                        .withOpacity(0.3),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: CachedNetworkImage(
                      width: 160,
                      imageUrl: imageUrl,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        height: 160,
                        width: 160,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 3,
                            color: CustomColors.green,
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) => Image.asset(
                        'assets/default_profil_image.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  if (isLoading) // Blur effect when loading
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          // ignore: deprecated_member_use
                          color: Colors.white.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 3,
                            color: CustomColors.green,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            );
          },
        ),
        Positioned(
          bottom: 8,
          right: 10,
          child: GestureDetector(
            onTap: () {
              log('touched');
              BlocProvider.of<ProfilBloc>(context)
                  .add(const UploadImageEvent());
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color.fromARGB(201, 8, 208, 98),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    // ignore: deprecated_member_use
                    color: CustomColors.green.withOpacity(0.3),
                    blurRadius: 8,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: const Icon(
                Icons.camera_alt,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEditFields() {
    FocusNode focusName = FocusNode();
    FocusNode focusphoneNumber = FocusNode();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildEditFieldWithUpdate(
          focusNode: focusName,
          category: 'name',
          label: 'Full Name:',
          controller: _nameCountroller,
          onUpdate: () async {
            FocusScope.of(context).unfocus();
            await Future.delayed(
                const Duration(milliseconds: 300)); // Give some time to process
            SystemChannels.textInput
                .invokeMethod('TextInput.hide'); // Force keyboard to close

            log('on updated button pressed');
            await Future.delayed(const Duration(milliseconds: 1200));
            await authService.updateName(_nameCountroller.text.trim());
            if (context.mounted) {
              // ignore: use_build_context_synchronously
              Navigator.of(context).pop();
            }
          },
        ),
        const SizedBox(height: 20),
        _buildEditFieldWithUpdate(
          focusNode: focusphoneNumber,
          category: 'mobile number',
          keyboardType: TextInputType.phone,
          label: 'Mobile Number:',
          controller: _mobileNumberCountroller,
          onUpdate: () async {
            FocusScope.of(context).unfocus();
            await Future.delayed(
                const Duration(milliseconds: 300)); // Give some time to process
            SystemChannels.textInput
                .invokeMethod('TextInput.hide'); // Force keyboard to close

            log('on updated button pressed');
            await Future.delayed(const Duration(milliseconds: 1200));
            await authService
                .updatephoneNumber(_mobileNumberCountroller.text.trim());
            if (context.mounted) {
              // ignore: use_build_context_synchronously
              Navigator.of(context).pop();
            }
          },
        ),

        // _buildEditFieldReadOnly(
        //   label: 'Mobile Number:',
        //   controller: _mobileNumberCountroller,
        //   keyboardType: TextInputType.phone,
        // ),
        const SizedBox(height: 20),
        _buildEditFieldReadOnly(
          label: 'Email ID:',
          controller: _emailCountroller,
          keyboardType: TextInputType.emailAddress,
        ),
      ],
    );
  }

  Widget _buildEditFieldWithUpdate(
      {required String label,
      required TextEditingController controller,
      required String category,
      required VoidCallback onUpdate,
      TextInputType? keyboardType,
      FocusNode? focusNode}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: customTextTheme(context),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 50,
          decoration: BoxDecoration(
            color: appTheme(context),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              // ignore: deprecated_member_use
              color: CustomColors.green.withOpacity(0.3),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  focusNode: focusNode,
                  keyboardType: keyboardType,
                  controller: controller,
                  style: TextStyle(color: customTextTheme(context)),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16),
                    hintStyle:
                        TextStyle(color: Color.fromARGB(255, 148, 58, 58)),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  if (controller.text.isNotEmpty) {
                    // Show loading indicator
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return Center(
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.black87,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const CircularProgressIndicator(
                                  color: CustomColors.green,
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'Updating $category...',
                                  style: const TextStyle(
                                    decoration: TextDecoration.none,
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                    onUpdate();
                  }
                },
                child: Container(
                  margin: const EdgeInsets.all(6),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    // ignore: deprecated_member_use
                    color: CustomColors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'Update',
                    style: TextStyle(
                      color: CustomColors.green,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildEditFieldReadOnly({
    required String label,
    required TextEditingController controller,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: customTextTheme(context),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 50,
          decoration: BoxDecoration(
            color: appTheme(context),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              width: 2,
              // ignore: deprecated_member_use
              color: CustomColors.green.withOpacity(0.3),
            ),
          ),
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            style: TextStyle(color: customTextTheme(context)),
            readOnly: true,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              hintStyle: TextStyle(color: Colors.grey[600]),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        const SizedBox(height: 16),
        OutlinedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const DeleteScreen()),
            );
          },
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: CustomColors.green),
            minimumSize: const Size(double.infinity, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            'Delete Account',
            style: GoogleFonts.lato(
              color: CustomColors.green,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
