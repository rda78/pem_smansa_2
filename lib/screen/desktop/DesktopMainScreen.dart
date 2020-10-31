import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pem_smansa_2/util/Constant.dart';
import 'package:pem_smansa_2/util/Utils.dart';
import 'package:responsive_builder/responsive_builder.dart';

class DesktopMainScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DesktopMainState();
  }
}

class DesktopMainState extends State<DesktopMainScreen> with TickerProviderStateMixin {
  var _isLandscape = true;

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    });
    super.initState();
  }

  void bindListUniversities() {
    print(getSize(_globalKeyListTileUniversities));
  }

  getSize(GlobalKey _key) {
    RenderBox renderBox = _key.currentContext.findRenderObject();
    return renderBox.size;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Utils.init(context);
    initBuild();

    return OrientationBuilder(
      builder: (context, orientation) {
        _isLandscape = orientation == Orientation.landscape;
        return screen();
      },
    );
  }

  ScrollController _scrollController;
  AnimationController _animationControllerAppBarBackground;
  Animation _animationAppBarBackground, _animationAppBarTextColor;
  var _isTransparentAppBar = true;

  GlobalKey _globalKeyListTileUniversities;

  ValueNotifier<double> _valueNotifierListTileHeight;
  void initBuild() {
    _globalKeyListTileUniversities ??= GlobalKey();

    _valueNotifierListTileHeight ??= ValueNotifier(0);

    _animationControllerAppBarBackground ??= AnimationController(
      duration: Duration(
        milliseconds: 250,
      ),
      vsync: this,
    );

    _animationAppBarBackground ??= ColorTween(
      begin: Colors.transparent, end: Colors.white,
    ).animate(_animationControllerAppBarBackground);
    _animationAppBarTextColor ??= ColorTween(
      end: Colors.grey.shade900, begin: Colors.white,
    ).animate(_animationControllerAppBarBackground);

    _scrollController ??= ScrollController()
        ..addListener(() {
          var _pixels = _scrollController.position.pixels;
          if (_pixels == 0 && !_isTransparentAppBar) {
            _animationControllerAppBarBackground.reverse();
            _isTransparentAppBar = true;
          } else if (_pixels > 0 && _isTransparentAppBar) {
            _animationControllerAppBarBackground.forward();
            _isTransparentAppBar = false;
          }
        });
  }

  Widget screen() {
    return Stack(
      children: [
        body(),
        appBar(),
      ],
    );
  }

  Widget body() {
    return SingleChildScrollView(
      controller: _scrollController,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          welcomeScreen(),
          poweredScreen(),
          greetingScreen(),
          aboutPEM2(),
          universities(),
          searchUniversity(),
          footer(),
        ],
      ),
    );
  }

  Widget appBar() {
    return AnimatedBuilder(
      animation: _animationAppBarBackground,
      builder: (context, child) {
        return Container(
          color: _animationAppBarBackground.value,
          width: Utils.width(100),
          height: Utils.height(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(
                  left: Utils.width(2),
                  right: Utils.width(2),
                ),
                height: Utils.height(8),
                child: AnimatedBuilder(
                  animation: _animationAppBarTextColor,
                  builder: (context, child) => Text('71',
                    style: GoogleFonts.eczar(
                      fontWeight: FontWeight.bold,
                      fontSize: Utils.textTheme().headline4.fontSize,
                      color: _animationAppBarTextColor.value,
                    ),
                  ),
                ),
              ),
              AnimatedBuilder(
                builder: (context, child) => Text('PEM\nSmansa'.toUpperCase(),
                  style: GoogleFonts.lato(
                    fontWeight: FontWeight.bold,
                    fontSize: Utils.textTheme().subtitle1.fontSize,
                    color: _animationAppBarTextColor.value,
                  ),
                ),
                animation: _animationAppBarTextColor,
              ),
              Spacer(),
              Text('Greetings',
                style: GoogleFonts.lato(
                  fontWeight: FontWeight.w600,
                  fontSize: Utils.textTheme().subtitle1.fontSize,
                  color: Colors.grey.shade900,
                ),
              ),
              Container(width: Utils.width(2),),
              Text('About us',
                style: GoogleFonts.lato(
                  fontWeight: FontWeight.w600,
                  fontSize: Utils.textTheme().subtitle1.fontSize,
                  color: Colors.grey.shade900,
                ),
              ),
              Container(width: Utils.width(2),),
              Container(
                padding: EdgeInsets.only(
                  left: Utils.width(2),
                  right: Utils.width(2),
                  top: Utils.height(2),
                  bottom: Utils.height(2),
                ),
                decoration: BoxDecoration(
                    color: Constant.primaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(100))
                ),
                child: Text('Universities',
                  style: GoogleFonts.lato(
                    fontWeight: FontWeight.w600,
                    fontSize: Utils.textTheme().subtitle1.fontSize,
                    color: Colors.white,
                  ),
                ),
              ),
              Container(width: Utils.width(2),),
            ],
          ),
        );
      },
    );
  }

  // components
  Widget welcomeScreen() {
    return Container(
      width: Utils.width(100),
      height: Utils.height(100),
      child: Stack(
        children: [
          // background
          Container(
            width: Utils.width(100),
            height: Utils.height(100),
            child: Row(
              children: [
                Container(
                  color: Constant.primaryColor,
                  width: Utils.width(50),
                  height: Utils.height(100),
                ),
                Container(
                  color: Colors.white,
                  width: Utils.width(50),
                  height: Utils.height(100),
                ),
              ],
            ),
          ),

          // content
          Container(
            width: Utils.width(100),
            height: Utils.height(100),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(
                      left: Utils.width(4),
                      right: Utils.width(4),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Welcome to'.toUpperCase(),
                          style: GoogleFonts.montserrat(
                            letterSpacing: 4,
                            color: Colors.white.withOpacity(.32),
                            fontSize: Utils.textTheme().headline5.fontSize,
                          ),
                        ),
                        Container(height: Utils.height(.8),),
                        Text('Magelang education exhibition.',
                          style: GoogleFonts.playfairDisplay(
                            color: Constant.accentColor,
                            fontSize: Utils.textTheme().headline2.fontSize,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(height: Utils.height(2),),
                        Text('Enjoy your own studio apartment, share extraordinary '
                            'living and working spaces and connect with great people'
                            ' at daily events, with everything included in one '
                            'hassle-free bill.'.toLowerCase(),
                          style: GoogleFonts.montserrat(
                            color: Constant.accentColor.withOpacity(.8),
                            fontSize: Utils.textTheme().subtitle1.fontSize,
                          ),
                        ),
                        Container(height: Utils.height(8),),
                        Container(
                          padding: EdgeInsets.only(
                            left: Utils.width(2),
                            right: Utils.width(2),
                            top: Utils.height(2),
                            bottom: Utils.height(2),
                          ),
                          decoration: BoxDecoration(
                              color: Constant.accentColor,
                              borderRadius: BorderRadius.all(Radius.circular(100))
                          ),
                          child: Text('Get started',
                            style: GoogleFonts.lato(
                              fontWeight: FontWeight.w600,
                              fontSize: Utils.textTheme().subtitle1.fontSize,
                              color: Constant.primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(.32),
                        blurRadius: 16,
                      )
                    ]
                  ),
                  height: Utils.height(100 - 24),
                  width: Utils.width(55),
                  child: Image.network(Constant.urlImageWelcomeScreen,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget poweredScreen() {
    var _icons = [
      'images/smansa-transparent.png',
      'images/osis.png',
      'images/logo-icc.png',
    ];
    var _titles = [
      'SMA Negeri 1\nMagelang',
      'OSIS SMA Negeri 1\nMagelang',
      'Information Clinic\nCommunity'
    ];
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(
        top: Utils.height(8),
        bottom: Utils.height(8),
        right: Utils.width(4),
        left: Utils.width(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('powered by'.toUpperCase(),
            style: GoogleFonts.lato(
              color: Colors.grey.shade600,
              fontSize: Utils.textTheme().headline6.fontSize,
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: Utils.height(4),
            ),
            height: Utils.height(8),
            child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(
                    left: index == 0 ? 0 : Utils.width(2),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(_icons[index]),
                      Container(width: Utils.width(1),),
                      Text(_titles[index],
                        style: GoogleFonts.lato(
                          color: Colors.grey.shade900,
                          fontSize: Utils.textTheme().subtitle1.fontSize,
                        ),
                      ),
                    ],
                  )
                );
              },
              itemCount: _icons.length,
              scrollDirection: Axis.horizontal,
            ),
          ),
        ],
      )
    );
  }

  Widget greetingScreen() {
    var _titleHeight = Utils.textTheme().headline6.fontSize;
    var _subtitleHeight = Utils.textTheme().subtitle1.fontSize;
    var _bodyHeight = 5 * Utils.textTheme().bodyText1.fontSize;
    var _contentHeight = _titleHeight + _subtitleHeight + _bodyHeight;
    var _tileHeight = Utils.height(12 + 16 + 4) + _contentHeight;
    return Container(
      padding: EdgeInsets.only(
        top: Utils.height(8),
        bottom: Utils.height(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            child: Text('Welcome speech'.toUpperCase(),
              style: GoogleFonts.montserrat(
                letterSpacing: 2,
                color: Colors.grey.shade900,
                fontSize: Utils.textTheme().headline6.fontSize,
              ),
            ),
            padding: EdgeInsets.only(
              left: Utils.width(4),
              right: Utils.width(4),
              bottom: Utils.height(4),
            ),
          ),
          Container(
            height: _tileHeight,
            width: Utils.width(100),
            child: ListView.builder(
              itemBuilder: (context, index) {
                return Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(.08),
                        blurRadius: 8,
                      ),
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  margin: EdgeInsets.only(
                    left: index == 0 ? Utils.width(4) : 0,
                    right: index == 2 ? Utils.width(4) : Utils.width(2),
                  ),
                  width: Utils.width((100 - 2 * (4 + 2)) / 3),
                  child: Material(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    clipBehavior: Clip.hardEdge,
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {

                      },
                      child: Container(
                        padding: EdgeInsets.only(
                          left: Utils.width(4),
                          right: Utils.width(4),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(height: Utils.height(4),),
                            Container(
                              child: Material(
                                child: Image.network(Constant.welcomeSpeechImages[0],
                                  fit: BoxFit.cover,
                                ),
                                clipBehavior: Clip.hardEdge,
                                borderRadius: BorderRadius.all(Radius.circular(Utils.height(16))),
                              ),
                              height: Utils.height(16),
                              width: Utils.height(16),
                            ),
                            Padding(
                              child: Text('Emily Clark',
                                style: GoogleFonts.lato(
                                  color: Colors.grey.shade900,
                                  fontSize: Utils.textTheme().headline6.fontSize,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              padding: EdgeInsets.only(
                                top: Utils.height(2),
                                bottom: Utils.height(1),
                              ),
                            ),
                            Padding(
                              child: Text('Headmaster',
                                style: GoogleFonts.lato(
                                  color: Colors.grey.shade500,
                                  fontSize: Utils.textTheme().subtitle1.fontSize,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              padding: EdgeInsets.only(
                                bottom: Utils.height(1),
                              ),
                            ),
                            Expanded(
                              child: Text(Constant.welcomeSpeeches[0],
                                maxLines: 5,
                                overflow: TextOverflow.clip,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.lato(
                                  color: Colors.grey.shade700,
                                  fontSize: Utils.textTheme().bodyText1.fontSize,
                                ),
                              ),
                            ),
                            Container(height: Utils.height(4),),
                          ],
                        ),
                      )
                    ),
                  )
                );
              },
              itemCount: 3,
              scrollDirection: Axis.horizontal,
            ),
          ),
        ],
      ),
    );
  }

  Widget aboutPEM() {
    return Container(
      color: Constant.accentAmberColor,
      width: Utils.width(100),
      padding: EdgeInsets.only(
        top: Utils.height(8),
        left: Utils.width(4),
        bottom: Utils.height(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: Utils.width(30),
            child: Image.asset('images/image-about.png'),
          ),
          Container(width: Utils.width(4),),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('about'.toUpperCase(),
                  style: GoogleFonts.montserrat(
                    letterSpacing: 4,
                    color: Colors.black.withOpacity(.32),
                    fontSize: Utils.textTheme().headline6.fontSize,
                  ),
                ),
                Container(height: Utils.height(.4),),
                Text('Magelang education\nexhibition.',
                  style: GoogleFonts.playfairDisplay(
                    color: Colors.grey.shade900,
                    fontSize: Utils.textTheme().headline3.fontSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(height: Utils.height(.8),),
                Text(Constant.welcomeSpeeches[0],
                  textAlign: TextAlign.justify,
                  style: GoogleFonts.lato(
                    color: Colors.grey.shade700,
                    fontSize: Utils.textTheme().subtitle1.fontSize,
                  ),
                ),
              ],
            ),
          ),
          Container(width: Utils.width(4),),
        ],
      )
    );
  }
  
  Widget aboutPEM2() {
    return Container(
      margin: EdgeInsets.only(
        left: Utils.width(4),
        top: Utils.height(8),
        bottom: Utils.height(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            child: Image.network('assets/svg/image-about-pem.svg',
              fit: BoxFit.contain,
            ),
            width: Utils.width(40),
          ),
          Container(width: Utils.width(4),),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('about'.toUpperCase(),
                  style: GoogleFonts.montserrat(
                    letterSpacing: 4,
                    color: Colors.black.withOpacity(.32),
                    fontSize: Utils.textTheme().headline6.fontSize,
                  ),
                ),
                Container(height: Utils.height(.4),),
                Text('Magelang education\nexhibition.',
                  style: GoogleFonts.playfairDisplay(
                    color: Colors.grey.shade900,
                    fontSize: Utils.textTheme().headline3.fontSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(height: Utils.height(.8),),
                Text(Constant.welcomeSpeeches[0],
                  textAlign: TextAlign.justify,
                  style: GoogleFonts.lato(
                    color: Colors.grey.shade700,
                    fontSize: Utils.textTheme().subtitle1.fontSize,
                  ),
                ),
              ],
            ),
          ),
          Container(width: Utils.width(4),),
        ],
      ),
    );
  }

  Widget universities() {
    return Container(
      width: Utils.width(100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(height: Utils.height(8),),
          Padding(
            padding: EdgeInsets.only(
              left: Utils.width(4),
            ),
            child: Text('universities'.toUpperCase(),
              style: GoogleFonts.montserrat(
                letterSpacing: 4,
                color: Colors.grey.shade500,
                fontSize: Utils.textTheme().headline6.fontSize,
              ),
            ),
          ),
          Container(height: Utils.height(.4),),
          Padding(
            padding: EdgeInsets.only(
              left: Utils.width(4),
            ),
            child: Text('Consists of more than 30\nrenowned campuses.',
              style: GoogleFonts.playfairDisplay(
                color: Colors.grey.shade900,
                fontSize: Utils.textTheme().headline3.fontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(height: Utils.height(.8),),
          Padding(
            child: Text('The university is a higher education and research '
                'institution, which awards academic degrees in a variety of '
                'fields. A university provides undergraduate and postgraduate '
                'education.',
              textAlign: TextAlign.justify,
              style: GoogleFonts.lato(
                color: Colors.grey.shade700,
                fontSize: Utils.textTheme().subtitle1.fontSize,
              ),
            ),
            padding: EdgeInsets.only(
              left: Utils.width(4),
              right: Utils.width(100 * 1 / 3),
            ),
          ),
          Container(height: Utils.height(8),),

          // list
          Container(
            width: Utils.width(100),
            height: Utils.height(60),
            child: ListView.builder(
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(
                    left: index == 0 ? Utils.width(4) : 0,
                    right: index == 4 ? Utils.width(4) : Utils.width(2),
                    bottom: 8, top: 8,
                  ),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(.08),
                        blurRadius: 8,
                      )
                    ]
                  ),
                  width: Utils.width(100 / 3),
                  child: Stack(
                    children: [
                      // content
                      Material(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Container(
                                width: Utils.width(100 / 3),
                                child: Image.network(Constant.universityImageUrls[0],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                left: Utils.width(2),
                                right: Utils.width(2),
                                top: Utils.height(4),
                                bottom: Utils.height(4),
                              ),
                              child: Column(
                                children: [
                                  Text(Constant.universityNames[0],
                                    style: GoogleFonts.lato(
                                      color: Colors.grey.shade900,
                                      fontWeight: FontWeight.bold,
                                      fontSize: Utils.textTheme().subtitle1.fontSize,
                                    ),
                                  ),
                                  Text(Constant.universityDescriptions[0],
                                    textAlign: TextAlign.center,
                                    maxLines: 5,
                                    style: GoogleFonts.lato(
                                      color: Colors.grey.shade600,
                                      fontWeight: FontWeight.normal,
                                      fontSize: Utils.textTheme().bodyText1.fontSize,
                                    ),
                                  ),
                                ],
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                              ),
                            ),
                          ],
                        ),
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        clipBehavior: Clip.hardEdge,
                      ),

                      // ripple effect
                      Material(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        clipBehavior: Clip.hardEdge,
                        child: InkWell(
                          onTap: () {

                          },
                          child: Container(
                            width: Utils.width(100 / 3),
                            height: Utils.height(60),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
              itemCount: 5,
              scrollDirection: Axis.horizontal,
            ),
          ),
          Container(height: Utils.height(8),),
        ],
      ),
    );
  }

  Widget searchUniversity() {
    return Container(
      child: Column(
        children: [
          Padding(
            child: Text('what are you waiting for?'.toLowerCase(),
              style: GoogleFonts.montserrat(
                color: Colors.grey.shade900,
                fontSize: Utils.textTheme().headline6.fontSize,
              ),
            ),
            padding: EdgeInsets.only(
              top: Utils.height(8),
            ),
          ),
          Padding(
            child: Text('Find your dream university now',
              style: GoogleFonts.playfairDisplay(
                fontSize: Utils.textTheme().headline4.fontSize,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade900,
              ),
            ),
            padding: EdgeInsets.only(
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              bottom: Utils.height(8),
              top: Utils.height(8),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // search box
                Container(
                  width: Utils.width(60),
                  child: TextField(
                    maxLines: 1,
                    textInputAction: TextInputAction.done,
                    scrollPadding: EdgeInsets.all(0),
                    decoration: InputDecoration(
                      hintText: 'University',
                      contentPadding: EdgeInsets.only(
                        top: Utils.height(2),
                        bottom: Utils.height(2),
                        left: Utils.width(2),
                        right: Utils.width(2),
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                      color: Colors.grey.shade100,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.08),
                        )
                      ]
                  ),
                  alignment: Alignment.center,
                ),
                Container(width: Utils.width(2),),

                // button search
                Container(
                  decoration: BoxDecoration(
                    color: Constant.primaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(.16),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  margin: EdgeInsets.only(
                  ),
                  child: Material(
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                    clipBehavior: Clip.hardEdge,
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {

                      },
                      child: Container(
                        padding: EdgeInsets.only(
                          top: Utils.height(2),
                          bottom: Utils.height(2),
                          left: Utils.width(2),
                          right: Utils.width(2),
                        ),
                        child: Text('Search',
                          style: GoogleFonts.montserrat(
                            color: Colors.white,
                            fontSize: Utils.textTheme().bodyText1.fontSize,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget footer() {
    return Container(
      color: Colors.grey.shade900,
      width: Utils.width(100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(height: Utils.height(8),),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // pem title
              Container(
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        left: Utils.width(4),
                        right: Utils.width(2),
                      ),
                      height: Utils.height(8),
                      child: Image.network('assets/images/smansa-transparent.png'),
                    ),
                    Text('Pameran Edukasi\nMagelang',
                      style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: Utils.textTheme().headline6.fontSize,
                      ),
                    ),
                    Container(width: Utils.width(4),),
                  ],
                ),
              ),

              // menu about us
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('About us'.toUpperCase(),
                      style: GoogleFonts.montserrat(
                        color: Colors.grey.shade800,
                        fontWeight: FontWeight.bold,
                        fontSize: Utils.textTheme().bodyText1.fontSize,
                      ),
                    ),
                    Container(height: Utils.height(2),),
                    Text('Apa itu PEM?',
                      style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                        fontSize: Utils.textTheme().bodyText1.fontSize,
                      ),
                    ),
                    Container(height: Utils.height(1),),
                    Text('Sambutan',
                      style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                        fontSize: Utils.textTheme().bodyText1.fontSize,
                      ),
                    ),
                    Container(height: Utils.height(1),),
                    Text('Kontak',
                      style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                        fontSize: Utils.textTheme().bodyText1.fontSize,
                      ),
                    ),
                    Container(height: Utils.height(1),),
                    Text('Daftar universitas',
                      style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                        fontSize: Utils.textTheme().bodyText1.fontSize,
                      ),
                    ),
                    Container(height: Utils.height(1),),
                    Text('Sponsor',
                      style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                        fontSize: Utils.textTheme().bodyText1.fontSize,
                      ),
                    ),
                  ],
                ),
              ),
              Container(width: Utils.width(4),),

              // menu legal stuff
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('legal stuff'.toUpperCase(),
                      style: GoogleFonts.montserrat(
                        color: Colors.grey.shade800,
                        fontWeight: FontWeight.bold,
                        fontSize: Utils.textTheme().bodyText1.fontSize,
                      ),
                    ),
                    Container(height: Utils.height(2),),
                    Text('Privacy policy',
                      style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                        fontSize: Utils.textTheme().bodyText1.fontSize,
                      ),
                    ),
                    Container(height: Utils.height(1),),
                    Text('Terms of service',
                      style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                        fontSize: Utils.textTheme().bodyText1.fontSize,
                      ),
                    ),
                    Container(height: Utils.height(1),),
                    Text('Cookie policy',
                      style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                        fontSize: Utils.textTheme().bodyText1.fontSize,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            color: Colors.white.withOpacity(.08),
            width: Utils.width(100),
            height: 1.5,
            margin: EdgeInsets.only(
              bottom: Utils.height(4),
              top: Utils.height(8),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('2020 PEM Smansa © All right reserved. Made with ',
                style: GoogleFonts.montserrat(
                  fontSize: Utils.textTheme().bodyText1.fontSize,
                  color: Colors.white.withOpacity(.8),
                ),
              ),
              Icon(Icons.favorite_rounded,
                color: Colors.red,
                size: Utils.textTheme().subtitle1.fontSize,
              ),
              Text(' by ICC',
                style: GoogleFonts.montserrat(
                  fontSize: Utils.textTheme().bodyText1.fontSize,
                  color: Colors.white.withOpacity(.8),
                ),
              ),
            ],
          ),
          Container(height: Utils.height(4),),
        ],
      ),
    );
  }
}