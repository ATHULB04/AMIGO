import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AudioScreen extends StatefulWidget {
  const AudioScreen({super.key});

  @override
  State<AudioScreen> createState() => _AudioScreenState();
}

class _AudioScreenState extends State<AudioScreen> {
  AudioPlayer player = AudioPlayer();

  @override
  void initState() {
    super.initState();
  }

  bool isPlaying = false;
  bool isLoading = false;

  void togglePlayPause() {
    setState(() {
      isPlaying = !isPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFBE03FD),
      body: SafeArea(
        child: Column(
          children: [
            const Center(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  'Press Button to hear Audio of the Summary',
                  style: TextStyle(
                    fontFamily: 'poppins',
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Color.fromARGB(255, 243, 239, 239),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 250.0),
              child: ElevatedButton(
                onPressed: () {
                  togglePlayPause();
                  if (isPlaying) {
                    playMusic(
                        "https://firebasestorage.googleapis.com/v0/b/studiesy.appspot.com/o/test%2Fwelcome.mp3?alt=media&token=5f1c9dfa-72f2-4721-9dff-c4c2d468fa2c&_gl=1*gnzbty*_ga*MTYxNTI4NTkyMy4xNjc4OTUxMzcy*_ga_CW55HF8NVT*MTY5NTk5NTQ3My4yNS4x.LjE2OTU5OTU4OTUuNTcuMC4w");
                  } else {
                    player.pause();
                  }
                },
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(16.0),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    if (isLoading)
                      CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      )
                    else if (!isLoading && isPlaying)
                      Icon(
                        Icons.pause,
                        size: 50.0,
                      )
                    else
                      Icon(
                        Icons.play_arrow,
                        size: 50.0,
                      ),
                  ],
                ),
              ),
            ),
            if (isLoading)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  'Please wait, your audio is loading',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> playMusic(String url) async {
    setState(() {
      isLoading = true; // Set loading to true while loading the audio
    });
    await player.play(UrlSource(url));
    setState(() {
      isLoading = false; // Set loading to false after loading the audio
    });
  }
}
