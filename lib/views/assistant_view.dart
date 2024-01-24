import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:chat_bubbles/date_chips/date_chip.dart';
import 'package:chat_bubbles/message_bars/message_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:medicall/constants/colors.dart';
import 'package:medicall/utilities/request.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class AssistantView extends StatefulWidget {
  const AssistantView({super.key});

  @override
  State<AssistantView> createState() => _AssistantViewState();
}

class _AssistantViewState extends State<AssistantView> {
  final SpeechToText speechToText = SpeechToText();
  final flutterTts = FlutterTts();
  bool speechEnabled = false;
  bool speechAvailable = false;
  String currentWords = '';
  String lastWords = '';
  final OpenAIService openAIService = OpenAIService();
  String? generatedContent;

  @override
  void initState() {
    super.initState();
    initSpeechToText();
    initTextToSpeech();
  }

  @override
  void dispose() {
    super.dispose();
    speechToText.stop();
    flutterTts.stop();
  }

  void initSpeechToText() async {
    speechAvailable = await speechToText.initialize(
      onError: errorListener,
      onStatus: statusListener,
    );
    setState(() {});
  }

  void errorListener(SpeechRecognitionError error) {
    debugPrint(error.errorMsg.toString());
  }

  void statusListener(String status) async {
    debugPrint("status $status");
    if (status == "done" && speechEnabled) {
      setState(() {
        lastWords += "$currentWords ";
        currentWords = "";
        speechEnabled = false;
      });
      await startListening();
    }
  }

  Future<void> startListening() async {
    //await stopListening();
    await Future.delayed(const Duration(milliseconds: 50));
    await speechToText.listen(
        onResult: onSpeechResult,
        cancelOnError: false,
        partialResults: true,
        listenMode: ListenMode.dictation);
    setState(() {
      speechEnabled = true;
    });
  }

  Future<void> stopListening() async {
    generatedContent = await openAIService.chatGPTAPI(lastWords);
    generatedContent ??= "Non ho capito, puoi ripetere?";
    await systemSpeak(generatedContent!);
    setState(() {
      speechEnabled = false;
    });
    await speechToText.stop();
  }

  void onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      currentWords = result.recognizedWords;
    });
  }

  Future<void> initTextToSpeech() async {
    await flutterTts.setSharedInstance(true);
    flutterTts.setLanguage('it-IT');
    flutterTts.setSpeechRate(0.7);
    setState(() {});
  }

  Future<void> systemSpeak(String content) async {
    await flutterTts.speak(content);
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            reverse: true,
            child: Column(
              children: [
                DateChip(
                  date: DateTime(now.year, now.month, now.day),
                ),
                const BubbleSpecialThree(
                    textStyle: TextStyle(color: AppColors.bianco, fontSize: 16),
                    text:
                        "Ciao sono Pasqualino, l'assistente virtuale! Come posso aiutarti?",
                    color: AppColors.bluMedio,
                    tail: true,
                    isSender: false),
                Visibility(
                  visible: lastWords.isNotEmpty,
                  child: BubbleSpecialThree(
                      text: '$lastWords $currentWords',
                      color: AppColors.bluChiaro,
                      tail: true,
                      isSender: true,
                      textStyle: const TextStyle(
                          color: AppColors.bianco, fontSize: 16)),
                ),
                if (speechToText.isNotListening && generatedContent != null)
                  BubbleSpecialThree(
                      text: generatedContent!,
                      color: AppColors.bluChiaro,
                      tail: true,
                      isSender: false,
                      textStyle: const TextStyle(
                          color: AppColors.bianco, fontSize: 16)),
              ],
            ),
          ),
          MessageBar(
            onSend: (message) async {
              lastWords = message;
              setState(() {});
              generatedContent = await openAIService.chatGPTAPI(lastWords);
              generatedContent ??= "Non ho capito, puoi ripetere?";
              await systemSpeak(generatedContent!);
              setState(() {});
            },
            messageBarHitText: "Messaggio...",
            sendButtonColor: AppColors.bluChiaro,
            actions: [
              IconButton(
                  onPressed: () async {
                    speechToText.isNotListening
                        ? await startListening()
                        : await stopListening();
                  },
                  icon: Icon(
                    speechToText.isNotListening
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
