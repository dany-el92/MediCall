import 'dart:developer';

import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:chat_bubbles/date_chips/date_chip.dart';
import 'package:chat_bubbles/message_bars/message_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:medicall/components/bubble_message.dart';
import 'package:medicall/constants/colors.dart';
import 'package:medicall/utilities/request.dart';
import 'package:medicall/utilities/speech_service.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class AssistantView extends StatefulWidget {
  const AssistantView({super.key});

  @override
  State<AssistantView> createState() => _AssistantViewState();
}

class _AssistantViewState extends State<AssistantView> {
  final SpeechToTextSingleton _speechService = SpeechToTextSingleton();
  final _flutterTts = FlutterTts();
  final OpenAIService _openAIService = OpenAIService();
  bool _speechEnabled = false;
  bool _speechAvailable = false;
  String _recognizedWords = "";
  String? _generatedContent;
  final List<Message> _messages = [];

  @override
  void initState() {
    super.initState();
    initSpeechToText();
    initTextToSpeech();
  }

  @override
  void dispose() {
    _speechService.speechToText.cancel();
    _flutterTts.stop();
    super.dispose();
  }

  void initSpeechToText() async {
    try {
      _speechAvailable = await _speechService.initSpeechToText();
      setState(() {});
    } catch (e) {
      setState(() {
        log('Speech recognition failed: ${e.toString()}');
        _speechAvailable = false;
      });
    }
  }

  void errorListener(SpeechRecognitionError error) {
    log('Received error status: $error, listening: ${_speechService.speechToText.isListening}');
    setState(() {});
  }

  void statusListener(String status) {
    log('Received listener status: $status, listening: ${_speechService.speechToText.isListening}');
    setState(() {});
  }

  Future<void> startListening() async {
    await _speechService.speechToText.listen(
        onResult: onSpeechResult,
        cancelOnError: false,
        partialResults: true,
        listenMode: ListenMode.dictation);
    setState(() {
      _speechEnabled = true;
    });
  }

  Future<void> stopListening() async {
    _messages.add(Message(content: _recognizedWords, isSender: true));
    _generatedContent = await _openAIService.chatGPTAPI(_recognizedWords);
    _recognizedWords = "";
    await systemSpeak(_generatedContent!);
    _messages.add(Message(content: _generatedContent!, isSender: false));
    setState(() {});
    await _speechService.speechToText.stop();
  }

  void onSpeechResult(SpeechRecognitionResult result) async {
    setState(() {
      _recognizedWords = result.recognizedWords;
    });
    if (_speechEnabled && _speechService.speechToText.isNotListening) {
      _speechEnabled = false;
      await stopListening();
    }
  }

  Future<void> initTextToSpeech() async {
    await _flutterTts.setSharedInstance(true);
    _flutterTts.setLanguage('it-IT');
    _flutterTts.setSpeechRate(0.7);
    setState(() {});
  }

