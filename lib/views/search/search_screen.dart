import 'dart:math';

import 'package:aahstar/router/route_constant.dart';
import 'package:aahstar/values/constant_colors.dart';
import 'package:aahstar/values/path.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstantColors.whiteColor,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(180),
          child: customAppBar(context)),
      body: GridView.extent(
        childAspectRatio: 0.8,
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
        padding: const EdgeInsets.all(10.0),
        maxCrossAxisExtent: 200.0,
        children: List.generate(4, (index) {
          return Container(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
            margin: const EdgeInsets.all(1.0),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey, // Set your desired border color here
                width: 1.0, // Set the border width
              ),
            ),
            child: Center(
              child: GridTile(
                  footer: Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    child: TextButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(ConstantColors.darkBlueColor),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                      onPressed: () {
                         Navigator.pushNamed(context, fanSubscriptionRoute);
                      },
                      child: const Text(
                        'View',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                  child:  Container(
                    child:  Column(
                      children: [
                        Image.asset(
                          Path.pngLogo,
                          width: 100,
                          height: 80,
                        ),
                        const SizedBox(height: 10,),
                        const Text(
                        'Saranya',
                        style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const Text(
                        '@saranya007',
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                      const Text(
                        'Entertainer',
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                      ],
                    ),
                  )),
            ),
          );
        }),
      ),
    );
  }
}

Widget customAppBar(BuildContext context) {
  return Stack(
    children: <Widget>[
      Container(
        // Background
        color: ConstantColors.appBarColor,
        height: MediaQuery.of(context).size.height * 0.2,
        width: MediaQuery.of(context).size.width,
        child: const Center(
          child: Text(
            "Search",
            style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.w600,
                color: Colors.white),
          ),
        ),
      ),
      Container(),
      Positioned(
        top: 100.0,
        left: 20.0,
        right: 20.0,
        child: AppBar(
          backgroundColor: Colors.white,
          primary: false,
          title: const TextField(
              decoration: InputDecoration(
                  hintText: "Search Athletes & Entertainer ",
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.grey))),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.search, color: ConstantColors.appBarColor),
              onPressed: () {},
            ),
          ],
        ),
      )
    ],
  );
}
