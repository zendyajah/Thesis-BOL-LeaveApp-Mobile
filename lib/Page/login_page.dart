import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../repository.dart';
import 'main_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool pShow = true;
  Repository repo = Repository();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void pressEye() {
    setState(() {
      pShow = !pShow;
    });
  }

  @override
  Widget build(BuildContext context) {
    String username = _usernameController.text.trim();
    String passw = _passwordController.text.trim();
    if (username == null || passw == null) {
      username = "";
      passw = "";
    }
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 100),
        child: Form(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 200,
              height: 200,
              child: Image(image: AssetImage("images/LOGO.png")),
            ),
            TextFormField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: "User Id",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.assignment_ind),
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _passwordController,
              obscureText: pShow,
              decoration: InputDecoration(
                  labelText: "Password",
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    onPressed: pressEye,
                    icon: const Icon(Icons.remove_red_eye),
                  )),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  String response = await repo.postLogin(
                      _usernameController.text.trim(),
                      _passwordController.text.trim());

                  // ignore: unnecessary_null_comparison
                  if (response == null) {
                    // ignore: use_build_context_synchronously
                    MotionToast.warning(
                      title: const Text("Warning"),
                      description: const Text("Login Failed"),
                      position: MotionToastPosition.center,
                    ).show(context);
                  }
                  // ignore: unrelated_type_equality_checks
                  if (response != 'LoginFailure') {
                    String jsonString = response;
                    Map<String, dynamic> jsonMap = json.decode(jsonString);
                    String theId = jsonMap['id'].toString(); //id
                    String userRoleId = jsonMap['userRoleId'];
                    String remainingDaysOff =
                        jsonMap['remainingDaysOff'].toString();

                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    await prefs.setString('id', theId);
                    await prefs.setString('userRoleId', userRoleId);
                    await prefs.setString(
                        'username', _usernameController.text.trim());
                    await prefs.setString('remainingDaysOff', remainingDaysOff);

                    // Navigator.of(context).popAndPushNamed('/mainpage',
                    //     arguments: [theId, userRoleId, "Admin"]);
                    // ignore: use_build_context_synchronously
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const MainPage();
                    }));
                  } else {
                    // ignore: use_build_context_synchronously
                    MotionToast.warning(
                      title: const Text("Warning"),
                      description: const Text("Login Failed"),
                      position: MotionToastPosition.center,
                    ).show(context);
                  }
                },
                child: const Text("LOGIN"),
              ),
            ),
          ],
        )),
      ),
    ));
  }
}
