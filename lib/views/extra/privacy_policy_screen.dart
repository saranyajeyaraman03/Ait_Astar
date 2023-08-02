import 'package:aahstar/widgets/dotted_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Privacy Policy",
          style: GoogleFonts.poppins(),
        ),
        centerTitle: true,
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Privacy Policy',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            // Add sections of the Privacy Policy here...
            Text(
              'If you have additional questions or require more information about Cuptoopia.com, Inc. Aah Star after reading our Privacy Policy, contact us.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Aah Star Privacy Policy applies to our Web Application and Mobile Apps activities and is valid for visitors to our Web Application and Mobile Apps with regards to the information that they share and/or collect. This policy is not applicable to any information collected offline or via channels other than this Aah Star Web Application and Mobile Apps.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Consent',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'By using our Web Application and Mobile Apps, you hereby consent to our Privacy Policy and agree to its terms.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Information We Collect',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'The personal information that you are asked to provide, and the reasons why you are asked to provide it, are for the creation of a Aah Star Accounts and the purchase of Aah Star Subscription. Your data will never be sold to third party companies.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              'If you contact us directly, we may receive additional information about you such as your name, email address, phone number, the contents of the message and/or attachments you may send us, and any other information you may choose to provide.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              'When you register for a Aah Star Athlete, Entertainer or Fan User Account, we may ask for your contact information, including items such as name, company name, address, email address, and telephone number and pay out payment credentials to complete a subscription or to send you revenue generate through your Aah Star Account.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'How we use your information',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'We use the information we collect in various ways, including to:',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            BulletText(
                text:
                    "Provide, operate, and maintain our Web Application and Mobile Apps."),
            BulletText(
                text:
                    "Understand and analyze how you use our Web Application and Mobile Apps."),
            BulletText(
                text:
                    "Develop new products, services, features, and functionality for our Web Application and Mobile Apps."),
            BulletText(
                text:
                    "Communicate with you, either directly or through one of our Aah Star Account Owners, including for customer service, to provide you with updates and other information relating to the Web Application and Mobile Apps, and for marketing and promotional purposes."),
            BulletText(text: "Send you emails or text messages."),
            BulletText(text: "To detect and prevent fraud."),
            BulletText(text: "Log Files"),
            SizedBox(height: 8),
            Text(
              'Our Web Application and Mobile Apps follows a standard procedure of using log files. These files log visitors when they visit our Platform. All hosting companies do this and a part of hosting services analytics. The information collected by log files include internet protocol (IP) addresses, browser type, Internet Service Provider (ISP), date and time stamp, referring/exit pages, and possibly the number of clicks. These are not linked to any information that is personally identifiable. The purpose of the information is for analyzing trends, administering the site, tracking users movement on the Platform, and gathering demographic information.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Cookies and Web Beacons',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Like any other Platforms, Aah Star uses "cookies". These cookies are used to store information including visitors preferences, and the pages on the Platform that the visitor accessed or visited. The information is used to optimize the users experience by customizing our Platform content based on visitors browser type and/or other information.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'DoubleClick DART Cookie',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'Advertising Partners Privacy Policies',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Aah Star does not use advertising on our Web Application and Mobile Apps.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Third-Party Privacy Policies',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'You can choose to disable cookies through your individual browser options. To know more detailed information about cookie management with specific web browsers, it can be found at the browsers respective websites. What Are Cookies?',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'GDPR Privacy Policy (Data Protection Rights)',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'We would like to make sure you are fully aware of all of your data protection rights. Every user is entitled to the following:',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            BulletText(
                text:
                    r"The right to access to your data: You have the right to request copies of your personal data. We may charge you a $25 fee for this service."),
            BulletText(
                text:
                    "The right to rectification: You have the right to request that we correct any information you believe is inaccurate. You also have the right to request that we complete the information you believe is incomplete."),
            BulletText(
                text:
                    "The right to erasure: You have the right to request that we erase your personal data, under certain conditions."),
            BulletText(
                text:
                    "The right to restrict processing: You have the right to request that we restrict the processing of your personal data, under certain conditions."),
            BulletText(
                text:
                    "The right to object to processing: You have the right to object to our processing of your personal data, under certain conditions."),
            BulletText(
                text:
                    r"The right to data portability: You have the right to request that we transfer the data that we have collected to another organization, or directly to you, under certain conditions. We may charge you a $25 fee for this service."),
            SizedBox(height: 8),
            Text(
              'If you make a request, we have one month to respond to you. If you would like to exercise any of these rights, please contact us.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              "Children's Information",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              "Another part of our priority is adding protection for children while using the internet. We encourage parents and guardians to observe, participate in, and/or monitor and guide their online activity. We are not responsible or liable of products purchased by children without their parent or guardian's authorization or permission.",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              r"Our Web Application and Mobile Apps does not knowingly collect any Personal Identifiable Information from children under the age of 13. If you think that your child provided this kind of information on our Platforms, we strongly encourage you to contact us immediately and we will do our best efforts to promptly remove such information from our records. We may charge you a $25 fee for this service.",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),

            Text(
              "Questions",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              "If you have any questions about this Privacy Policy, please contact us at aahstar01@gmail.com. Cuptoopia.com, Inc. Aah Star Management",
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
