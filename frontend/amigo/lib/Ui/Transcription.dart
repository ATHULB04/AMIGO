import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class TranscriptionPage extends StatefulWidget {
  const TranscriptionPage({super.key});

  @override
  State<TranscriptionPage> createState() => _TranscriptionPageState();
}

class _TranscriptionPageState extends State<TranscriptionPage> {
  final DatabaseReference databaseReference =
      FirebaseDatabase.instance.ref().child('teacher');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(
          255, 255, 255, 255), // Set the background color to red
      body: Stack(
        children: [
          ClipPath(
            clipper: MyCustomClipper(),
            child: Container(
              color:
                  const Color(0xFF3e18fc), // Set the container color to white
            ),
          ),
          StreamBuilder(
              stream: databaseReference.onValue,
              builder: (context, snapshot) {
                return Padding(
                  padding: const EdgeInsets.only(top: 100.0),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Center(
                      child: Text(
                        snapshot.hasData
                            ? snapshot.data!.snapshot.value.toString()
                            : "no live happening",
                        style: const TextStyle(
                          fontFamily: 'poppins',
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: Color.fromARGB(255, 243, 239, 239),
                        ),
                      ),
                    ),
                  ),
                );
              }),
        ],
      ),
    );
  }
}

class MyCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 100); // Move to the bottom-left
    path.quadraticBezierTo(size.width / 2, size.height, size.width,
        size.height - 100); // Create a quadratic bezier curve
    path.lineTo(size.width, 0); // Move to the bottom-right
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
