import 'dart:async';
import 'dart:convert';
import 'dart:io' show Platform;
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart' show parse;
import 'package:http/http.dart' as http;
import 'package:demo_app/utils/custom_extensions.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

/// Information about the app's current version, and the most recent version
/// available in the Apple App Store or Google Play Store.
class VersionStatus {
  /// The current version of the app.
  final String localVersion;

  /// The most recent version of the app in the store.
  final String storeVersion;

  /// A link to the app store page where the app can be updated.
  final String appStoreLink;

  /// The release notes for the store version of the app.
  final String? releaseNotes;

  /// The release notes for the store downloads of the app.
  final String downloads;

  /// True if the there is a more recent version of the app in the store.
  // bool get canUpdate => localVersion.compareTo(storeVersion).isNegative;
  // version strings can be of the form xx.yy.zz (build)
  bool get canUpdate {
    // assume version strings can be of the form xx.yy.zz
    // this implementation correctly compares local 1.10.1 to store 1.9.4
    try {
      final localFields = localVersion.split('.');
      final storeFields = storeVersion.split('.');
      String localPad = '';
      String storePad = '';
      for (int i = 0; i < storeFields.length; i++) {
        localPad = localPad + localFields[i].padLeft(3, '0');
        storePad = storePad + storeFields[i].padLeft(3, '0');
      }
      // print('new_version canUpdate local $localPad store $storePad');
      if (localPad.compareTo(storePad) < 0) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return localVersion.compareTo(storeVersion).isNegative;
    }
  }

  VersionStatus._({
    required this.localVersion,
    required this.storeVersion,
    required this.appStoreLink,
    this.releaseNotes,
    required this.downloads,
  });
}

class NewVersion {
  /// An optional value that can override the default packageName when
  /// attempting to reach the Apple App Store. This is useful if your app has
  /// a different package name in the App Store.
  final String? iOSId;

  /// An optional value that can override the default packageName when
  /// attempting to reach the Google Play Store. This is useful if your app has
  /// a different package name in the Play Store.
  final String? androidId;

  /// Only affects iOS App Store lookup: The two-letter country code for the store you want to search.
  /// Provide a value here if your app is only available outside the US.
  /// For example: US. The default is US.
  /// See http://en.wikipedia.org/wiki/ ISO_3166-1_alpha-2 for a list of ISO Country Codes.
  final String? iOSAppStoreCountry;

  NewVersion({
    this.androidId,
    this.iOSId,
    this.iOSAppStoreCountry,
  });

  /// This checks the version status, then displays a platform-specific alert
  /// with buttons to dismiss the update alert, or go to the app store.
  showAlertIfNecessary({required BuildContext context, required String androidLiveVersion}) async {
    final VersionStatus? versionStatus = await getVersionStatus(androidLiveVersion);
    if (versionStatus != null && versionStatus.canUpdate) {
      showUpdateDialog(context: context, versionStatus: versionStatus);
    }
  }

