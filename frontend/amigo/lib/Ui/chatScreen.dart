import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'package:studiesy/Ui/audio.dart';

class ConversationScreen extends StatefulWidget {
  const ConversationScreen(
      {super.key,
      required this.chatRoomId,
      required this.userName,
      required this.subject});
  final String chatRoomId;
  final String userName;
  final String subject;

  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  TextEditingController messageController = TextEditingController();
  Future<Album>? _futureAlbum;

  FutureBuilder<Album> buildFutureBuilder(int index) {
    return FutureBuilder<Album>(
      future: _futureAlbum,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          student[index] = snapshot.data!.answer;

          return Column(
            children: [Expanded(child: chatMessageList()), MessageBar()],
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget buildPastBuilder() {
    return Container(
      decoration: const BoxDecoration(),
      child: Column(
        children: [Expanded(child: chatMessageList()), MessageBar()],
      ),
    );
  }

  var student = {};
  int index = 0;
  bool sended = false;

  Widget chatMessageList() {
    return Stack(children: [
      Center(
        child: Image.network(
          'https://img.freepik.com/free-vector/kids-studying-from-home-concept-illustration_114360-2153.jpg?w=740&t=st=1695441819~exp=1695442419~hmac=1c1f2c7698bfb93fad7a4f266aedc5cbee5f799f7d71b0c9ec1df5541c970b02',
          opacity: const AlwaysStoppedAnimation(.5),
        ),
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                reverse: true,
                itemCount: student.length,
                itemBuilder: (BuildContext context, int index) {
                  int lastIndex = (student.length - index);
                  if (index.isEven) {
                    sended = false;
                  } else {
                    sended = true;
                  }
                  return MessageTiles(
                      message: student[index], sendbyme: sended);
                }),
          ),
        ],
      ),
    ]);
  }

  sendMessage() {
    if (messageController.text.isNotEmpty) {
      setState(() {
        student[index + 1] = messageController.text;
        _futureAlbum = createAlbum(messageController.text, widget.subject);
        messageController.text = "";
        index + 1;
      });
    }
  }

  Widget MessageBar() {
    return Container(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(top: 5, bottom: 12, left: 12, right: 12),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(80),
            color: const Color(0xFF3e18fc),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Row(
            children: [
              Expanded(
                  child: TextField(
                controller: messageController,
                style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 20,
                )),
                decoration: InputDecoration(
                    hintText: "Message...",
                    hintStyle: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                      color: Color.fromARGB(150, 254, 254, 254),
                      fontSize: 18,
                    )),
                    border: InputBorder.none),
              )),
              GestureDetector(
                onTap: () {
                  sendMessage();
                },
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white),
                  child: const Center(
                    child: Icon(
                      Icons.send,
                      color: Color.fromARGB(255, 7, 7, 7),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFffffff),
      appBar: AppBar(
        backgroundColor: Color(0xFF3e18fc),
        title: Text(
          "Amigo",
          style: GoogleFonts.poppins(
              textStyle: const TextStyle(
            color: Color.fromARGB(255, 248, 248, 248),
            fontSize: 22,
            fontWeight: FontWeight.w500,
          )),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AudioScreen()),
              );
            },
            icon: const Icon(Icons.speaker),
          ),
        ],
        shadowColor: const Color.fromARGB(255, 223, 147, 236),
        toolbarHeight: 70,
      ),
      body: (_futureAlbum == null)
          ? buildPastBuilder()
          : buildFutureBuilder(index),
    );
  }
}

Future<Album> createAlbum(String question, String subject) async {
  final response = await http.post(
    Uri.parse('https://web-production-4ed5.up.railway.app/bot'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      "question": question,
      "subject": subject,
    }),
  );

  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    print(jsonDecode(response.body));
    return Album.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create album');
  }
}

class Album {
  final String answer;

  const Album({required this.answer});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      answer: json['result'],
    );
  }
}

class MessageTiles extends StatelessWidget {
  const MessageTiles(
      {super.key, required this.message, required this.sendbyme});
  final String message;
  final bool sendbyme;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          sendbyme ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          child: Container(
              constraints: const BoxConstraints(maxWidth: 200),
              decoration: BoxDecoration(
                gradient: sendbyme
                    ? const LinearGradient(
                        colors: [Color(0xFF19B7FF), Color(0xFF491CCB)])
                    : const LinearGradient(colors: [
                        Color.fromARGB(255, 82, 83, 155),
                        Color(0xFF3A364B)
                      ]),
                borderRadius: sendbyme
                    ? const BorderRadius.only(
                        topLeft: Radius.circular(23),
                        topRight: Radius.circular(23),
                        bottomLeft: Radius.circular(23))
                    : const BorderRadius.only(
                        topLeft: Radius.circular(23),
                        topRight: Radius.circular(23),
                        bottomRight: Radius.circular(23)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Text(
                      message,
                      style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 18,
                      )),
                    ),
                  ],
                ),
              )),
        )
      ],
    );
  }
}
