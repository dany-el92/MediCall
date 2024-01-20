import 'dart:convert';
import 'dart:io';
import 'dart:developer';

import 'package:medicall/components/extracted_data_receipt.dart';
import 'package:medicall/utilities/receipt_processing.dart';
import 'package:medicall/utilities/show_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medicall/utilities/permission_request.dart';
import 'package:medicall/utilities/request.dart';
import 'package:medicall/views/scan_result_view.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:medicall/utilities/regex_helper.dart';

class ImagePickerService {
  ImageSource? _selectedSource;

  Future<void> printTextFromUrl(BuildContext context) async {
    XFile? selectedFile;
    if (_selectedSource == null) {
      selectedFile = await chooseImageFile(context);
    } else if (_selectedSource == ImageSource.camera) {
      selectedFile = await openSource(ImageSource.camera, context);
    } else if (_selectedSource == ImageSource.gallery) {
      selectedFile = await openSource(ImageSource.gallery, context);
    }

    final recognizedText = await scanImage(File(selectedFile!.path), context);

    log(recognizedText.text);

    final aicNumber = RegexHelper.getAicNumber(recognizedText.text);

    log(aicNumber);

    // If the aicNumber is the same as the recognized text, it means no match was found
    if (aicNumber == recognizedText.text) {
      handleAicNumberError(context);
      return;
    }

    var data = await getData('http://89.168.86.207:5000/$aicNumber');
    var decodedData = jsonDecode(data);
    //chiave del JSON del server
    var text = decodedData['url'];

    final Uri url = Uri.parse(text);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }


  void handleAicNumberError(BuildContext context) async {
    bool hasClosed = await showErrorOCRDialog(context);
    if (hasClosed) {
      await printTextFromUrl(context);
    }
  }

  void handleReceiptScanError(
      BuildContext context, List<bool> dataControl) async {
    if (!RegexHelper.checkData(dataControl)) {
      bool hasClosed = await showErrorOCRDialog(context);
      if (hasClosed) {
        // openSourceCamera(context);
        // await openSource(ImageSource.camera, context);
        await regexText(context);
      }
    }
  }

  void handleReceiptScanSuccess(
      BuildContext context, ExtractedData data) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ResultScreen(
          nome: data.nome,
          cognome: data.cognome,
          CF: data.CF,
          impegnativa: data.impegnativa,
          prescrizione: data.prescrizione,
          auth: data.auth,
          esenzione: data.esenzione,
          codice_asl: data.codiceAsl,
          data: data.data,
        ),
      ),
    );
  }

  Future<void> regexText(BuildContext context) async {
    XFile? selectedFile;

    if (_selectedSource == null) {
      selectedFile = await chooseImageFile(context);
    } else if (_selectedSource == ImageSource.camera) {
      selectedFile = await openSource(ImageSource.camera, context);
    } else if (_selectedSource == ImageSource.gallery) {
      selectedFile = await openSource(ImageSource.gallery, context);
    }

    final recognizedText = await scanImage(File(selectedFile!.path), context);

    final extractedData = processTextBlocks(recognizedText.blocks);
    if (!RegexHelper.checkData(extractedData.dataControl)) {
      handleReceiptScanError(context, extractedData.dataControl);
    } else {
      handleReceiptScanSuccess(context, extractedData);
    }
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

  Future<RecognizedText> scanImage(File file, BuildContext context) async {
    final textRecognizer = TextRecognizer();
    try {
      final inputImage = InputImage.fromFile(file);
      final recognizedText = await textRecognizer.processImage(inputImage);

      textRecognizer.close();

      return recognizedText;
    } catch (e) {
      if (!context.mounted) return Future.error(e);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('An error occurred when scanning text'),
        ),
      );
      return Future.error(e);
    }
  }

  Future<XFile?> openSource(ImageSource source, BuildContext context) async {
    final file = await pickImage(source: source, context: context);
    XFile selected = XFile(file.path);
    if (selected.path.isNotEmpty) {
      if (!context.mounted) return null;
      if (Navigator.canPop(context)) {
        Navigator.pop(context, selected);
      }
      return selected;
    } else {
      if (!context.mounted) return null;
      if (Navigator.canPop(context)) {
        Navigator.pop(context);
      }
      return null;
    }
  }

  Future<PickedFile> pickImage(
      {required ImageSource source, required BuildContext context}) async {
    final xFileSource = await ImagePicker().pickImage(source: source);
    if (xFileSource == null || xFileSource.path.isEmpty) {
      Navigator.pop(context);
      throw Exception('Nessuna immagine selezionata');
    }
    return PickedFile(xFileSource.path);
  }

  Widget bottomSheet(BuildContext context) {
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
                    _selectedSource = ImageSource.camera;
                    openSource(ImageSource.camera, context);
                  }
                },
                icon: const Icon(Icons.camera_alt),
                label: const Text('Camera'),
              ),
              TextButton.icon(
                onPressed: () async {
                  final bool galleryStatus =
                      await GetPermissions.getStoragePermission();
                  if (galleryStatus) {
                    _selectedSource = ImageSource.gallery;
                    openSource(ImageSource.gallery, context);
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