  Future<void> systemSpeak(String content) async {
    await _flutterTts.speak(content);
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                SingleChildScrollView(
                  reverse: true,
                  child: Column(
                    children: [
                      DateChip(
                        date: DateTime(now.year, now.month, now.day),
                      ),
                      const BubbleSpecialThree(
                          textStyle:
                              TextStyle(color: AppColors.bianco, fontSize: 16),
                          text:
                              "Ciao sono Pasqualino, l'assistente virtuale! Come posso aiutarti?",
                          color: AppColors.bluMedio,
                          tail: true,
                          isSender: false),
                      ..._messages
                          .map((message) => BubbleSpecialThree(
                              text: message.content,
                              color: message.isSender
                                  ? AppColors.bluChiaro
                                  : AppColors.bluMedio,
                              tail: true,
                              isSender: message.isSender,
                              textStyle: const TextStyle(
                                color: AppColors.bianco,
                                fontSize: 16,
                              )))
                          .toList(),
                      Visibility(
                        visible: _speechEnabled && _recognizedWords.isNotEmpty,
                        child: BubbleSpecialThree(
                            text: _recognizedWords,
                            color: AppColors.bluChiaro,
                            tail: true,
                            isSender: true,
                            textStyle: const TextStyle(
                              color: AppColors.bianco,
                              fontSize: 16,
                            )),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          MessageBar(
            onSend: (message) async {
              _messages.add(Message(content: message, isSender: true));
              setState(() {});
              _generatedContent = await _openAIService.chatGPTAPI(message);
              await systemSpeak(_generatedContent!);
              _messages
                  .add(Message(content: _generatedContent!, isSender: false));
              setState(() {});
            },
            messageBarHintText: "Messaggio...",
            sendButtonColor: AppColors.bluChiaro,
            actions: [
              IconButton(
                  onPressed: () async {
                    _speechService.speechToText.isNotListening
                        ? await startListening()
                        : await stopListening();
                  },
                  icon: Icon(
                    _speechService.speechToText.isNotListening
                        ? Icons.mic
                        : Icons.stop_rounded,
                    color: AppColors.bluChiaro,
                    size: 30,
                  ))
            ],
          ),
        ],
      ),
    );
  }
}

// Listen continuo, ma quando cambi pagina non funziona più, RIP
// -----------------------------------------------------

// import 'dart:developer';
//
// import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
// import 'package:chat_bubbles/date_chips/date_chip.dart';
// import 'package:chat_bubbles/message_bars/message_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_tts/flutter_tts.dart';
// import 'package:medicall/components/bubble_message.dart';
// import 'package:medicall/constants/colors.dart';
// import 'package:medicall/utilities/request.dart';
// import 'package:medicall/utilities/speech_service.dart';
// import 'package:speech_to_text/speech_recognition_error.dart';
// import 'package:speech_to_text/speech_recognition_result.dart';
// import 'package:speech_to_text/speech_to_text.dart';
//
// class AssistantView extends StatefulWidget {
//   const AssistantView({super.key});
//
//   @override
//   State<AssistantView> createState() => _AssistantViewState();
// }
//
// class _AssistantViewState extends State<AssistantView> {
//   final SpeechToTextSingleton _speechService = SpeechToTextSingleton();
//
//   // late SpeechToText speechToText = SpeechToText();
//   final flutterTts = FlutterTts();
//   bool speechEnabled = false;
//   bool speechAvailable = false;
//   String currentWords = "";
//   String lastWords = "";
//   final OpenAIService openAIService = OpenAIService();
//   String? generatedContent;
//   List<Message> messages = [];
//
//   @override
//   void initState() {
//     super.initState();
//     initSpeechToText();
//     initTextToSpeech();
//   }
//
//   @override
//   void dispose() {
//     _speechService.speechToText.cancel();
//     flutterTts.stop();
//     super.dispose();
//   }
//
//   void initSpeechToText() async {
//     speechAvailable = await _speechService.initSpeechToText(
//       onError: errorListener,
//       onStatus: statusListener,
//     );
//     setState(() {});
//   }
//
//   void errorListener(SpeechRecognitionError error) async {
//     debugPrint(error.errorMsg.toString());
//     if (speechEnabled) {
//       await startListening();
//     }
//   }
//
//   void statusListener(String status) async {
//     debugPrint("status $status");
//     if (status == "done" && speechEnabled) {
//       if (currentWords.isNotEmpty) {
//         setState(() {
//           lastWords += " $currentWords";
//           currentWords = "";
//           speechEnabled = false;
//         });
//       } else {
//         // wait 50 mil seconds and try again
//         await Future.delayed(const Duration(milliseconds: 50));
//       }
//       await startListening();
//     }
//   }
//
//   Future<void> startListening() async {
//     setState(() {
//       speechEnabled = false;
//     });
//     await _speechService.speechToText.stop();
//
//     await Future.delayed(const Duration(milliseconds: 50));
//     await _speechService.speechToText.listen(
//         onResult: onSpeechResult,
//         cancelOnError: false,
//         partialResults: true,
//         listenMode: ListenMode.dictation);
//     setState(() {
//       speechEnabled = true;
//     });
//   }
//
//   Future<void> stopListening() async {
//     messages.add(Message(content: lastWords, isSender: true));
//     // generatedContent = await openAIService.chatGPTAPI(lastWords);
//     lastWords = "";
//     generatedContent ??= "Non ho capito, puoi ripetere?";
//     await systemSpeak(generatedContent!);
//     messages.add(Message(content: generatedContent!, isSender: false));
//     setState(() {
//       speechEnabled = false;
//     });
//     await _speechService.speechToText.stop();
//   }
//
//   void onSpeechResult(SpeechRecognitionResult result) {
//     setState(() {
//       currentWords = result.recognizedWords;
//     });
//   }
//
//   Future<void> initTextToSpeech() async {
//     await flutterTts.setSharedInstance(true);
//     flutterTts.setLanguage('it-IT');
//     flutterTts.setSpeechRate(0.7);
//     setState(() {});
//   }
//
//   Future<void> systemSpeak(String content) async {
//     await flutterTts.speak(content);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final now = DateTime.now();
//
//     return Scaffold(
//       body: Column(
//         children: [
//           Expanded(
//             child: Stack(
//               children: [
//                 SingleChildScrollView(
//                   reverse: true,
//                   child: Column(
//                     children: [
//                       DateChip(
//                         date: DateTime(now.year, now.month, now.day),
//                       ),
//                       const BubbleSpecialThree(
//                           textStyle:
//                           TextStyle(color: AppColors.bianco, fontSize: 16),
//                           text:
//                           "Ciao sono Pasqualino, l'assistente virtuale! Come posso aiutarti?",
//                           color: AppColors.bluMedio,
//                           tail: true,
//                           isSender: false),
//                       ...messages
//                           .map((message) => BubbleSpecialThree(
//                           text: message.content,
//                           color: message.isSender
//                               ? AppColors.bluChiaro
//                               : AppColors.bluMedio,
//                           tail: true,
//                           isSender: message.isSender,
//                           textStyle: const TextStyle(
//                             color: AppColors.bianco,
//                             fontSize: 16,
//                           )))
//                           .toList(),
//                       Visibility(
//                         visible: speechEnabled && lastWords.isNotEmpty,
//                         child: BubbleSpecialThree(
//                             text: '$lastWords $currentWords',
//                             color: AppColors.bluChiaro,
//                             tail: true,
//                             isSender: true,
//                             textStyle: const TextStyle(
//                               color: AppColors.bianco,
//                               fontSize: 16,
//                             )),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(height: 15),
//           MessageBar(
//             onSend: (message) async {
//               messages.add(Message(content: message, isSender: true));
//               setState(() {});
//               // generatedContent = await openAIService.chatGPTAPI(message);
//               // generatedContent ??= "Non ho capito, puoi ripetere?";
//               // await systemSpeak(generatedContent!);
//               messages
//                   .add(Message(content: generatedContent!, isSender: false));
//               setState(() {});
//             },
//             messageBarHitText: "Messaggio...",
//             sendButtonColor: AppColors.bluChiaro,
//             actions: [
//               IconButton(
//                   onPressed: () async {
//                     _speechService.speechToText.isNotListening
//                         ? await startListening()
//                         : await stopListening();
//                   },
//                   icon: Icon(
//                     _speechService.speechToText.isNotListening
//                         ? Icons.mic
//                         : Icons.stop_rounded,
//                     color: AppColors.bluChiaro,
//                     size: 30,
//                   ))
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

//-----------------------------------------------------
