import 'package:flutter/foundation.dart';

import 'package:url_launcher/url_launcher.dart';

const _headers = <String, String>{'my_header_key': 'my_header_value'};
const _webViewConfigurationJsEnabled = WebViewConfiguration(headers: _headers);
const _webViewConfigurationJsDisabled = WebViewConfiguration(headers: _headers, enableJavaScript: false);

class Launchers {
  Future<bool> checkPhoneCallSupport() => canLaunchUrl(Uri(scheme: 'tel', path: '123'));

  Future<void> makePhoneCall({required String phoneNumber}) async {
    Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
    await launchUrl(launchUri);
  }

  Future<void> launchEmailApp({required String email}) async {
    var mail = Uri.encodeComponent(email);
    var subject = Uri.encodeComponent('');
    var body = Uri.encodeComponent('');
    Uri uri = Uri.parse('mailto:$mail?subject=$subject&body=$body');
    if (await launchUrl(uri)) {
      if (kDebugMode) print('email app opened');
    } else {
      if (kDebugMode) print('email app is not opened');
    }
  }

  Future<void> launchInBrowser({required String url}) async {
    if (!await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
      webViewConfiguration: _webViewConfigurationJsEnabled,
    )) {
      throw ArgumentError('Could not launch $url');
    }
  }

  Future<void> launchInWebView({required String url}) async {
    if (!await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.inAppWebView,
      webViewConfiguration: _webViewConfigurationJsEnabled,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> launchInWebViewWithoutJavaScript({required String url}) async {
    if (!await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.inAppWebView,
      webViewConfiguration: _webViewConfigurationJsDisabled,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> launchUniversalLinkIos({required String url}) async {
    bool nativeAppLaunchSucceeded = await launchUrl(Uri.parse(url), mode: LaunchMode.externalNonBrowserApplication);
    if (!nativeAppLaunchSucceeded) await launchUrl(Uri.parse(url), mode: LaunchMode.inAppWebView);
  }
}
