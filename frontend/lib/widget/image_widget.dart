import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ImageWidget extends StatelessWidget {
  final String imagePath;
  final bool excludeFromSemantics = false;
  final double? width;
  final double? height;
  final Color? color;
  final Animation<double>? opacity;
  final BlendMode? colorBlendMode;
  final BoxFit? fit;
  final AlignmentGeometry alignment;
  final ImageRepeat repeat;
  const ImageWidget(
    this.imagePath, {
    super.key,
    this.width,
    this.height,
    this.color,
    this.opacity,
    this.colorBlendMode,
    this.fit,
    this.repeat = ImageRepeat.noRepeat,
    this.alignment = Alignment.center,
  });

  @override
  Widget build(BuildContext context) {
    var isLocalVarible =
        imagePath.endsWith('.png') ||
        imagePath.endsWith('.jpg') ||
        imagePath.endsWith('.jpeg') && !imagePath.startsWith('http');
    if (isLocalVarible) {
      return Image.asset(
        imagePath,
        width: width,
        height: height,
        alignment: alignment,
        excludeFromSemantics: excludeFromSemantics,
        opacity: opacity,
        fit: fit,
        colorBlendMode: colorBlendMode,
        repeat: repeat,
      );
    } else if (imagePath.startsWith('http') || imagePath.startsWith('www')) {
      return Image.network(
        imagePath,
        width: width,
        height: height,
        alignment: alignment,
        excludeFromSemantics: excludeFromSemantics,
        opacity: opacity,
        fit: fit,
        colorBlendMode: colorBlendMode,
        repeat: repeat,
      );
    } else if (imagePath.endsWith('.svg') && !imagePath.startsWith('http')) {
      return SvgPicture.asset(
        imagePath,
        width: width,
        height: height,
        alignment: alignment,
        excludeFromSemantics: excludeFromSemantics,
        fit: fit ?? BoxFit.contain,
        color: color,
      );
    } else if (imagePath.endsWith('.svg') && imagePath.startsWith('http')) {
      return SvgPicture.network(
        imagePath,

        width: width,
        height: height,
        alignment: alignment,
        color: color,
        excludeFromSemantics: excludeFromSemantics,
        fit: fit ?? BoxFit.contain,
      );
    } else {
      return Image.file(
        File(imagePath),
        width: width,
        height: height,
        alignment: alignment,
        excludeFromSemantics: excludeFromSemantics,
        opacity: opacity,
        fit: fit,
        colorBlendMode: colorBlendMode,
        repeat: repeat,
      );
    }
  }
}
