import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TermsAndConditionsScreen extends StatefulWidget {
  const TermsAndConditionsScreen({Key? key}) : super(key: key);

  @override
  State<TermsAndConditionsScreen> createState() =>
      _TermsAndConditionsScreenState();
}

class _TermsAndConditionsScreenState extends State<TermsAndConditionsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Terms and Conditions",
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
              'Terms Of Service (TOS)',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'Conditions of Use',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Aah Star provides a Social Media Platform for Professional, Olympic and College Athletes, Star Entertainers and their Fans. Every time you visit this website, use its services or subscribe, you accept the following conditions. This is why we urge you to read them carefully.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Privacy Policy',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Before you continue using our website we advise you to read our privacy policy https://www.aahstar.com//privacy/ regarding our user data collection. It will help you better understand our practices.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Copyright Cuptoopia.com, Inc. Aah Star 2021',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Content published on this website (digital downloads, images, gifs, videos,texts, graphics, logos) are the property of Aah Star and/or its content creators and protected by international copyright laws. The entire compilation of the content found on this website is the exclusive property of Aah Star Content Creators, with copyright authorship for this compilation by Aah Star and its Aah Star Content Creators.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
             Text(
              'Communications',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'The entire communication with us is electronic. Every time you send us an email or visit our website, you are going to be communicating with us. You hereby consent to receive communications from us. If you subscribe to the news on our website, you are going to receive regular emails from us. We will continue to communicate with you by posting news and notices on our website and by sending you emails and text alerts. You also agree that all notices, disclosures, agreements and other communications we provide to you electronically meet the legal requirements that such communications be in writing.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
             Text(
              'Applicable Law',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'By visiting this website, you agree that the laws of Ohio and USA, without regard to principles of conflict laws, will govern these terms of service, or any dispute of any sort that might come between Aah Star and you, or its business partners and associates.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
             Text(
              'Disputes',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Any dispute related in any way to your visit to this website or to products you purchase from Aah Star shall be arbitrated by state or federal court Ohio USA and you consent to exclusive jurisdiction and venue of such courts.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            
             Text(
              'Comments, Reviews, and Emails',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Aah Star Customers may create exclusive content for their Fanscribers as long as it is not obscene, illegal, defamatory, threatening, infringing of intellectual property rights, invasive of privacy or injurious in any other way to third parties. FanScribers can UnSubscribe if they do not like the content of any Athlete or Entertainer. Content should be free of software viruses, hateful, vilgar or obsene materials. We reserve all rights to remove and/or edit such content.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
             Text(
              'License and Site Access',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'We grant you a limited license to access and make business use of this Web Application and Mobile Apps. You are not allowed to download or modify the Aah Star Web Application and Mobile Apps.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'User Account',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'If you are a Aah Star Customers with an account on this platform, you are solely responsible for maintaining the confidentiality of your private user details including your username, password and payment details. You are responsible for all activities that occur under your account or password. We reserve all rights to deactivate or terminate Aah Star Accounts, edit or remove content and cancel Subscriptions at the sole discretion of Aah Star.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            
            
          ],
        ),
      ),
    );
  }
}
