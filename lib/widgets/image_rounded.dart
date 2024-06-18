import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageRounded extends StatelessWidget {
  const ImageRounded({super.key, required this.image, this.width, this.height, this.borderRadius});

  final XFile image;
  final double? width;
  final double? height;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius ?? 12.0),
      child: kIsWeb
          ? Image.network(
              image.path,
              width: width ?? 200.0,
              height: height ?? 100.0,
              fit: BoxFit.cover,
            )
          : Image.file(
              File(image.path),
              width: width ?? 200.0,
              height: height ?? 100.0,
              fit: BoxFit.cover,
            ),
    );
  }
}
