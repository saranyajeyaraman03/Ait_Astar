import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class VideoWebViewScreen extends StatefulWidget {
  final List<String> videoUrls;

  const VideoWebViewScreen({super.key, required this.videoUrls});

  @override
  VideoWebViewScreenState createState() => VideoWebViewScreenState();
}

class VideoWebViewScreenState extends State<VideoWebViewScreen> {
  late InAppWebViewController _webViewController;
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Container(
                  height: 200, 
                  child: InAppWebView(
                    initialUrlRequest: URLRequest(url: Uri.parse(widget.videoUrls[_currentIndex])),
                    onWebViewCreated: (controller) {
                      _webViewController = controller;
                    },
                    initialOptions: InAppWebViewGroupOptions(
                      android: AndroidInAppWebViewOptions(
                        allowFileAccess: true,
                      ),
                    ),
                    // Add this code to auto-play the video when the page loads
                    onLoadStop: (controller, url) {
                      controller.evaluateJavascript(source: 'document.querySelector("video").play();');
                    },
                  ),
                ),
                Positioned(
                  left: 20, 
                  top: 80, 
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios_sharp,color: Colors.white,size: 30,),
                    onPressed: () {
                      if (_currentIndex > 0) {
                        setState(() {
                          _currentIndex--;
                          _webViewController.loadUrl(urlRequest: URLRequest(url: Uri.parse(widget.videoUrls[_currentIndex])));
                        });
                      }
                    },
                  ),
                ),
                Positioned(
                  right: 20, 
                  top: 80, 
                  child: IconButton(
                    icon: const Icon(Icons.arrow_forward_ios_sharp,color: Colors.white,size: 30,),
                    onPressed: () {
                      if (_currentIndex < widget.videoUrls.length - 1) {
                        setState(() {
                          _currentIndex++;
                          _webViewController.loadUrl(urlRequest: URLRequest(url: Uri.parse(widget.videoUrls[_currentIndex])));
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

