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
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      'Profile',
                      style: TextStyle(
                          fontSize: 40,
                          color: Color.fromARGB(255, 25, 81, 235),
                          fontWeight: FontWeight.bold,
                          fontFamily: 'poppins'),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                height: 500,
                width: 500,
                decoration: BoxDecoration(
                  color: Color(0xFF3e18fc),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    // Add a FractionallySizedBox to control the size of the image
                    Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: FractionallySizedBox(
                        widthFactor:
                            0.5, // Set the width to 25% of the container
                        child: Align(
                          alignment: Alignment
                              .topCenter, // Align the image to the top center
                          child: CircleAvatar(
                            radius: 80,
                            backgroundImage: AssetImage('assets/man2.png'),
                          ),
                        ),
                      ),
                    ),
                    Padding(
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
                                fontFamily: 'poppins',
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(
                              'Class: CSA',
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                                fontFamily: 'poppins',
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              // Perform your logout logic here
                              // For example, you can clear user session and navigate to login screen
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => First()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              onPrimary: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              padding: const EdgeInsets.symmetric(
                                vertical: 20,
                                horizontal: 50,
                              ),
                            ),
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
