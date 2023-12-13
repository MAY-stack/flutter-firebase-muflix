import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:logger/logger.dart';

import 'package:image_picker_web/image_picker_web.dart';
import 'dart:html' as html;

// 파일 접근 권한 확인 및 요청
class TestScreen extends StatelessWidget {
  const TestScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Screen'),
      ),
      body: const Center(
        child: Column(
          children: [
            Text('Test Screen'),
            FileUploadButton(),
          ],
        ),
      ),
    );
  }
}

class FileUploadButton extends StatelessWidget {
  const FileUploadButton({super.key});

  @override
  Widget build(BuildContext context) {
    final storageRef = FirebaseStorage.instance.ref();
    final bao2Ref = storageRef.child("images/bao2.jpg");
    Logger()
        .i('bao2Ref.fullPath: ${bao2Ref.fullPath}, bao2Ref: ${bao2Ref.name}');

    return Column(
      children: [
        // Image.memory(
        //   // imageUrl.toString() as Uint8List,
        //   height: 200,
        // ),
        ElevatedButton(
            onPressed: () async {
              Uint8List? bytesFromPicker =
                  await ImagePickerWeb.getImageAsBytes();
              if (bytesFromPicker != null) {
                Logger().d(bytesFromPicker.isNotEmpty);
                try {
                  await bao2Ref.putData(
                    bytesFromPicker,
                    SettableMetadata(
                      contentType: "image/jpeg",
                    ),
                  );
                  Logger().i('Upload Success');
                } catch (e) {
                  Logger().e(e);
                }
              }
            },
            child: const Text('Upload Image')),
        ElevatedButton(
          child: const Text('UPLOAD FILE'),
          onPressed: () async {
            var picked = await FilePicker.platform.pickFiles();

            if (picked != null) {
              Logger().i(picked.files.first.name);
            }
          },
        ),
      ],
    );
  }
}

// class WebFilePicker {
//   html.File _cloudFile;
//   var _fileBytes;
//  Image _imageWidget;
 
//  Future<void> getMultipleImageInfos() async {
//     var mediaData = await ImagePickerWeb.getImageInfo;
//     String mimeType = mime(Path.basename(mediaData.fileName));
//     html.File mediaFile =
//         html.File(mediaData.data, mediaData.fileName, {'type': mimeType});

//     setState(() {
//       _cloudFile = mediaFile;
//       _fileBytes = mediaData.data;
//       _imageWidget = Image.memory(mediaData.data);
//     });
//   }

