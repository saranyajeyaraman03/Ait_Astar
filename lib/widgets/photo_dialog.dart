// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:aahstar/service/remote_service.dart';
import 'package:aahstar/values/constant_colors.dart';
import 'package:aahstar/views/auth/auth_helper.dart';
import 'package:aahstar/widgets/snackbar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart' as path;

class PhotoDialog extends StatefulWidget {
  final String? userName;

  const PhotoDialog({Key? key, this.userName}) : super(key: key);

  @override
  PhotoDialogState createState() => PhotoDialogState();
}

class PhotoDialogState extends State<PhotoDialog> {
  File? pickedFile;
  late String fileName = "";

  bool isLoading = false;

  Future<void> pickImage() async {
  final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);

  if (pickedImage != null) {
    setState(() {
      pickedFile = File(pickedImage.path);
      fileName = path.basename(pickedFile!.path);
    });
  } else {
    if (kDebugMode) {
      print('Image picking canceled.');
    }
  }
}

  @override
  Widget build(BuildContext context) {
    
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Upload Photo',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            const SizedBox(height: 5.0),
            const Divider(
              height: 20,
              thickness: 2,
              color: ConstantColors.appBarColor,
            ),
            const SizedBox(height: 16.0),
            const Align(
              alignment: Alignment.topLeft,
              child: Text(
                textAlign: TextAlign.left,
                'Caption',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            TextField(
              style: GoogleFonts.nunito(
                color: ConstantColors.mainlyTextColor,
              ),
              keyboardType: TextInputType.multiline,
              decoration: Provider.of<AuthHelper>(context, listen: false)
                  .textFieldDecoration(
                placeholder: "Caption to upload a photo",
              ),
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  textAlign: TextAlign.left,
                  'photo',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    pickImage();
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.grey),
                  ),
                  child: const Text(
                    'Choose File',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ],
            ),
            fileName.isNotEmpty
                ? Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      fileName,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        fontSize: 12.0,
                      ),
                    ),
                  )
                : const SizedBox(),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    Navigator.of(context).pop();
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.red),
                  ),
                  child: const Text('Cancel'),
                ),
                const SizedBox(width: 50),
                ElevatedButton(
                  onPressed: () async {
                    FocusManager.instance.primaryFocus?.unfocus();

                    setState(() {
                      isLoading = true;
                    });
                    try {
                      if (pickedFile != null) {
                        print('File name: $fileName');
                        final response = await RemoteServices.uploadPhoto(
                            userName: widget.userName!,
                            title: "",
                            videoFile: pickedFile!,
                            fileName: fileName);
                        print(response.body);
                        if (response.statusCode == 200) {
                          SnackbarHelper.showSnackBar(
                              context, "Photo uploaded Succefully.");
                          Navigator.of(context).pop();
                        } else {
                          SnackbarHelper.showSnackBar(
                              context, "('Failed to upload photo.");
                        }
                      } else {
                        SnackbarHelper.showSnackBar(
                            context, "Please select the file.");
                      }
                    } catch (e) {
                      rethrow;
                    } finally {
                      setState(() {
                        isLoading = false;
                      });
                    }
                  },
                  child: isLoading
                      ? const CircularProgressIndicator()
                      : const Text('Submit'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
