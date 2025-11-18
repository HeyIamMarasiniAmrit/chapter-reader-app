import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Readerscreen extends StatefulWidget {
  final int chapterID;

  const Readerscreen(this.chapterID, {super.key});

  @override
  State<Readerscreen> createState() => _ReaderscreenState();
}

class _ReaderscreenState extends State<Readerscreen> {
  late WebViewController _controller;

  @override
  void initState() {
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted);

    if (widget.chapterID == 1) {
      _loadHtml("assets/ch1.html");
    } else {
      _loadHtml("assets/ch2.html");
    }
  }

  Future<void> _loadHtml(String path) async {
    String fileText = await rootBundle.loadString(path);
    final uri = Uri.dataFromString(
      fileText,
      mimeType: 'text/html',
      encoding: utf8,
    );

    _controller.loadRequest(uri);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Chapter ${widget.chapterID}")),
      body: WebViewWidget(controller: _controller),
    );
  }
}
