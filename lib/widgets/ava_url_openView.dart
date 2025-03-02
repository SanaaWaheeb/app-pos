import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class UrlViewScreen extends StatefulWidget {
  final String url;
  const UrlViewScreen({super.key, required this.url});

  @override
  _UrlViewScreenState createState() => _UrlViewScreenState();
}

class _UrlViewScreenState extends State<UrlViewScreen> {
  late WebViewController _webViewController;
  bool _isPageLoaded = false;

  @override
  void initState() {
    super.initState();
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color.fromARGB(255, 0, 0, 0))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {
            setState(() {
              _isPageLoaded = true;
            });
          },
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith(widget.url)) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      );

    if (!_isPageLoaded) {
      _webViewController.loadRequest(Uri.parse(widget.url));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: WebViewWidget(
          controller: _webViewController,
        ),
      ),
    );
  }
}
