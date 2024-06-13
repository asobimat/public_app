import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class RenderView extends StatefulWidget {
  const RenderView({super.key});

  @override
  State<RenderView> createState() => _WebViewAppState();
}

class _WebViewAppState extends State<RenderView> {
  late WebViewController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter WebView'),
      ),
      body: WebViewWidget(
        controller: _controller,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..loadRequest(Uri.parse('https://www.google.com'));
  }
}