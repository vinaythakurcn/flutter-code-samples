import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:well_being_app/providers/google_ads.state.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AppAds extends StatefulWidget {
  const AppAds({Key? key}) : super(key: key);

  @override
  State<AppAds> createState() => _AppAdsState();
}

class _AppAdsState extends State<AppAds> {
  BannerAd? bannerAd;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final adState = Provider.of<GoogleAdsState>(context, listen: false);
    adState.initialization.then((value) {
      setState(() {
        bannerAd = BannerAd(
          adUnitId: adState.bannerAdUnitId,
          size: AdSize.banner,
          listener: adState.adListener,
          request: const AdRequest(),
        )..load();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return (bannerAd != null)
        ? SizedBox(
            child: AdWidget(ad: bannerAd!),
            height: 48,
          )
        : Container();
  }
}