  /// This checks the version status and returns the information. This is useful
  /// if you want to display a custom alert, or use the information in a different
  /// way.
  Future<VersionStatus?> getVersionStatus(String androidLiveVersion) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    // if (Platform.isIOS) {
    //   return _getiOSStoreVersion(packageInfo);
    // } else if (Platform.isAndroid) {
      return _getAndroidStoreVersion(packageInfo, androidLiveVersion);
    // } else {
    //   debugPrint(
    //       'The target platform "${Platform.operatingSystem}" is not yet supported by this package.');
    //   return null;
    // }
  }

  /// iOS info is fetched by using the iTunes lookup API, which returns a
  /// JSON document.
  Future<VersionStatus?> _getiOSStoreVersion(PackageInfo packageInfo) async {
    final id = iOSId ?? packageInfo.packageName;
    final parameters = {"bundleId": "$id"};
    if (iOSAppStoreCountry != null) {
      parameters.addAll({"country": iOSAppStoreCountry ?? "US"});
    }
    var uri = Uri.https("itunes.apple.com", "/lookup", parameters);
    final response = await http.get(uri);
    if (response.statusCode != 200) {
      debugPrint('Can\'t find an app in the App Store with the id: $id');
      return null;
    }
    final jsonObj = json.decode(response.body);
    return VersionStatus._(
      localVersion: packageInfo.version,
      storeVersion: jsonObj['results'][0]['version'],
      appStoreLink: jsonObj['results'][0]['trackViewUrl'],
      releaseNotes: jsonObj['results'][0]['releaseNotes'],
      downloads: "0",
    );
  }

  /// Android info is fetched by parsing the html of the app store page.
  Future<VersionStatus?> _getAndroidStoreVersion(PackageInfo packageInfo, String androidLiveVersion) async {
    final id = androidId ?? packageInfo.packageName;
    final uri =
        Uri.https("play.google.com", "/store/apps/details", {"id": "$id"});
    final response = await http.get(uri);
    if (response.statusCode != 200) {
      debugPrint('Can\'t find an app in the Play Store with the id: $id');
      return null;
    }
    final document = parse(response.body);

    String? storeVersion = '0.0.0';
    String? releaseNotes = "";
    String? downloads = "0";

    try {
      final additionalInfoElements = document.getElementsByClassName('hAyfc');
      if (additionalInfoElements.isNotEmpty) {
        final versionElement = additionalInfoElements.firstWhere(
              (elm) =>
          elm
              .querySelector('.BgcNfc')
              ?.text == 'Current Version',
        );
        storeVersion = versionElement
            .querySelector('.htlgb')
            ?.text;

        final sectionElements = document.getElementsByClassName('W4P4ne');
        final releaseNotesElement = sectionElements.firstWhereOrNull(
              (elm) =>
          elm
              .querySelector('.wSaTQd')
              ?.text == 'What\'s New',
        );
        releaseNotes = releaseNotesElement
            ?.querySelector('.PHBdkd')
            ?.querySelector('.DWPxHb')
            ?.text;
      } else {
        final scriptElements = document.getElementsByTagName('script');
        final infoScriptElement = scriptElements.firstWhere(
              (elm) => elm.text.contains('key: \'ds:5\''),
        );

        final param = infoScriptElement.text.substring(
            20, infoScriptElement.text.length - 2)
            .replaceAll('key:', '"key":')
            .replaceAll('hash:', '"hash":')
            .replaceAll('data:', '"data":')
            .replaceAll('sideChannel:', '"sideChannel":')
            .replaceAll('\'', '"')
            .replaceAll('owners\"', 'owners');
        final parsed = json.decode(param);
        final data = parsed['data'];

        storeVersion = data[1][2][140][0][0][0];
        releaseNotes = data[1][2][144][1][1];
        downloads = data[1][2][13][1];
      }
    }catch(_){

    }
    return VersionStatus._(
      localVersion: packageInfo.version,
      storeVersion: storeVersion.isNotNull() && storeVersion != "0.0.0" ? storeVersion! : androidLiveVersion,
      appStoreLink: uri.toString(),
      releaseNotes: releaseNotes,
      downloads: downloads ?? "0",
    );
  }

  /// Shows the user a platform-specific alert about the app update. The user
  /// can dismiss the alert or proceed to the app store.
  ///
  /// To change the appearance and behavior of the update dialog, you can
  /// optionally provide [dialogTitle], [dialogText], [updateButtonText],
  /// [dismissButtonText], and [dismissAction] parameters.
  void showUpdateDialog({
    required BuildContext context,
    required VersionStatus versionStatus,
    String dialogTitle = 'Update Available',
    String? dialogText,
    String updateButtonText = 'Update',
    bool allowDismissal = true,
    String dismissButtonText = 'Maybe Later',
    VoidCallback? dismissAction,
  }) async {
    final dialogTitleWidget = Text(dialogTitle);
    final dialogTextWidget = Text(
      dialogText ??
          'You can now update this app from ${versionStatus.localVersion} to ${versionStatus.storeVersion}',
    );

    final updateButtonTextWidget = Text(updateButtonText);
    final updateAction = () {
      _launchAppStore(versionStatus.appStoreLink);
      if (allowDismissal) {
        Navigator.of(context, rootNavigator: true).pop();
      }
    };

    List<Widget> actions = [
      Platform.isAndroid
          ? TextButton(
              child: updateButtonTextWidget,
              onPressed: updateAction,
            )
          : CupertinoDialogAction(
              child: updateButtonTextWidget,
              onPressed: updateAction,
            ),
    ];

    if (allowDismissal) {
      final dismissButtonTextWidget = Text(dismissButtonText);
      dismissAction = dismissAction ??
          () => Navigator.of(context, rootNavigator: true).pop();
      actions.add(
        Platform.isAndroid
            ? TextButton(
                child: dismissButtonTextWidget,
                onPressed: dismissAction,
              )
            : CupertinoDialogAction(
                child: dismissButtonTextWidget,
                onPressed: dismissAction,
              ),
      );
    }

    showDialog(
      context: context,
      barrierDismissible: allowDismissal,
      builder: (BuildContext context) {
        return WillPopScope(
            child: Platform.isAndroid
                ? AlertDialog(
                    title: dialogTitleWidget,
                    content: dialogTextWidget,
                    actions: actions,
                  )
                : CupertinoAlertDialog(
                    title: dialogTitleWidget,
                    content: dialogTextWidget,
                    actions: actions,
                  ),
            onWillPop: () => Future.value(allowDismissal));
      },
    );
  }

  /// Launches the Apple App Store or Google Play Store page for the app.
  void _launchAppStore(String appStoreLink) async {
    debugPrint(appStoreLink);
    if (await canLaunch(appStoreLink)) {
      await launch(appStoreLink);
    } else {
      throw 'Could not launch appStoreLink';
    }
  }
}
