import 'dart:io';

import 'package:aahstar/values/constant_colors.dart';
import 'package:aahstar/views/auth/auth_helper.dart';
import 'package:aahstar/widgets/filled_button.dart';
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
  // final List<String> _genders = [
  //   'Male',
  //   'Female',
  // ];

  //String _genderValue = '';

  // ignore: avoid_init_to_null
  late File? pickedImage = null;

  late PickedFile? image;

  DateTime? _selectedDate;
  TextEditingController dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    setState(() {
    //  _genderValue = _genders[0];
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
      dateController.text = DateFormat('dd-MM-yyyy').format(_selectedDate!);
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
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: const Image(
                                image: AssetImage('assets/profile.png'),
                              ))),
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
                style: GoogleFonts.nunito(
                  color: ConstantColors.mainlyTextColor,
                ),
                keyboardType: TextInputType.emailAddress,
                decoration: Provider.of<AuthHelper>(context, listen: false)
                    .textFieldDecoration(
                  placeholder: "Enter Name",
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                style: GoogleFonts.nunito(
                  color: ConstantColors.mainlyTextColor,
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
                controller: dateController,
                readOnly: true, 
                onTap: () => selectDate(context), 
                style: GoogleFonts.nunito(
                  color: ConstantColors.mainlyTextColor,
                ),
                decoration: Provider.of<AuthHelper>(context, listen: false)
                    .textFielWithIcondDecoration(
                  placeholder: "DOB",
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                style: GoogleFonts.nunito(
                  color: ConstantColors.mainlyTextColor,
                ),
                keyboardType: TextInputType.emailAddress,
                decoration: Provider.of<AuthHelper>(context, listen: false)
                    .textFieldDecoration(
                  placeholder: "Enter Country",
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                style: GoogleFonts.nunito(
                  color: ConstantColors.mainlyTextColor,
                ),
                keyboardType: TextInputType.emailAddress,
                decoration: Provider.of<AuthHelper>(context, listen: false)
                    .textFieldDecoration(
                  placeholder: "Enter City",
                ),
              ),
              const SizedBox(height: 15),

              TextField(
                style: GoogleFonts.nunito(
                  color: ConstantColors.mainlyTextColor,
                ),
                keyboardType: TextInputType.multiline,
                maxLines: 4,
                decoration: Provider.of<AuthHelper>(context, listen: false)
                    .textFieldDecoration(
                  placeholder: "Address",
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                style: GoogleFonts.nunito(
                  color: ConstantColors.mainlyTextColor,
                ),
                keyboardType: TextInputType.emailAddress,
                decoration: Provider.of<AuthHelper>(context, listen: false)
                    .textFieldDecoration(
                  placeholder: "Enter Your Cash App Name",
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                style: GoogleFonts.nunito(
                  color: ConstantColors.mainlyTextColor,
                ),
                keyboardType: TextInputType.emailAddress,
                decoration: Provider.of<AuthHelper>(context, listen: false)
                    .textFieldDecoration(
                  placeholder: "Enter Contact Number",
                ),
              ),
              // Container(
              //   padding: const EdgeInsets.symmetric(horizontal: 10),
              //   child: DropdownButton<String>(
              //     underline: Container(),
              //     style: GoogleFonts.nunito(
              //       color: ConstantColors.mainlyTextColor,
              //       fontSize: 14,
              //     ),
              //     borderRadius: BorderRadius.circular(10),
              //     dropdownColor: ConstantColors.inputColor,
              //     isExpanded: true,
              //     value: _genderValue,
              //     onChanged: (String? newValue) {
              //       setState(() {
              //         _genderValue = newValue!;
              //       });
              //     },
              //     items: _genders.map<DropdownMenuItem<String>>((String value) {
              //       return DropdownMenuItem<String>(
              //         value: value,
              //         child: Text(value),
              //       );
              //     }).toList(),
              //   ),
              // ),
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
