/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsAudioGen {
  const $AssetsAudioGen();

  /// File path: assets/audio/background.mp3
  String get background => 'assets/audio/background.mp3';

  /// File path: assets/audio/effect.mp3
  String get effect => 'assets/audio/effect.mp3';

  /// List of all assets
  List<String> get values => [background, effect];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/fire_lit.png
  AssetGenImage get fireLit =>
      const AssetGenImage('assets/images/fire_lit.png');

  /// File path: assets/images/log.png
  AssetGenImage get log => const AssetGenImage('assets/images/log.png');

  /// File path: assets/images/tree.png
  AssetGenImage get tree => const AssetGenImage('assets/images/tree.png');

  /// File path: assets/images/unicorn_animation.png
  AssetGenImage get unicornAnimation =>
      const AssetGenImage('assets/images/unicorn_animation.png');

  /// List of all assets
  List<AssetGenImage> get values => [fireLit, log, tree, unicornAnimation];
}

class $AssetsLicensesGen {
  const $AssetsLicensesGen();

  $AssetsLicensesPoppinsGen get poppins => const $AssetsLicensesPoppinsGen();
}

class $AssetsLicensesPoppinsGen {
  const $AssetsLicensesPoppinsGen();

  /// File path: assets/licenses/poppins/OFL.txt
  String get ofl => 'assets/licenses/poppins/OFL.txt';

  /// List of all assets
  List<String> get values => [ofl];
}

class Assets {
  Assets._();

  static const $AssetsAudioGen audio = $AssetsAudioGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsLicensesGen licenses = $AssetsLicensesGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
