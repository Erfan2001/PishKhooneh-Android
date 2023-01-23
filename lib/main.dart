import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pish khoneh',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late WebViewController webViewController;
  late int progressValue;

  @override
  void initState() {
    progressValue = 0;

    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            setState(
                  () {
                progressValue = progress;
              },
            );
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://erfan-nourbakhsh.ir/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse('https://erfan-nourbakhsh.ir/'));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: body(),
      ),
    );
  }

  Widget body() {
    if (progressValue >= 100) {
      return WebViewWidget(
        controller: webViewController,
      );
    } else {
      return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background_image.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Flexible>[
                Flexible(
                  child: Image.asset(
                    'assets/images/name.png',
                  ),
                ),
                Flexible(
                  child: Image.asset(
                    'assets/images/icon.png',
                    width: 50.0,
                    height: 50.0,
                  ),
                ),
              ],
            ),
        Flexible(
          child: CircularProgressIndicator(
            color: Color(0xFFD03859),
            strokeWidth: 5.0,
          ),
        ),
          ],
        ),
      );
    }
  }
}
