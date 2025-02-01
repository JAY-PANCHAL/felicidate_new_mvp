import 'dart:async';
import 'dart:io';
import 'package:felicidade/common/utils/Styles.dart';
import 'package:felicidade/common/utils/color_constants.dart';
import 'package:flutter/material.dart';

import 'package:webview_flutter/webview_flutter.dart';

final GlobalKey<WebScreenState> webScreenKey = GlobalKey<WebScreenState>();

class WebScreen extends StatefulWidget {
  WebScreen({Key? key, required this.strTitle, required this.strUrl})
      : super(key: key);
  final String strUrl;
  final String strTitle;
  Completer<WebViewController> _controller = Completer<WebViewController>();

  @override
  WebScreenState createState() => WebScreenState();
}

class WebScreenState extends State<WebScreen> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  bool isLoading = true;
  final _key = UniqueKey();

  @override
  void initState() {
    super.initState();
    // Enable virtual display.
    // if (Platform.isAndroid) WebView.platform = AndroidWebView();
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return WillPopScope(
        onWillPop: () async {
          Navigator.pop(context, 'save');
          return false;
        },
        child: Scaffold(
          backgroundColor: AppColors.appblue,
          body: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 100,
                    decoration: BoxDecoration(
                      color: AppColors.appblue,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(0),
                          bottomLeft: Radius.circular(50),
                          bottomRight: Radius.circular(50),
                          topRight: Radius.circular(0)),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, statusBarHeight + 10, 0, 0),
                    child: Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width,
                      child: Stack(
                        children: [
                          InkWell(
                            child: Container(
                              margin: EdgeInsets.fromLTRB(25, 5, 0, 0),
                              child: Icon(
                                Icons.arrow_back_ios_rounded,
                                color: AppColors.white,
                                size: 30.0,
                              ),
                            ),
                            onTap: () async {
                              Navigator.pop(context, 'save');
                              //Navigator.pop(context, 'save');
                              /*    Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(builder: (BuildContext context) => HomeScreen()),
                                    (Route<dynamic> route) => false,
                              );*/
                            },
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              widget.strTitle,
                              style: Styles.textFontRegular(
                                  size: 20, weight: FontWeight.w400),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          // InkWell(
                          //   child: Container(
                          //     margin: EdgeInsets.fromLTRB(0, 0, 15, 0),
                          //     child: ImageIcon(
                          //       AssetImage("assets/images/ic_edit_profile.png"),
                          //       color: AppColor.white,
                          //       size: 30.0,
                          //     ),
                          //   ),
                          //   onTap: () {
                          //     // Navigator.of(context)
                          //     //     .push(createRoute(EditProfileScreen()));
                          //   },
                          // ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Stack(
                  children: [
                    WebView(
                      key: _key,
                      initialUrl: widget.strUrl,
                      javascriptMode: JavascriptMode.unrestricted,
                      onWebViewCreated: (WebViewController controller) {
                        _controller.complete(controller);
                      },
                      navigationDelegate: (NavigationRequest request) {
                        // Handle URL changes here`
                        print('Current URL: ${request.url}');
                        if (request.url.contains("/payment/success")) {
                          /*Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    HomeScreen()),
                            (Route<dynamic> route) => false,
                          );*/
                        }
                        return NavigationDecision.navigate;
                      },
                      onPageFinished: (finish) {
                        setState(() {
                          isLoading = false;
                        });
                      },
                    ),
                    isLoading
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : Stack(),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Future<String?> getCurrentUrl() async {
    final controller = await webScreenKey.currentState?._controller.future;
    return controller?.currentUrl();
  }
}
