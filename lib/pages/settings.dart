import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    var _controller = Completer<WebViewController>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Humphrey',
          style: GoogleFonts.raleway(
            fontStyle: FontStyle.normal,
            color: Colors.black,
            letterSpacing: .4,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            backgroundColor: Colors.transparent,
          ),
        ),
        centerTitle: true,
        elevation: 30,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(25),
              bottomLeft: Radius.circular(25),
              topRight: Radius.circular(1005),
              topLeft: Radius.circular(1005)),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.menu,
            color: Colors.black,
          ),
          tooltip: 'Menu Icon',
          onPressed: () {},
        ),
        systemOverlayStyle: SystemUiOverlayStyle.light,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 0.001, left: 0.001),
            child: ButtonBar(
              children: [
                Icon(Icons.search_off_rounded, color: Colors.black),
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
        ],
      ),
      body: WebView(
        initialUrl: "https://google.com",
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (controller) => _controller.complete(controller),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.blue,
        ),
        backgroundColor: Colors.white,
        hoverColor: Colors.red,
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, Color.fromARGB(255, 8, 9, 82)],
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 1.0, left: 1.0),
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
                color: Colors.black,
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
