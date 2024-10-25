import 'package:animated_custom_dropdown/custom_dropdown.dart';

import 'package:flutter/material.dart';

import '../../core/routes_manager/routes_names.dart';
import '../../models/job_description.dart';



class HomePage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    String? title = "";
    String? role = "";
    int? exp = 0;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF5D9CEC),
        centerTitle: true,
        title: Text(
          "Home",
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
          ),
        ),
      ),
      body: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 40,
            ),
            CustomDropdown(
              hintText: "select position",
              validateOnChange: true,
              validator: (value) => value == null ? "Must not be null" : null,
              items: [
                "backend",
                "front",
                "security",
                "ui",
              ],
              onChanged: (val) {
                role = val;
              },
              decoration: CustomDropdownDecoration(
                closedBorder: Border.all(
                  width: 2,
                  color: Color(0xFF5D9CEC),
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            CustomDropdown(
              hintText: "select title ",
              validateOnChange: true,
              validator: (value) => value == null ? "Must not be null" : null,
              items: [
                "fresh",
                "senior",
                "junior",
              ],
              onChanged: (val) {
                title = val;
              },
              decoration: CustomDropdownDecoration(
                closedBorder: Border.all(
                  width: 2,
                  color: Color(0xFF5D9CEC),
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            CustomDropdown(
              hintText: "select experience ",
              validateOnChange: true,
              validator: (value) => value == null ? "Must not be null" : null,
              items: [
                1,
                2,
                3,
                4,
                5,
                6,
                7,
                8,
                9,
                10,
              ],
              onChanged: (val) {
                exp = val;
              },
              decoration: CustomDropdownDecoration(
                closedBorder: Border.all(
                  width: 2,
                  color: Color(0xFF5D9CEC),
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  Navigator.pushNamed(
                    context,
                    RoutesNames.speechView,
                    arguments: JobDescription(
                      title: title!,
                      experience: exp!,
                      role: role!,
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF5D9CEC),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                "Next",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
