import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../base/base_stateful_state.dart';
import '../../common_widgets/common_appbar.dart';
import '../../common_widgets/common_widgets.dart';
import '../../resources/color.dart';

class InAppWebViewScreen extends StatefulWidget {
  final String webUrl;
  final String title;

  const InAppWebViewScreen({
    Key? key,
    required this.webUrl,
    required this.title,
  }) : super(key: key);

  @override
  InAppWebViewScreenState createState() => InAppWebViewScreenState();
}

class InAppWebViewScreenState extends BaseStatefulWidgetState<InAppWebViewScreen> {
  final GlobalKey webViewKey = GlobalKey();

  @override
  bool get extendBodyBehindAppBar => true;

  @override
  bool get shouldHaveSafeArea => false;

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    // TODO: implement buildAppBar
    return CommonAppBar(
      title: widget.title,
      shouldShowBackButton: true,
    );
  }

  InAppWebViewController? webViewController;
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        useShouldOverrideUrlLoading: true,
        javaScriptEnabled: true,
        mediaPlaybackRequiresUserGesture: false,
        supportZoom: false,
        transparentBackground: true,
        disableHorizontalScroll: true,
        disableVerticalScroll: false,
        verticalScrollBarEnabled: false,
        horizontalScrollBarEnabled: false,
      ),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
        textZoom: 100 * 2,
      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      ));

  late PullToRefreshController pullToRefreshController;
  String url = "";
  double progress = 0;
  bool showLoading = true;
   @override
  void initState() {
    super.initState();
    pullToRefreshController = PullToRefreshController(
      options: PullToRefreshOptions(color: colorPrimary),
    );
  }

  @override
  Widget buildBody(BuildContext context) {
    return Container(
        color: colorWhite,
        width: screenSize.width,
        height: screenSize.height,
        margin: EdgeInsets.only(top: 100.h),
        padding: EdgeInsets.only(top: 20.h),
        child: Column(
          children: [
            showLoading ? screenLoader() : Container(),
            // progress < 1.0 ? SizedBox(height: screenSize.height / 1.3, child: commonLoader()) : Container(),
            Expanded(
              child:  InAppWebView(
                key: webViewKey,
                initialUrlRequest: URLRequest(url: Uri.parse(widget.webUrl)),
                initialOptions: options,
                // pullToRefreshController: pullToRefreshController,
                onWebViewCreated: (controller) {
                  webViewController = controller;
                },
                onLoadStart: (controller, url) {

                  setState(() {
                    showLoading = true;
                    this.url = url.toString();
                   });
                },
                androidOnPermissionRequest: (controller, origin, resources) async {
                  return PermissionRequestResponse(resources: resources, action: PermissionRequestResponseAction.GRANT);
                },

                onLoadStop: (controller, url) async {

                  pullToRefreshController.endRefreshing();
                  setState(() {
                    showLoading = false;
                    this.url = url.toString();
                   });
                },
                onLoadError: (controller, url, code, message) {
                  pullToRefreshController.endRefreshing();
                },
                onProgressChanged: (controller, progress) {

                  showLoading = true;
                  if (progress == 100) {
                    showLoading = false;
                    pullToRefreshController.endRefreshing();
                  }
                  setState(() {
                    this.progress = progress / 100;
                   });
                },
                onUpdateVisitedHistory: (controller, url, androidIsReload) {

                  setState(() {
                    this.url = url.toString();
                   });
                },
                onConsoleMessage: (controller, consoleMessage) {


                  if (kDebugMode) {
                    print(consoleMessage);
                  }
                },
              ),
            ),
          ],
        ));
  }
}
