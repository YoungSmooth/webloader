import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webview_flutter/webview_flutter.dart';

class UserHomePage extends StatefulWidget {
  const UserHomePage({Key? key}) : super(key: key);

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  final _controller = Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '- Pub.Dev -',
          style: GoogleFonts.acme(
            fontStyle: FontStyle.normal,
            color: Colors.white,
            letterSpacing: .4,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            backgroundColor: Colors.green,
          ),
        ),
        centerTitle: true,
        elevation: 3,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.red, Color.fromARGB(255, 25, 10, 143)],
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
            ),
          ),
        ),
      ),
      body: WebView(
        initialUrl: "https://pub.dev",
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (controller) => _controller.complete(controller),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        hoverColor: Colors.red,
        onPressed: () {},
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, Color.fromARGB(255, 8, 9, 82)],
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 0.001, left: 0.001),
          child: ButtonBar(
            children: [
              navigationButton(
                Icons.arrow_back_ios_new_outlined,
                (controller) => _goBack(controller),
              ),
              navigationButton(
                Icons.arrow_forward_ios_outlined,
                (controller) => _goForward(controller),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget navigationButton(IconData icon, Function(WebViewController) onPressed) {
  var _controller = Completer<WebViewController>();
  return FutureBuilder(
      future: _controller.future,
      builder: (context, AsyncSnapshot<WebViewController> snapshot) {
        if (snapshot.hasData) {
          return IconButton(
              icon: Icon(
                icon,
                color: Colors.white,
              ),
              onPressed: () => onPressed(snapshot.requireData));
        } else {
          // ignore: avoid_unnecessary_containers
          return Container(
            child: const Text('Loading'),
          );
        }
      });
}

void _goBack(WebViewController controller) async {
  final canGoBack = await controller.canGoBack();

  if (canGoBack) {
    controller.goBack();
  }
}

void _goForward(WebViewController controller) async {
  final canGoForward = await controller.canGoForward();

  if (canGoForward) {
    controller.goForward();
  }
}
