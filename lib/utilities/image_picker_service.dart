import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medicall/utilities/permission_request.dart';
import 'package:medicall/views/scan_result_view.dart';

class ImagePickerService {
  Future<PickedFile> pickImage({required ImageSource source}) async {
    final xFileSource = await ImagePicker().pickImage(source: source);
    return PickedFile(xFileSource!.path);
  }

  Future<XFile?> chooseImageFile(BuildContext context) async {
    try {
      return await showModalBottomSheet(
          context: context, builder: (builder) => bottomSheet(context));
    } catch (e) {
      print('errore');
    }
    return null;
  }

  Future<void> scanImage(File file, BuildContext context) async {
    final textRecognizer = TextRecognizer();
    final navigator = Navigator.of(context);
    try {
      final inputImage = InputImage.fromFile(file);
      final recognizerText = await textRecognizer.processImage(inputImage);
      //Inserisce in una variable text il testo riconosciuto
      //String text = recognizerText.text;
      textRecognizer.close();

      await navigator.push(
        MaterialPageRoute(
          builder: (context) => ResultScreen(text: recognizerText.text),
        ),
      );
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('An error occurred when scanning text'),
        ),
      );
    }
  }

  Widget bottomSheet(BuildContext context) {
    Future<void> openSource(ImageSource source) async {
      final file = await pickImage(source: source);
      XFile selected = XFile(file.path);
      if (selected.path.isNotEmpty) {
        if (!context.mounted) return;
        Navigator.pop(context, selected);
        await scanImage(File(selected.path), context);
      } else {
        if (!context.mounted) return;
        Navigator.pop(context, XFile(''));
      }
    }

    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          const Text(
            'Scegli immagine',
            style: TextStyle(
              fontSize: 14,
              letterSpacing: 0.02,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Divider(),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton.icon(
                onPressed: () async {
                  final bool cameraStatus =
                      await GetPermissions.getCameraPermission();
                  if (cameraStatus) {
                    openSource(ImageSource.camera);
                  }
                },
                icon: const Icon(Icons.camera),
                label: const Text('Camera'),
              ),
              TextButton.icon(
                onPressed: () async {
                  final bool galleryStatus =
                      await GetPermissions.getStoragePermission();
                  if (galleryStatus) {
                    openSource(ImageSource.gallery);
                  }
                },
                icon: const Icon(Icons.image),
                label: const Text('Galleria'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
