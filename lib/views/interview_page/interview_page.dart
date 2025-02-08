import 'dart:io';
import 'package:ai_interview_prototype/core/managers/models_manager.dart';
import 'package:ai_interview_prototype/core/managers/recorder_manager.dart';
import 'package:ai_interview_prototype/models/job_model.dart';
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
  String? path;
  late String question;
  late double score;
  late double totalScore;
  late bool startInterview;

  @override
  void initState() {
    question = "";
    isLoading = true;
    score = 0;
    totalScore = 0;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    final JobModel job = ModalRoute.of(context)!.settings.arguments as JobModel;
    recorderManager = RecorderManager("audio.wav", Codec.pcm16WAV);
    modelsManager = const ModelsManager("8787189845")
      ..textToText("""Job title: ${job.jobTitle}
Job Description: ${job.jobDescription}""").then(
        (value) async {
          question = await modelsManager.textToText("next");
          isLoading = false;
          setState(() {});
        },
      );

    super.didChangeDependencies();
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
                Text(
                  "Total Score: $totalScore",
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 10),
                Text(
                  question,
                  style: const TextStyle(fontSize: 24),
                ),
                const SizedBox(height: 10),
                Text(
                  score.toString(),
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 10),
                GlowAvatarIcon(
                  icon: Icons.mic,
                  onPressed: (enabled) async {
                    if (enabled) {
                      path = await recorderManager.startRecording();
                    } else if (!enabled && path != null) {
                      path = await recorderManager.stopRecording();
                      isLoading = true;
                      setState(() {});
                      String res = await modelsManager.voiceToText(path!);
                      score = double.parse(await modelsManager.textToText(res));
                      totalScore += score;
                      setState(() {});
                      question = await modelsManager.textToText("next");
                      isLoading = false;
                      setState(() {});
                      await clear([
                        path!,
                        // audioPath,
                      ]);
                    }
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
