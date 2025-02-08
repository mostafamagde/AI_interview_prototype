import 'package:ai_interview_prototype/core/routes_manager/routes_names.dart';
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
                  onSaved: (value) {
                    jobDescriptionController.text = value!;
                  },
                ),
                const SizedBox(height: 30),
                CustomButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      Navigator.pushNamed(context, RoutesNames.interviewPage);
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
