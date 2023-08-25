import 'package:aahstar/router/route_constant.dart';
import 'package:aahstar/router/routers.dart';
import 'package:aahstar/values/branding_color.dart';
import 'package:aahstar/values/comman.dart';
import 'package:aahstar/views/auth/auth_helper.dart';
import 'package:aahstar/views/profile/profile_helper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AuthHelper authHelper = AuthHelper();
  await authHelper.loadLoggedInState();

  runApp(
    ChangeNotifierProvider.value(
      value: authHelper,
      child: const AahStar(),
    ),
  );
}

class AahStar extends StatelessWidget {
  const AahStar({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Common()),
        ChangeNotifierProvider(create: (_) => AuthHelper()),
        ChangeNotifierProvider(create: (_) => ProfileHelper()),
      ],
      child: MaterialApp(
        title: 'Aah Star',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: GoogleFonts.nunito(
            fontWeight: FontWeight.w500,
          ).fontFamily,
          primarySwatch: brandingColor,
        ),
        onGenerateRoute: Routers.onGenerateRoute,
        initialRoute: splashRoute,
      ),
    );
  }
}
