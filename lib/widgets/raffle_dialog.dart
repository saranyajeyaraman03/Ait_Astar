// ignore_for_file: use_build_context_synchronously

import 'package:aahstar/service/remote_service.dart';
import 'package:aahstar/values/constant_colors.dart';
import 'package:aahstar/views/auth/auth_helper.dart';
import 'package:aahstar/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class RaffleDialog extends StatefulWidget {
  final String? userName;

  const RaffleDialog({super.key, this.userName});

  @override
  RaffleDialogState createState() => RaffleDialogState();
}

class RaffleDialogState extends State<RaffleDialog> {
  DateTime? _selectedDate;
  TextEditingController dateController = TextEditingController();

  TimeOfDay? _selectedTime;
  TextEditingController timeController = TextEditingController();
  TextEditingController linkController = TextEditingController();

  Future<void> selectDate(BuildContext context) async {
    DateTime currentDate = DateTime.now();
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: currentDate,
      lastDate: DateTime(2101),
    );

    if (selectedDate != null && selectedDate != _selectedDate) {
      setState(() {
        _selectedDate = selectedDate;
        dateController.text = DateFormat('yyyy-MM-dd').format(_selectedDate!);
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    TimeOfDay currentTime = TimeOfDay.now();
    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: currentTime,
    );

    if (selectedTime != null && selectedTime != _selectedTime) {
      setState(() {
        _selectedTime = selectedTime;
        timeController.text = _selectedTime!.format(context);
      });
    }
  }

  @override
  void dispose() {
    timeController.dispose();
    super.dispose();
  }

  String convertTo24HourFormat(String time) {
    final parsedTime = DateFormat('h:mm a').parse(time);

    final formattedTime = DateFormat('HH:mm').format(parsedTime);
    print(formattedTime);

    return formattedTime;
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
            Text(
              'Cash App Raffle Pricing Drawing Event ',
              style: GoogleFonts.nunito(
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
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                textAlign: TextAlign.left,
                'Select Date',
                style: GoogleFonts.nunito(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            TextField(
              controller: dateController,
              readOnly: true,
              onTap: () => selectDate(context),
              style: GoogleFonts.nunito(
                color: ConstantColors.mainlyTextColor,
              ),
              decoration: Provider.of<AuthHelper>(context, listen: false)
                  .textFielWithIcondDecoration(
                placeholder: "Select Date",
              ),
            ),
            const SizedBox(height: 16.0),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                textAlign: TextAlign.left,
                'Select Time',
                style: GoogleFonts.nunito(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            TextField(
              controller: timeController,
              readOnly: true,
              onTap: () => _selectTime(context),
              style: GoogleFonts.nunito(
                color: ConstantColors.mainlyTextColor,
              ),
              decoration: Provider.of<AuthHelper>(context, listen: false)
                  .textFieldTimeIcondDecoration(
                placeholder: "Select Time",
              ),
            ),
            const SizedBox(height: 10.0),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                textAlign: TextAlign.left,
                'Cash App Prize Amount',
                style: GoogleFonts.nunito(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            TextField(
              controller: linkController,
              style: GoogleFonts.nunito(
                color: ConstantColors.mainlyTextColor,
              ),
              keyboardType: TextInputType.multiline,
              decoration: Provider.of<AuthHelper>(context, listen: false)
                  .textFieldDecoration(
                placeholder: r"Enter Amount in $",
              ),
            ),
            const SizedBox(height: 16.0),
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

                    if (dateController.text.isNotEmpty &&
                        timeController.text.isNotEmpty &&
                        linkController.text.isNotEmpty) {
                      try {
                        Response response = await RemoteServices.submitRaffle(
                            widget.userName!,
                            dateController.text,
                            convertTo24HourFormat(timeController.text),
                            linkController.text);
                        print(response.body);

                        if (response.statusCode == 200) {
                          SnackbarHelper.showSnackBar(
                              context, "Raffle submitted successfully!");
                          Navigator.of(context).pop();
                        } else {
                          SnackbarHelper.showSnackBar(
                              context, "Failed to submit Raffle");
                          Navigator.of(context).pop();
                        }
                      } catch (e) {
                        rethrow;
                      }
                    } else {
                      SnackbarHelper.showSnackBar(
                          context, "Please enter the filed.");
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
