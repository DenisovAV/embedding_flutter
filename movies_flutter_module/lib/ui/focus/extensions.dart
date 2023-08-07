import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movies_flutter_module/ui/widgets/platform.dart';

const kTvSize = Size(1920, 1080);

final width = WidgetsBinding.instance.window.physicalSize.width;
final pixelRatio = WidgetsBinding.instance.window.devicePixelRatio;
final isScaled = MyPlatform.isAndroidTV && kTvSize.width * pixelRatio != width;

extension SubmitAction on RawKeyEvent {
  bool get hasSubmitIntent =>
      this is RawKeyDownEvent &&
      (logicalKey == LogicalKeyboardKey.select || logicalKey == LogicalKeyboardKey.enter);
}

extension ScreenSizeExtension on BuildContext {
  MediaQueryData get _mediaQueryData => MediaQuery.of(this);
  Size get screenSize => isScaled ? kTvSize : _mediaQueryData.size;
}
