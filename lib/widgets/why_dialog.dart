// ignore_for_file: use_build_context_synchronously

import 'package:aahstar/service/remote_service.dart';
import 'package:aahstar/values/constant_colors.dart';
import 'package:aahstar/views/auth/auth_helper.dart';
import 'package:aahstar/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

class WhyDialog extends StatelessWidget {
  final String? userName;
  final String postId;

  const WhyDialog({super.key, this.userName, required this.postId});

  @override
  Widget build(BuildContext context) {
    TextEditingController descriptionController = TextEditingController();

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
              'Add Comment',
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
            TextField(
              controller: descriptionController,
              style: GoogleFonts.nunito(
                color: ConstantColors.mainlyTextColor,
              ),
              keyboardType: TextInputType.multiline,
              maxLines: 5,
              decoration: Provider.of<AuthHelper>(context, listen: false)
                  .textFieldDecoration(
                placeholder: "Why Love or Hate in 100 characters",
              ),
            ),
            const SizedBox(height: 20, width: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
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

                    if (descriptionController.text.isNotEmpty) {
                      try {
                        Response response = await RemoteServices.why(
                            userName!, postId, descriptionController.text);
                        print(response.body);
                        if (response.statusCode == 200) {
                          print('Comment Added Succefully');
                        } else {
                          print(
                              'API call failed with status code ${response.statusCode}');
                        }
                        Navigator.of(context).pop();
                      } catch (e) {
                        rethrow;
                      }
                    } else {
                      SnackbarHelper.showSnackBar(
                          context, "Please enter the message description.");
                    }
                  },
                  child: const Text('Submit'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
