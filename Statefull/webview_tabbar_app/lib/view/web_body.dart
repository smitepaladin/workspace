import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebBody extends StatefulWidget {
  final String siteName;
  const WebBody({super.key, required this.siteName});

  @override
  State<WebBody> createState() => _WebBodyState();
}

class _WebBodyState extends State<WebBody> {
  //Property
  late WebViewController controller;
  late bool isLoading;

  @override
  void initState() {
    super.initState();
    isLoading = true; // for indicator
    controller =
        WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..setNavigationDelegate(
            NavigationDelegate(
              onProgress: (progress) {
                isLoading = true;
                setState(() {});
              },
              onPageStarted: (url) {
                isLoading = true;
                setState(() {});
              },
              onPageFinished: (url) {
                isLoading = false;
                setState(() {});
              },
              onWebResourceError: (error) {
                isLoading = false;
                setState(() {});
              },
            ),
          )
          ..loadRequest(Uri.parse("https://${widget.siteName}"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        // 웹이라서
        children: [
          isLoading
              ? Center(child: CircularProgressIndicator())
              : WebViewWidget(controller: controller),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.error,
        foregroundColor: Theme.of(context).colorScheme.onError,
        onPressed: () => backProcess(),
        child: Icon(Icons.arrow_back),
      ),
    );
  } // build

  // functions //

  backProcess() async {
    if (await controller.canGoBack()) {
      controller.goBack();
    } else {
      snackBarFunctions();
    }
  }

  snackBarFunctions() {
    Get.snackbar('Warning', 'No more to Go!');
  }
} // Class
