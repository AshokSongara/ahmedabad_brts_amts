import 'dart:async';
import 'dart:io';

import 'package:ahmedabad_brts_amts/core/loader/overylay_loader.dart';
import 'package:ahmedabad_brts_amts/presentation/pages/transitmap/transitmap_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html/parser.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  final String? url;

  const WebViewScreen({super.key, required this.url});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late WebViewController _controller;

  @override
  void initState() {
    super.initState();
    Loader.show(context);
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Payment Details',)),
      body: WebView(
        initialUrl: widget.url ?? "",
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _controller = webViewController;
        },
        onProgress: (int progress) {
          print("WebView is loading (progress : $progress%)");
        },
        javascriptChannels: <JavascriptChannel>{},
        navigationDelegate: (NavigationRequest request) {
          if (request.url.startsWith('https://www.youtube.com/')) {
            print('blocking navigation to $request}');
            return NavigationDecision.prevent;
          }
          print('allowing navigation to $request');
          return NavigationDecision.navigate;
        },
        onPageStarted: (String url) {
          print("onPageStarted${url}");
          if (url.contains(
              "http://125.17.144.58:8081/SessionResponse?merchantId=470000087089747")) {
            print("###Parse HTML");

            Future.delayed(const Duration(seconds: 3), () async {
              String htmlContent = await _controller
                  .evaluateJavascript("document.documentElement.innerHTML");

             //  List<String>? list = html.split(' ');
             //
             // print("#####Data${list[422]}");



              Navigator.pop(context, htmlContent);


            });
          }
          else if(url.contains(
              "http://125.17.144.58:8081/SessionResponse?merchantId=470000087089746")){
            print("###Parse HTML");

            Future.delayed(const Duration(seconds: 5), () async {
              String htmlContent = await _controller
                  .evaluateJavascript("document.documentElement.innerHTML");

              //  List<String>? list = html.split(' ');
              //
              // print("#####Data${list[422]}");

              Navigator.pop(context, htmlContent);

            });
          }
        },
        onPageFinished: (String url) {
          Loader.hide();
          print('Page finished loading: $url');
        },
        gestureNavigationEnabled: true,
      ),
    );
  }

  void readJS() async {
    //String html = await controller.evaluateJavascript("window.document.getElementsByTagName('html')[0].outerHTML;");
    // print(html);
  }
}
