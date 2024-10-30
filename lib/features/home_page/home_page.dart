import 'package:ai_interview_prototype/api_manager/api_manager.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String answer = "your answer will display here";
  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var controller = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Gemini",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 25,
          ),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            TextFormField(
              autocorrect: true,
              validator: (value) {
                if (value!.trim().isEmpty) {
                  return "Please enter your question.";
                }
                return null;
              },
              controller: controller,
              decoration: const InputDecoration(
                hintText: "Ask Gemini",
                hintStyle: TextStyle(color: Colors.grey),
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blue,
                    width: 2,
                  ),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blue,
                    width: 2,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blue,
                    width: 2,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            FilledButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  )),
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  final question = controller.text;
                  try {
                    final response = await ApiManager.gemiRequest(question);
                    setState(() {
                      answer = response;
                    });
                  } on Exception catch (e) {
                    answer =
                        "An error occurred while asking Gemini. Please try again.";
                  } finally {
                    controller.clear();
                  }
                }
              },
              child: Text("Ask Gemini"),
            ),
SizedBox(height: 15,),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 8),
                physics:BouncingScrollPhysics(),
                child:Text(
                  answer,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                  ),
                ) ,
              
              ),
            ),



          ],
        ),
      ),
    );
  }
}
