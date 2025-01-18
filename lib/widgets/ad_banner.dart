import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'dart:io';

class AdBanner extends StatefulWidget {
  const AdBanner({Key? key}) : super(key: key);

  @override
  State<AdBanner> createState() => _AdBannerState();
}

class _AdBannerState extends State<AdBanner> {
  BannerAd? _bannerAd;
  bool _isLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadAd();
  }

  void _loadAd() {
    // Gerçek reklam ID'si
    final adUnitId = 'ca-app-pub-7310994392910958/8503221296';
    
    debugPrint('Loading ad with ID: $adUnitId');
    
    _bannerAd = BannerAd(
      adUnitId: adUnitId,
      size: AdSize.banner,
      request: const AdRequest(
        keywords: ['flutter', 'visa', 'letter', 'motivation'],
        contentUrl: 'https://flutter.dev',
        httpTimeoutMillis: 30000, // Timeout süresini artır
      ),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          debugPrint('Ad loaded successfully');
          setState(() {
            _isLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          debugPrint('BannerAd failed to load: $error');
          debugPrint('Error code: ${error.code}');
          debugPrint('Error domain: ${error.domain}');
          debugPrint('Error message: ${error.message}');
          debugPrint('Response info: ${error.responseInfo?.toString()}');
          debugPrint('Mediation adapter class name: ${error.responseInfo?.mediationAdapterClassName}');
          ad.dispose();
          setState(() {
            _isLoaded = false;
          });
        },
        onAdOpened: (ad) => debugPrint('Ad opened'),
        onAdClosed: (ad) => debugPrint('Ad closed'),
        onAdImpression: (ad) => debugPrint('Ad impression recorded'),
      ),
    );

    debugPrint('Attempting to load ad...');
    _bannerAd?.load();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    _bannerAd = null;
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_bannerAd == null) {
      _loadAd();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isLoaded || _bannerAd == null) {
      return const SizedBox.shrink();
    }
    
    return SafeArea(
      child: Container(
        alignment: Alignment.bottomCenter,
        width: _bannerAd!.size.width.toDouble(),
        height: _bannerAd!.size.height.toDouble(),
        child: AdWidget(ad: _bannerAd!),
      ),
    );
  }
}
