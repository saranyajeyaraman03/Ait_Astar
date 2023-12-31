// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:aahstar/service/remote_service.dart';
import 'package:aahstar/values/constant_colors.dart';
import 'package:aahstar/views/auth/auth_helper.dart';
import 'package:aahstar/views/dashboard/dashboard_screen.dart';
import 'package:aahstar/views/home/entertainer_dashboard.dart';
import 'package:aahstar/views/profile/user_profile.dart';
import 'package:aahstar/widgets/custom_router.dart';
import 'package:aahstar/widgets/filled_button.dart';
import 'package:aahstar/widgets/snackbar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide FilledButton;
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  void initState() {
    super.initState();
    getUserType();
    _initializeData();
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController cashAppController = TextEditingController();
  TextEditingController contactController = TextEditingController();

  FocusNode nameFocusNode = FocusNode();
  FocusNode bioFocusNode = FocusNode();
  FocusNode countryFocusNode = FocusNode();
  FocusNode cityFocusNode = FocusNode();
  FocusNode addressFocusNode = FocusNode();
  FocusNode cashAppFocusNode = FocusNode();
  FocusNode contactFocusNode = FocusNode();

  UserProfile? userProfile;
  int? userID;
  late String imageUrl = "";
  late String userType = "";

  Future<void> _initializeData() async {
    AuthHelper authHelper = Provider.of<AuthHelper>(context, listen: false);

    userID = await authHelper.getUserID();

    if (userID != null) {
      await _fetchUserProfile(userID!);
    } else {
      print('UserID is null');
    }
  }

  Future<void> getUserType() async {
    AuthHelper authHelper = Provider.of<AuthHelper>(context, listen: false);
    List<dynamic>? retrievedUserList = await authHelper.getUserData();
    if (retrievedUserList != null && retrievedUserList.isNotEmpty) {
      Map<String, dynamic> userData = retrievedUserList[0];
      userType = userData['user_type'] ?? '';
      if (kDebugMode) {
        print('user_type: $userType');
      }
    }
  }

  Future<void> _fetchUserProfile(int userID) async {
    try {
      final response = await RemoteServices.fetchUserProfile(userID);
      if (response.statusCode == 200) {
        final jsonBody = response.body;
        if (kDebugMode) {
          print('saranya$jsonBody');
        }
        // ignore: unnecessary_null_comparison
        if (jsonBody != null) {
          setState(() {
            userProfile = UserProfile.fromJson(json.decode(jsonBody));
            nameController.text = userProfile?.name ?? "";
            bioController.text = userProfile?.bio ?? '';
            contactController.text = userProfile?.contact ?? '';
            countryController.text = userProfile?.country ?? '';
            cityController.text = userProfile?.city ?? '';
            addressController.text = userProfile?.address ?? '';
            imageUrl = userProfile?.profileUrl ?? '';
            String strDob = userProfile?.dob ?? "";
            AuthHelper authHelper =
                Provider.of<AuthHelper>(context, listen: false);
            authHelper.saveUserProfile(imageUrl, userProfile?.username ?? "");

            if (strDob.isNotEmpty) {
              DateTime dateTime = DateTime.parse(strDob);
              String formattedDate = DateFormat('MM-dd-yyyy').format(dateTime);
              dobController.text = formattedDate;
            }
          });
        }
      }
    } catch (error) {
      rethrow;
    }
  }

  // ignore: avoid_init_to_null
  late File? pickedImage = null;

  late PickedFile? image;

  DateTime? _selectedDate;

  Future<void> getImage({required ImageSource source}) async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: source);
    if (image != null) {
      setState(() {
        pickedImage = File(image.path);
      });
    }
  }

  Future<void> selectDate(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (selectedDate != null && selectedDate != _selectedDate) {
      setState(() {
        _selectedDate = selectedDate;
        dobController.text = DateFormat('MM-dd-yyyy').format(_selectedDate!);
      });
    }
  }

  Future<void> dialogBoxImagePicker(context) {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  ListTile(
                    leading: const Icon(Icons.camera_alt),
                    title: const Text("Pick Form Camera"),
                    onTap: () {
                      getImage(source: ImageSource.camera);
                      Navigator.of(context).pop();
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: const Text("Pick Form Gallery"),
                    onTap: () {
                      getImage(source: ImageSource.gallery);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          if (userType.toString().toLowerCase() == "fan") {
            Navigator.pushReplacement(
              context,
              CustomPageRoute(
                builder: (context) => const DashboardScreen(selectIndex: 0),
              ),
            );
          } else {
            Navigator.pushReplacement(
              context,
              CustomPageRoute(
                builder: (context) =>
                    const EntertainerDashboardScreen(selectIndex: 0),
              ),
            );
          }
          return false;
        },
        child: Scaffold(
          backgroundColor: ConstantColors.whiteColor,
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: ConstantColors.appBarColor,
            title: Text(
              "Edit Profile",
              style: GoogleFonts.nunito(
                fontWeight: FontWeight.w600,
                color: ConstantColors.whiteColor,
              ),
            ),
            leading: GestureDetector(
              onTap: () {
                if (userType.toString().toLowerCase() == "fan") {
                  Navigator.pushReplacement(
                    context,
                    CustomPageRoute(
                      builder: (context) =>
                          const DashboardScreen(selectIndex: 0),
                    ),
                  );
                } else {
                  Navigator.pushReplacement(
                    context,
                    CustomPageRoute(
                      builder: (context) =>
                          const EntertainerDashboardScreen(selectIndex: 0),
                    ),
                  );
                }
              },
              child: const Icon(
                Icons.arrow_back,
                color: ConstantColors.whiteColor,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      Container(
                        width: 130,
                        height: 130,
                        decoration: BoxDecoration(
                          color: ConstantColors.blueColor,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: pickedImage != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image.file(
                                  pickedImage!,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: imageUrl.isNotEmpty
                                    ? Image.network(
                                        imageUrl,
                                        fit: BoxFit.fill,
                                        width: double.infinity, 
                                        height: double .infinity,
                                      )
                                    : Image.asset('assets/profile.png'),
                              ),
                      ),
                      Positioned(
                        top: 90,
                        left: 100,
                        child: GestureDetector(
                            onTap: () {
                              dialogBoxImagePicker(context);
                            },
                            child: Container(
                              width: 35,
                              height: 35,
                              decoration: BoxDecoration(
                                color: ConstantColors.whiteColor,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.camera_alt,
                                  size: 20,
                                  color: ConstantColors.blueColor,
                                ),
                              ),
                            )),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  TextField(
                    controller: nameController,
                    focusNode: nameFocusNode,
                    onEditingComplete: () {
                      FocusScope.of(context).requestFocus(bioFocusNode);
                    },
                    style: GoogleFonts.nunito(
                      color: ConstantColors.black,
                    ),
                    keyboardType: TextInputType.emailAddress,
                    decoration: Provider.of<AuthHelper>(context, listen: false)
                        .textFieldDecoration(
                      placeholder: "Enter Name",
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: bioController,
                    focusNode: bioFocusNode,
                    onEditingComplete: () {
                      FocusScope.of(context).requestFocus(countryFocusNode);
                    },
                    style: GoogleFonts.nunito(
                      color: ConstantColors.black,
                    ),
                    keyboardType: TextInputType.multiline,
                    maxLines: 4,
                    decoration: Provider.of<AuthHelper>(context, listen: false)
                        .textFieldDecoration(
                      placeholder: "Enter Bio",
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: dobController,
                    readOnly: true,
                    onTap: () => selectDate(context),
                    style: GoogleFonts.nunito(
                      color: ConstantColors.black,
                    ),
                    decoration: Provider.of<AuthHelper>(context, listen: false)
                        .textFielWithIcondDecoration(
                      placeholder: "DOB",
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: countryController,
                    focusNode: countryFocusNode,
                    onEditingComplete: () {
                      FocusScope.of(context).requestFocus(cityFocusNode);
                    },
                    style: GoogleFonts.nunito(
                      color: ConstantColors.black,
                    ),
                    keyboardType: TextInputType.emailAddress,
                    decoration: Provider.of<AuthHelper>(context, listen: false)
                        .textFieldDecoration(
                      placeholder: "Enter Country",
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: cityController,
                    focusNode: cityFocusNode,
                    onEditingComplete: () {
                      FocusScope.of(context).requestFocus(addressFocusNode);
                    },
                    style: GoogleFonts.nunito(
                      color: ConstantColors.black,
                    ),
                    keyboardType: TextInputType.name,
                    decoration: Provider.of<AuthHelper>(context, listen: false)
                        .textFieldDecoration(
                      placeholder: "Enter City",
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: addressController,
                    focusNode: addressFocusNode,
                    onEditingComplete: () {
                      FocusScope.of(context).requestFocus(cashAppFocusNode);
                    },
                    style: GoogleFonts.nunito(
                      color: ConstantColors.black,
                    ),
                    keyboardType: TextInputType.multiline,
                    decoration: Provider.of<AuthHelper>(context, listen: false)
                        .textFieldDecoration(
                      placeholder: "State",
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: cashAppController,
                    focusNode: cashAppFocusNode,
                    onEditingComplete: () {
                      FocusScope.of(context).requestFocus(contactFocusNode);
                    },
                    style: GoogleFonts.nunito(
                      color: ConstantColors.black,
                    ),
                    keyboardType: TextInputType.emailAddress,
                    decoration: Provider.of<AuthHelper>(context, listen: false)
                        .textFieldDecoration(
                      placeholder: "Enter Your Cash App Name",
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: contactController,
                    focusNode: contactFocusNode,
                    onEditingComplete: () {
                      FocusScope.of(context).unfocus();
                    },
                    style: GoogleFonts.nunito(
                      color: ConstantColors.black,
                    ),
                    keyboardType: TextInputType.number,
                    decoration: Provider.of<AuthHelper>(context, listen: false)
                        .textFieldDecoration(
                      placeholder: "Enter Contact Number",
                    ),
                  ),
                  const SizedBox(height: 15),
                  FilledButton(
                    onTap: () async {
                      FocusScope.of(context).unfocus();

                      if (dobController.text.isNotEmpty) {
                        final inputDate = dobController.text;
                        final originalDate =
                            DateFormat("MM-dd-yy").parse(inputDate);
                        final formattedDate =
                            DateFormat("yyyy-MM-dd").format(originalDate);
                        dobController.text = formattedDate;

                        if (kDebugMode) {
                          print(dobController.text);
                        }
                      }

                      final response = await RemoteServices.updateProfile(
                        userID!,
                        nameController.text,
                        bioController.text,
                        countryController.text,
                        cityController.text,
                        addressController.text,
                        contactController.text,
                        dobController.text,
                        cashAppController.text,
                        pickedImage,
                      );
                      if (response.statusCode == 200) {
                        SnackbarHelper.showSnackBar(
                            context, "Profile updated successfully");

                        if (userType.toString().toLowerCase() == "fan") {
                          Navigator.pushReplacement(
                            context,
                            CustomPageRoute(
                              builder: (context) =>
                                  const DashboardScreen(selectIndex: 2),
                            ),
                          );
                        } else {
                          Navigator.pushReplacement(
                            context,
                            CustomPageRoute(
                              builder: (context) =>
                                  const EntertainerDashboardScreen(
                                      selectIndex: 1),
                            ),
                          );
                        }
                      }
                    },
                    text: "Update Profile",
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
