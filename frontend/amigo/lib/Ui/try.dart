import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'navigation.dart';

class First extends StatefulWidget {
  const First({Key? key}) : super(key: key);

  @override
  State<First> createState() => _FirstState();
}

class _FirstState extends State<First> {
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
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Image.asset(
            'assets/fr2.jpg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          // Container with Text Fields
          Positioned(
            top: 250,
            left: 20,
            right: 20,
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color:
                    Colors.white.withOpacity(0.8), // Adjust opacity as needed
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Text(
                    "Hi Amigo!!",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.getFont(
                      "Poppins",
                      textStyle: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontWeight: FontWeight.w700,
                        fontSize: 45,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
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
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
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
                      hintText: "Password",
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Color.fromARGB(255, 0, 0, 0)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(
                            color: Color.fromARGB(255, 243, 238, 238),
                          ),
                        ),
                      ),
                    ),
                    onPressed: () async {
                      final email = _email.text;
                      final password = _password.text;
                      try {
                        final userCredentials = await FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                                email: email, password: password);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const NavigationPage(),
                          ),
                        );
                        print(userCredentials);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == "user-not-found") {
                          print("Invalid email-id");
                        } else if (e.code == "wrong-password") {
                          print("Invalid password");
                        }
                      }
                    },
                    child: const Text(
                      "Login",
                      style:
                          TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
