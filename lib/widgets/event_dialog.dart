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

class EventDialog extends StatefulWidget {
  final String? userName;

  const EventDialog({super.key, this.userName});

  @override
  EventDialogState createState() => EventDialogState();
}

class EventDialogState extends State<EventDialog> {
  DateTime? _selectedDate;
  TextEditingController dateController = TextEditingController();

  TimeOfDay? _selectedTime;
  TextEditingController timeController = TextEditingController();
  TextEditingController eventNameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController buyTicketsLinkController = TextEditingController();

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
        dateController.text = DateFormat('dd-MM-yyyy').format(_selectedDate!);
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
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Event ',
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
                'Name',
                style: GoogleFonts.nunito(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            TextField(
              controller: eventNameController,
              style: GoogleFonts.nunito(
                color: ConstantColors.mainlyTextColor,
              ),
              keyboardType: TextInputType.multiline,
              decoration: Provider.of<AuthHelper>(context, listen: false)
                  .textFieldDecoration(
                placeholder: "Enter Event Title",
              ),
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
            const SizedBox(height: 16.0),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                textAlign: TextAlign.left,
                'Location and Address',
                style: GoogleFonts.nunito(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            TextField(
              controller: locationController,
              style: GoogleFonts.nunito(
                color: ConstantColors.mainlyTextColor,
              ),
              keyboardType: TextInputType.multiline,
              maxLines: 3,
              decoration: Provider.of<AuthHelper>(context, listen: false)
                  .textFieldDecoration(
                placeholder: "Enter Location and Address",
              ),
            ),
            const SizedBox(height: 16.0),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                textAlign: TextAlign.left,
                'Link to Buy Tickets',
                style: GoogleFonts.nunito(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            TextField(
              controller: buyTicketsLinkController,
              style: GoogleFonts.nunito(
                color: ConstantColors.mainlyTextColor,
              ),
              keyboardType: TextInputType.multiline,
              decoration: Provider.of<AuthHelper>(context, listen: false)
                  .textFieldDecoration(
                placeholder: "Enter Link to Buy Tickets",
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

                    if (eventNameController.text.isNotEmpty &&
                        dateController.text.isNotEmpty &&
                        timeController.text.isNotEmpty &&locationController.text.isNotEmpty&&
                        buyTicketsLinkController.text.isNotEmpty) {
                      try {
                        Response response =
                            await RemoteServices.submitEvent(widget.userName!,
                                eventNameController.text, dateController.text,
                                convertTo24HourFormat(timeController.text),
                                locationController.text,
                                buyTicketsLinkController.text);
                        print(response.body);

                        if (response.statusCode == 200) {
                          SnackbarHelper.showSnackBar(context,
                              "Event submitted successfully!");
                          Navigator.of(context).pop();
                        } else {
                          SnackbarHelper.showSnackBar(
                              context, "Failed to submit event");
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
