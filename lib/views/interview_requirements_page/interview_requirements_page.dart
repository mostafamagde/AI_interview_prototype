import 'package:ai_interview_prototype/core/routes_manager/routes_names.dart';
import 'package:ai_interview_prototype/models/job_model.dart';
import 'package:ai_interview_prototype/views/custom_widgets/custom_button.dart';
import 'package:ai_interview_prototype/views/custom_widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class InterviewRequirementsPage extends StatefulWidget {
  const InterviewRequirementsPage({super.key});

  @override
  State<InterviewRequirementsPage> createState() => _InterviewRequirementsPageState();
}

class _InterviewRequirementsPageState extends State<InterviewRequirementsPage> {
  late final TextEditingController jobTitleController;
  late final TextEditingController jobDescriptionController;
  late final GlobalKey<FormState> formKey;
  late AutovalidateMode autovalidateMode;

  @override
  void initState() {
    jobTitleController = TextEditingController();
    jobDescriptionController = TextEditingController();
    formKey = GlobalKey<FormState>();
    autovalidateMode = AutovalidateMode.disabled;
    jobTitleController.text = "Flutter Developer.";
    jobDescriptionController.text = """We are looking for an experienced Flutter Developer who will join our talented software team that works on mission-critical applications.
Your duties will include managing Flutter (Android, iOS) application development while providing expertise in the full software development lifecycle, from concept and design to testing.
You should have good experience in building high-performing, scalable, enterprise-grade applications and be able to write clean code and ensure your programs run properly.
We also expect you to be passionate about building software and perform well working in a team, along with developers, engineers, and web designers.""";

    super.initState();
  }

  @override
  void dispose() {
    jobTitleController.dispose();
    jobDescriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        autovalidateMode: autovalidateMode,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomTextField(
                  hineText: 'Job Title',
                  controller: jobTitleController,
                  onSaved: (value) {
                    jobTitleController.text = value!;
                  },
                ),
                const SizedBox(height: 15),
                CustomTextField(
                  hineText: 'Job Description',
                  controller: jobDescriptionController,
                  maxLines: 10,
                  minLines: 4,
                  onSaved: (value) {
                    jobDescriptionController.text = value!;
                  },
                ),
                const SizedBox(height: 30),
                CustomButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      final JobModel job = JobModel(
                        jobTitle: jobTitleController.text,
                        jobDescription: jobDescriptionController.text,
                      );
                      Navigator.pushNamed(context, RoutesNames.interviewPage, arguments: job);
                    } else {
                      autovalidateMode = AutovalidateMode.always;
                      setState(() {});
                    }
                  },
                  text: 'Go to interview',
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
