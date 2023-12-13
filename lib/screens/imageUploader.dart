import 'dart:html' as html;
import 'dart:typed_data';

import 'package:logger/logger.dart';
import 'package:mime_type/mime_type.dart';
import 'package:path/path.dart' as Path;
import 'package:image_picker_web/image_picker_web.dart';
import 'package:flutter/material.dart';

class ImageUploader extends StatefulWidget {
  const ImageUploader({super.key});

  @override
  State<ImageUploader> createState() => _ImageUploaderState();
}

class _ImageUploaderState extends State<ImageUploader> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [
        ElevatedButton(
            onPressed: () async {
              Image? fromPicker = await ImagePickerWeb.getImageAsWidget();
              if (fromPicker != null) {
                Logger().d(fromPicker);
              }
            },
            child: const Text('Upload Image')),
        ElevatedButton(
            onPressed: () async {
              Uint8List? bytesFromPicker =
                  await ImagePickerWeb.getImageAsBytes();
              if (bytesFromPicker != null) {
                Logger().d(bytesFromPicker);
              }
            },
            child: const Text('Upload Image')),
        ElevatedButton(
            onPressed: () async {
              html.File? imageFile =
                  (await ImagePickerWeb.getMultiImagesAsFile())?[0];
              if (imageFile != null) {
                Logger().d(imageFile);
              }
            },
            child: const Text('Upload Image')),
      ],
    ));
  }
}
