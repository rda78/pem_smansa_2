import 'package:flutter/material.dart';
import 'package:pem_smansa_2/page/MainPage.dart';
import 'package:pem_smansa_2/util/Constant.dart';

class PEMApplication extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      theme: ThemeData(
        accentColor: Constant.primaryColor,
        primaryColor: Constant.primaryColor,
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        MainPage.tag: (context) => MainPage(),
      },
      initialRoute: MainPage.tag,
    );
  }
}