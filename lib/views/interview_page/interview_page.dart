import 'dart:io';
import 'package:ai_interview_prototype/core/managers/models_manager.dart';
import 'package:ai_interview_prototype/core/managers/recorder_manager.dart';
import 'package:ai_interview_prototype/views/custom_widgets/mic_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class InterviewPage extends StatefulWidget {
  const InterviewPage({super.key});

  @override
  State<InterviewPage> createState() => _InterviewPageState();
}

class _InterviewPageState extends State<InterviewPage> {
  late final RecorderManager recorderManager;
  late final ModelsManager modelsManager;
  late bool isLoading;
  late String text;
  String? path;

  @override
  void initState() {
    recorderManager = RecorderManager("audio.wav", Codec.pcm16WAV);
    modelsManager = const ModelsManager();
    isLoading = false;
    text = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('GP AI Interview'),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(text, style: const TextStyle(fontSize: 28)),
                GlowAvatarIcon(
                  icon: Icons.mic,
                  onPressed: (enabled) async {
                    // if (enabled) {
                    //   path = await recorderManager.startRecording();
                    // } else if (!enabled && path != null) {
                    //   path = await recorderManager.stopRecording();
                    //   isLoading = true;
                    //   setState(() {});
                    //   // String audioPath = await modelsManager.textToVoice("player manager");
                    //   String res = await modelsManager.voiceToText(path!);
                    //   isLoading = false;
                    //   setState(() {});
                    //   // await PlayerManager(audioPath, Codec.mp3).startPlayAudio();
                    //   await clear([
                    //     path!,
                    //     // audioPath,
                    //   ]);
                    // }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> clear(final List<String> filesToDelete) async {
    for (final String file in filesToDelete) {
      await File(file).delete();
    }
    path = null;
  }
}
