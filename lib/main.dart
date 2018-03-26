import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'dart:async';

import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

String url = "https://youtube.com/";

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Webview Example',
      theme: ThemeData.dark(),
      routes: {
        "/": (_) => Home(),
        "/webview": (_) => WebviewScaffold(
              url: url,
              appBar: AppBar(
                title: Text("WebView"),
              ),
              withJavascript: true,
              withLocalStorage: true,
              withZoom: true,
            )
      },

      // home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  final webView = FlutterWebviewPlugin();
  TextEditingController controller = TextEditingController(text: url);

  @override
  void initState() {
    super.initState();

    webView.close();
    controller.addListener(() {
      url = controller.text;
    });
  }

  @override
  void dispose() {
    webView.dispose();
    controller.dispose();
    super.dispose();
  }

  // Future launchURL(String url) async {
  //   if (await canLaunch(url)) {
  //     await launch(url, forceSafariVC: true, forceWebView: true);
  //   } else {
  //     print("Can't Launch ${url}");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("WebView"),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(10.0),
                child: TextField(
                  controller: controller,
                ),
              ),
              RaisedButton(
                child: Text("Open Webview"),
                onPressed: () {
                  Navigator.of(context).pushNamed("/webview");
                },
              )
            ],
          ),
        )

        // body: Center(
        //   child: Column(
        //     children: <Widget>[
        //       Container(
        //         padding: EdgeInsets.all(10.0),
        //         child: Text(URL),
        //       ),
        //       RaisedButton(
        //         child: Text("Open Link"),
        //         onPressed: () {
        //           launchURL(URL);
        //         },
        //       )
        //     ],
        //   ),
        // ),
        );
  }
}
