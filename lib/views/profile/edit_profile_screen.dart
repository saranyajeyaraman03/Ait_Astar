import 'dart:io';

import 'package:aahstar/values/constant_colors.dart';
import 'package:aahstar/views/auth/auth_helper.dart';
import 'package:aahstar/widgets/filled_button.dart';
import 'package:flutter/material.dart' hide FilledButton;
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final List<String> _genders = [
    'Male',
    'Female',
  ];

  String _genderValue = '';

late File? pickedImage = null;

  late PickedFile? image;
  @override
  void initState() {
    super.initState();
    setState(() {
      _genderValue = _genders[0];
    });
  }

  Future<void> getImage({required ImageSource source}) async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: source);
    if (image != null) {
      setState(() {
        pickedImage = File(image.path);
      });
    }
  }

  Future<void> dialogBoxImagePicker(context) {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
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
    return Scaffold(
      backgroundColor: ConstantColors.whiteColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Edit Profile",
          style: GoogleFonts.nunito(
            fontWeight: FontWeight.w600,
            color: ConstantColors.whiteColor,
          ),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
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
                    // Your Image.file widget goes here
                    child: pickedImage != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.file(
                              pickedImage!,
                              fit: BoxFit.cover,
                            ),
                          )
                        : const SizedBox(),
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
              const SizedBox(height: 50),
              TextField(
                // controller: name,
                style: GoogleFonts.nunito(
                  color: ConstantColors.mainlyTextColor,
                ),
                keyboardType: TextInputType.emailAddress,
                decoration: Provider.of<AuthHelper>(context, listen: false)
                    .textFieldDecoration(
                  placeholder: "Enter your username",
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                // controller: name,
                style: GoogleFonts.nunito(
                  color: ConstantColors.mainlyTextColor,
                ),
                keyboardType: TextInputType.emailAddress,
                decoration: Provider.of<AuthHelper>(context, listen: false)
                    .textFieldDecoration(
                  placeholder: "Enter your email",
                ),
              ),
              const SizedBox(height: 15),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: DropdownButton<String>(
                  underline: Container(),
                  style: GoogleFonts.nunito(
                    color: ConstantColors.mainlyTextColor,
                    fontSize: 14,
                  ),
                  borderRadius: BorderRadius.circular(10),
                  dropdownColor: ConstantColors.inputColor,
                  isExpanded: true,
                  value: _genderValue,
                  onChanged: (String? newValue) {
                    setState(() {
                      _genderValue = newValue!;
                    });
                  },
                  items: _genders.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 15),
              FilledButton(
                onTap: () {},
                text: "Update Profile",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
