import 'package:aahstar/values/constant_colors.dart';
import 'package:aahstar/views/auth/auth_helper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MusicDialog extends StatelessWidget {
  const MusicDialog({super.key});

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
              'Upload Music Content',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
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
              style: GoogleFonts.nunito(
                color: ConstantColors.mainlyTextColor,
              ),
              keyboardType: TextInputType.multiline,
              decoration: Provider.of<AuthHelper>(context, listen: false)
                  .textFieldDecoration(
                placeholder: "Enter Tiltle",
              ),
            ),
            const SizedBox(height: 16.0),
            const Align(
              alignment: Alignment.topLeft,
              child: Text(
                textAlign: TextAlign.left,
                'Opinion',
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
              maxLines: 4,
              decoration: Provider.of<AuthHelper>(context, listen: false)
                  .textFieldDecoration(
                placeholder: "My Opinion",
              ),
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  textAlign: TextAlign.left,
                  'Music File',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.grey),
                  ),
                  child: const Text(
                    'Choose File',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
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
                  onPressed: () {
                    Navigator.of(context).pop();
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
