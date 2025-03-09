// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';

// class TawkChatScreen extends StatefulWidget {
//   const TawkChatScreen({Key? key}) : super(key: key);

//   @override
//   _TawkChatScreenState createState() => _TawkChatScreenState();
// }

// class _TawkChatScreenState extends State<TawkChatScreen> {
//   late final WebViewController _controller;

//   @override
//   void initState() {
//     super.initState();
//     _controller = WebViewController()
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..loadRequest(Uri.parse('https://tawk.to/chat/<your-widget-id>/default'));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Live Chat"),
//         backgroundColor: Colors.green,
//       ),
//       body: WebViewWidget(controller: _controller),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
// For mobile-only WebView usage
// import 'package:webview_flutter/webview_flutter.dart';

class TawkChatScreen extends StatelessWidget {
  const TawkChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // If we're on web, rely on the Tawk script in web/index.html
    if (kIsWeb) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Live Chat (Web)"),
          backgroundColor: Colors.green,
        ),
        body: const Center(
          child: Text(
            "Tawk Live Chat loaded via script in web/index.html.\n"
            "Open the chat widget in the bottom-right corner (if configured).",
            textAlign: TextAlign.center,
          ),
        ),
      );
    } else {
      // If not web, show the Mobile placeholder
      return const _MobileTawkChat();
    }
  }
}

// Only used on mobile
class _MobileTawkChat extends StatefulWidget {
  const _MobileTawkChat({Key? key}) : super(key: key);

  @override
  State<_MobileTawkChat> createState() => _MobileTawkChatState();
}

class _MobileTawkChatState extends State<_MobileTawkChat> {
  // late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    // Uncomment these lines for Android/iOS:
    // _controller = WebViewController()
    //   ..setJavaScriptMode(JavaScriptMode.unrestricted)
    //   ..loadRequest(Uri.parse('https://tawk.to/chat/<your-widget-id>/default'));
  }

  @override
  Widget build(BuildContext context) {
    // For now, just a placeholder so web won't crash:
    return Scaffold(
      appBar: AppBar(
        title: const Text("Live Chat (Mobile Placeholder)"),
        backgroundColor: Colors.green,
      ),
      body: const Center(
        child: Text(
          "WebView code is commented out. Uncomment and run on a mobile device/emulator to load Tawk chat.",
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
