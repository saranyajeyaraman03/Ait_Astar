import 'dart:math' as math;
import 'dart:math';

// import 'package:aahstar/views/aahstar_live/live_page.dart';
// import 'package:zego_uikit/zego_uikit.dart';
import 'package:flutter/material.dart';

// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   ZegoUIKit().initLog().then((value) {
//     runApp(LivehomeScreen());
//   });
// }

class LivehomeScreen extends StatelessWidget {
  LivehomeScreen({Key? key}) : super(key: key);

  final liveTextCtrl =
      TextEditingController(text: Random().nextInt(10000).toString());

  final String localUserID = math.Random().nextInt(10000).toString();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('User ID:$localUserID'),
            const Text('Please test with two or more devices'),
            TextFormField(
              controller: liveTextCtrl,
              decoration: const InputDecoration(labelText: 'join a live by id'),
            ),
            const SizedBox(height: 20),
            // click me to navigate to LivePage
            // ElevatedButton(
            //   style: buttonStyle,
            //   child: const Text('Start a live'),
            //   onPressed: () => jumpToLivePage(
            //     context,
            //     liveID: liveTextCtrl.text.trim(),
            //     isHost: true,
            //   ),
            // ),
            // const SizedBox(height: 20),
            // // click me to navigate to LivePage
            // ElevatedButton(
            //   style: buttonStyle,
            //   child: const Text('Watch a live'),
            //   // onPressed: () => jumpToLivePage(
            //   //   context,
            //   //   liveID: liveTextCtrl.text.trim(),
            //   //   isHost: false,
            //   // ),
            // ),
          ],
        ),
      ),
    );
  }

  // void jumpToLivePage(BuildContext context,
  //     {required String liveID, required bool isHost}) {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => LivePage(liveID: liveID, isHost: isHost),
  //     ),
  //   );
  // }
}
