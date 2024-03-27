import 'package:flutter/material.dart'
    show
        AssetImage,
        BoxDecoration,
        BoxFit,
        BuildContext,
        Color,
        Container,
        DecorationImage,
        FloatingActionButtonLocation,
        FocusNode,
        FocusScope,
        GestureDetector,
        GlobalKey,
        MediaQuery,
        Navigator,
        PreferredSizeWidget,
        SafeArea,
        Scaffold,
        ScaffoldMessenger,
        ScaffoldState,
        Size,
        SizedBox,
        State,
        StatefulWidget,
        Theme,
        ThemeData,
        Widget,
        protected;
import '../resources/color.dart';
import '../resources/image.dart';
import '../utils/slide_left_route.dart';

abstract class BaseStatefulWidgetState<StateMVC extends StatefulWidget> extends State<StateMVC> {
  late ThemeData baseTheme;
  bool shouldShowProgress = false;
  bool shouldHaveSafeArea = true;
  bool resizeToAvoidBottomInset = true;
  final rootScaffoldKey = GlobalKey<ScaffoldState>();
  late Size screenSize;
  bool isBackgroundImage = false;
  bool extendBodyBehindAppBar = false;
  Color? scaffoldBgColor;
  String? scaffoldBgImage;
  FloatingActionButtonLocation? floatingActionButtonLocation;

  @override
  void didChangeDependencies() {
    baseTheme = Theme.of(context);
    screenSize = MediaQuery.of(context).size;
    super.didChangeDependencies();
  }

  void pushAndClearStack(BuildContext context, {required Widget enterPage, bool shouldUseRootNavigator = false}) {
    ScaffoldMessenger.of(rootScaffoldKey.currentContext!).hideCurrentSnackBar();
    Future.delayed(Duration(milliseconds: 200)).then((value) => Navigator.of(rootScaffoldKey.currentContext!, rootNavigator: shouldUseRootNavigator).pushAndRemoveUntil(SlideLeftRoute(page: enterPage), (route) => false));
  }

  void pushReplacement(BuildContext context, {required Widget enterPage, bool shouldUseRootNavigator = false}) {
    ScaffoldMessenger.of(rootScaffoldKey.currentContext!).hideCurrentSnackBar();
    Future.delayed(Duration(milliseconds: 200)).then((value) => Navigator.of(context, rootNavigator: shouldUseRootNavigator).pushReplacement(SlideLeftRoute(page: enterPage)));
  }

  void push(BuildContext context, {required Widget enterPage, bool shouldUseRootNavigator = false, Function? callback}) {
    ScaffoldMessenger.of(rootScaffoldKey.currentContext!).hideCurrentSnackBar();
    FocusScope.of(rootScaffoldKey.currentContext!).requestFocus(FocusNode());
    Future.delayed(Duration(milliseconds: 200)).then((value) => Navigator.of(context, rootNavigator: shouldUseRootNavigator).push(SlideLeftRoute(page: enterPage)).then((value) {
          callback?.call(value);
        }));
  }

  Future<dynamic> pushForResult(
    BuildContext context, {
    required Widget enterPage,
    bool shouldUseRootNavigator = false,
  }) {
    return Navigator.of(context, rootNavigator: shouldUseRootNavigator).push(
      SlideLeftRoute(page: enterPage),
    );
  }

  void goBack([val]) {
    Navigator.pop(rootScaffoldKey.currentContext!, val);
  }

  @override
  Widget build(BuildContext context) {
    Widget bodyContent = buildBody(context);
    if (shouldHaveSafeArea) {
      bodyContent = SafeArea(
        bottom: true,
        child: !isBackgroundImage
            ? bodyContent
            : SizedBox(
                width: screenSize.width,
                height: screenSize.height,
                child: bodyContent,
              ),
      );
    } else if (isBackgroundImage) {
      bodyContent = Container(
        width: screenSize.width,
        height: screenSize.height,
        decoration: BoxDecoration(image: DecorationImage(image: AssetImage(scaffoldBgImage ?? PNGImages.imgSplashScreen), fit: BoxFit.fill)),
        child: bodyContent,
      );
    }

    return GestureDetector(
      onTap: () => FocusScope.of(rootScaffoldKey.currentContext!).requestFocus(FocusNode()),
      child: Scaffold(
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        key: rootScaffoldKey,
        extendBody: false,
        extendBodyBehindAppBar: extendBodyBehindAppBar,
        backgroundColor: scaffoldBgColor ?? colorWhite,
        appBar: buildAppBar(context),
        body: bodyContent,
        bottomNavigationBar: buildBottomNavigationBar(context),
        floatingActionButton: buildFloatingActionButton(context),
        floatingActionButtonLocation: floatingActionButtonLocation ?? FloatingActionButtonLocation.endDocked,
      ),
    );
  }

  @protected
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return null;
  }

  Widget buildBody(BuildContext context) {
    return widget;
  }

  Widget? buildBottomNavigationBar(BuildContext context) {
    return null;
  }

  Widget? buildFloatingActionButton(BuildContext context) {
    return null;
  }
}
