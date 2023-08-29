// ignore_for_file: use_build_context_synchronously

import 'package:aahstar/service/remote_service.dart';
import 'package:aahstar/values/constant_colors.dart';
import 'package:aahstar/views/auth/auth_helper.dart';
import 'package:aahstar/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

class YoutubeDialog extends StatelessWidget {
    final String? userName;

  const YoutubeDialog({super.key, this.userName});

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController linkController = TextEditingController();

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
              'Upload Youtube Content',
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
                'Title',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            TextField(
              controller: titleController,
              style: GoogleFonts.nunito(
                color: ConstantColors.mainlyTextColor,
              ),
              keyboardType: TextInputType.multiline,
              decoration: Provider.of<AuthHelper>(context, listen: false)
                  .textFieldDecoration(
                placeholder: "Enter Tiltle",
              ),
            ),
            // const SizedBox(height: 16.0),
            // const Align(
            //   alignment: Alignment.topLeft,
            //   child: Text(
            //     textAlign: TextAlign.left,
            //     'Opinion',
            //     style: TextStyle(
            //       fontWeight: FontWeight.bold,
            //       fontSize: 16.0,
            //     ),
            //   ),
            // ),
            // const SizedBox(height: 16.0),
            // TextField(
            //   style: GoogleFonts.nunito(
            //     color: ConstantColors.mainlyTextColor,
            //   ),
            //   keyboardType: TextInputType.multiline,
            //   maxLines: 4,
            //   decoration: Provider.of<AuthHelper>(context, listen: false)
            //       .textFieldDecoration(
            //     placeholder: "My Opinion",
            //   ),
            // ),
            const SizedBox(height: 16.0),
            const Align(
              alignment: Alignment.topLeft,
              child: Text(
                textAlign: TextAlign.left,
                'Youtube Embedded Code',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: linkController,
              style: GoogleFonts.nunito(
                color: ConstantColors.mainlyTextColor,
              ),
              keyboardType: TextInputType.multiline,
              decoration: Provider.of<AuthHelper>(context, listen: false)
                  .textFieldDecoration(
                placeholder: "Enter Youtube Embedded Code",
              ),
            ),
            const SizedBox(height: 20),
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

                    if (linkController.text.isNotEmpty) {
                      try {
                        Response response =
                            await RemoteServices.submitYoutube(
                                userName!, titleController.text,linkController.text);
                        print(response.body);

                        if (response.statusCode == 200) {
                          SnackbarHelper.showSnackBar(
                              context, "Youtube link submitted successfully!");
                          Navigator.of(context).pop();
                        } else {
                          SnackbarHelper.showSnackBar(
                              context, "Failed to submit youtube link");
                          Navigator.of(context).pop();
                        }
                      } catch (e) {
                        rethrow;
                      }
                    } else {
                      SnackbarHelper.showSnackBar(
                          context, "Please enter the youtube link.");
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
