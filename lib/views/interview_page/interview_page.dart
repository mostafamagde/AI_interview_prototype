import 'dart:io';
import 'package:ai_interview_prototype/core/managers/models_manager.dart';
import 'package:ai_interview_prototype/core/managers/player_manager.dart';
import 'package:ai_interview_prototype/core/managers/recorder_manager.dart';
import 'package:ai_interview_prototype/core/routes_manager/routes_names.dart';
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
  late bool lastQuestion;
  late String questionVoice;

  @override
  void initState() {
    question = "";
    isLoading = true;
    lastQuestion = false;
    score = 0;
    totalScore = 0;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (!lastQuestion) {
      final JobModel job = ModalRoute.of(context)!.settings.arguments as JobModel;
      recorderManager = RecorderManager("audio.wav", Codec.pcm16WAV);
      modelsManager = const ModelsManager("10732383543")
        ..textToText("""Job title: ${job.jobTitle}
Job Description: ${job.jobDescription}""").then(
          (value) async {
            question = await modelsManager.textToText("next");
            questionVoice = await modelsManager.textToVoice(question);
            await PlayerManager(questionVoice, Codec.mp3).startPlayAudio();
            isLoading = false;
            setState(() {});
          },
        );
    }

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
        body: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text(
                            "Total Score: $totalScore",
                            style: const TextStyle(fontSize: 18),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Last Question Score: ${score.toString()}",
                            style: const TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        question,
                        style: const TextStyle(fontSize: 24),
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
                            if (context.mounted) {
                              if (lastQuestion) {
                                Navigator.pushReplacementNamed(context, RoutesNames.totalScorePage, arguments: [totalScore, score]);
                              } else {
                                question = await modelsManager.textToText("next");
                                questionVoice = await modelsManager.textToVoice(question);
                                await PlayerManager(questionVoice, Codec.mp3).startPlayAudio();
                                if (question.startsWith("Final:")) {
                                  lastQuestion = true;
                                }
                              }
                            }

                            isLoading = false;
                            setState(() {});
                            await clear([
                              path!,
                              questionVoice,
                            ]);
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> clear(final List<String> filesToDelete) async {
    for (final String file in filesToDelete) {
      try {
        await File(file).delete();
      } catch (_) {}
    }
    path = null;
  }
}
