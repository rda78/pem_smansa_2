import 'package:flutter/material.dart';
import 'package:pem_smansa_2/screen/desktop/DesktopMainScreen.dart';
import 'package:pem_smansa_2/screen/mobile/MobileMainScreen.dart';
import 'package:pem_smansa_2/util/Utils.dart';
import 'package:responsive_builder/responsive_builder.dart';

class MainPage extends StatefulWidget {
  static var tag = 'main-page';

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MainState();
  }
}

class MainState extends State<MainPage> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Utils.init(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: ScreenTypeLayout(
        mobile: MobileMainScreen(),
        desktop: DesktopMainScreen(),
      ),
    );
  }
}