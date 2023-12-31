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

  /// File path: assets/audio/fire_lit_up.mp3
  String get fireLitUp => 'assets/audio/fire_lit_up.mp3';

  /// File path: assets/audio/fire_sound.mp3
  String get fireSound => 'assets/audio/fire_sound.mp3';

  /// File path: assets/audio/flint.mp3
  String get flint => 'assets/audio/flint.mp3';

  /// File path: assets/audio/snow_storm.mp3
  String get snowStorm => 'assets/audio/snow_storm.mp3';

  /// File path: assets/audio/tree_shaking.mp3
  String get treeShaking => 'assets/audio/tree_shaking.mp3';

  /// List of all assets
  List<String> get values =>
      [background, effect, fireLitUp, fireSound, flint, snowStorm, treeShaking];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/calendar.png
  AssetGenImage get calendar =>
      const AssetGenImage('assets/images/calendar.png');

  /// File path: assets/images/fire_lit.png
  AssetGenImage get fireLit =>
      const AssetGenImage('assets/images/fire_lit.png');

  /// File path: assets/images/fire_unlit.png
  AssetGenImage get fireUnlit =>
      const AssetGenImage('assets/images/fire_unlit.png');

  /// File path: assets/images/log.png
  AssetGenImage get log => const AssetGenImage('assets/images/log.png');

  /// File path: assets/images/player_character.png
  AssetGenImage get playerCharacter =>
      const AssetGenImage('assets/images/player_character.png');

  /// File path: assets/images/q_hint.png
  AssetGenImage get qHint => const AssetGenImage('assets/images/q_hint.png');

  /// File path: assets/images/sign.png
  AssetGenImage get sign => const AssetGenImage('assets/images/sign.png');

  /// File path: assets/images/space_hint.png
  AssetGenImage get spaceHint =>
      const AssetGenImage('assets/images/space_hint.png');

  /// File path: assets/images/title.jpg
  AssetGenImage get title => const AssetGenImage('assets/images/title.jpg');

  /// File path: assets/images/tree.png
  AssetGenImage get tree => const AssetGenImage('assets/images/tree.png');

  /// File path: assets/images/winter_village.png
  AssetGenImage get winterVillage =>
      const AssetGenImage('assets/images/winter_village.png');

  /// List of all assets
  List<AssetGenImage> get values => [
        calendar,
        fireLit,
        fireUnlit,
        log,
        playerCharacter,
        qHint,
        sign,
        spaceHint,
        title,
        tree,
        winterVillage
      ];
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
