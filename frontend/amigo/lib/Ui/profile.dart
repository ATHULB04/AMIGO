import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studiesy/Ui/try.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late User _user;
  void initState() {
    super.initState();
    _user = _auth.currentUser!;
  }

  Future<void> _signOut() async {
    await _auth.signOut();
    // Redirect to the login page or any other page after logout
    // You can use Navigator.pushReplacement or other navigation methods here.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Center(
                  child: Text(
                    'Profile',
                    style: TextStyle(
                        fontSize: 30,
                        color: Color.fromARGB(255, 25, 81, 235),
                        fontWeight: FontWeight.bold,
                        fontFamily: 'poppins'),
                  ),
                ),
              ),
              Center(
                child: CircleAvatar(
                  radius: 80,
                  backgroundImage: AssetImage(
                      'assets/man2.png'), // Use `backgroundImage` for AssetImage
                ),
              ),
              Container(
                height: 500,
                width: 500,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 91, 148, 255),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 60.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          'Email: ${_user.email}',
                          style: TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                              fontFamily: 'poppins'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          'Class: 7 B',
                          style: TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                              fontFamily: 'poppins'),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Perform your logout logic here
                          // For example, you can clear user session and navigate to login screen
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) => First()));
                        },
                        style: ElevatedButton.styleFrom(
                            primary: Colors
                                .white, // Set the background color to white
                            onPrimary:
                                Colors.black, // Set the text color to black
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 50)),
                        child: Text(
                          'Logout',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
