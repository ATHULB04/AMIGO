import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'navigation.dart';
// import 'package:video_player/video_player.dart';

class First extends StatefulWidget {
  const First({Key? key}) : super(key: key);

  @override
  State<First> createState() => _FirstState();
}

class _FirstState extends State<First> {
  // late final VideoPlayerController controller;
  bool isLoaded = true;
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose(); // TODO: implement
    // pose
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 238, 218, 255),
      body: SingleChildScrollView(
        child: Container(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: Stack(
                children: [
                  Image.asset(
                    'assets/first.jpg',
                  ),
                ],
              ),
            ),
            Container(
                width: 400,
                height: 355,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
                  borderRadius:
                      BorderRadius.circular(20), // Adjust the radius as needed
                ),
                child: Center(
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 20),
                      child: Text(
                        " Hi Amigo!!",
                        textAlign: TextAlign.left,
                        style: GoogleFonts.getFont(
                          "Poppins",
                          textStyle: const TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontWeight: FontWeight.w700,
                            fontSize: 45,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 350,
                      child: TextField(
                          cursorColor: Color(0xFFea4c89),
                          cursorWidth: 5,
                          controller: _email,
                          keyboardType: TextInputType.emailAddress,
                          enableSuggestions: false,
                          autocorrect: false,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            prefixIcon: Icon(Icons.email_outlined),
                            hintText: "Email",
                          )),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: 350,
                      child: TextField(
                          cursorColor: Color(0xFFea4c89),
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,
                          controller: _password,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              prefixIcon: Icon(Icons.password_outlined),
                              hintText: "password")),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: SizedBox(
                        width: 350,
                        height: 60,
                        child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Color.fromARGB(255, 0, 0, 0)),
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(20),
                                            bottomLeft: Radius.circular(20),
                                            bottomRight: Radius.circular(20)),
                                        side: BorderSide(
                                            color: Color.fromARGB(
                                                255, 243, 238, 238))))),
                            onPressed: () async {
                              final email = _email.text;
                              final password = _password.text;
                              try {
                                final userCredentials = await FirebaseAuth
                                    .instance
                                    .signInWithEmailAndPassword(
                                        email: email, password: password);
                                // ignore: use_build_context_synchronously
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const NavigationPage()),
                                );
                                print(userCredentials);
                              } on FirebaseAuthException catch (e) {
                                if (e.code == "user-not-found") {
                                  print("Invalid email-id ");
                                } else if (e.code == "wrong-password") {
                                  print("Invalid password");
                                }
                              }
                            },
                            child: const Text("Login",
                                style:
                                    TextStyle(color: Color.fromARGB(255, 255, 255, 255)))),
                      ),
                    ),
                  ]),
                )),
          ]),
        ),
      ),
    );
  }
}
