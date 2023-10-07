import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:studiesy/Ui/Transcription.dart';
import 'package:studiesy/Ui/chatScreen.dart';
import 'package:studiesy/models/databaseMethods.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Color> borderColors = [
    Color.fromARGB(255, 157, 234, 255),
    Color.fromARGB(255, 109, 209, 255),
    Color.fromARGB(255, 88, 93, 225),
    Color.fromARGB(255, 59, 137, 255)
  ];
  List<String> imageAssets = [
    'assets/image1.png',
    'assets/image2.png',
    'assets/image3.png',
    'assets/image4.png',
  ];
  List subjects = [
    'Physics',
    'Mathematics',
    'English',
    'Chemistry',
  ];

  Stream? notes;

  @override
  void initState() {
    DataBaseMethods().getNotes().then((val) {
      setState(() {
        notes = val;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: SafeArea(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 3.h, left: 5.w),
              child: Text(
                'Hey Amigo👋',
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 22.sp,
                    color: Color.fromARGB(255, 25, 81, 235),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 0.5.h),
              child: Text(
                'What do you want to learn today?',
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12.sp,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.5.h),
              child: SearchBar(
                hintText: 'Search',
                leading: Icon(
                  Icons.search,
                  size: 25.sp,
                  color: const Color.fromARGB(255, 0, 0, 0),
                ),
                hintStyle: MaterialStatePropertyAll(
                  GoogleFonts.poppins(
                    textStyle:
                        const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                  ),
                ),
                elevation: const MaterialStatePropertyAll(0),
                backgroundColor: const MaterialStatePropertyAll(
                  Color.fromRGBO(220, 224, 255, 0.843),
                ),
                shape: MaterialStatePropertyAll(
                  ContinuousRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.sp),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 0.5.h),
              child: Text(
                'Learn Live',
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12.sp,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 5.w),
              child: Row(
                children: [
                  for (int i = 0; i < 4; i++)
                    Container(
                      height: 70.0,
                      width: 70.0,
                      margin: const EdgeInsets.all(8.0),
                      child: Card(
                        shape: CircleBorder(
                          side: BorderSide(
                            width: 2,
                            color: borderColors[i],
                          ),
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const TranscriptionPage()),
                            );
                          },
                          child: ClipOval(
                            child: Container(
                              color: borderColors[i],
                              child: Center(
                                child: Image.asset(
                                  imageAssets[i],
                                  height: 40.0,
                                  width: 40.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 0.5.h),
              child: Text(
                'Your Subjects',
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12.sp,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
              ),
            ),
            genNotes()
          ],
        )),
      ),
    );
  }

  genNotes() {
    return Expanded(
        child: StreamBuilder(
            stream: notes,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: snapshot.data!.docs.length,
                    padding:
                        EdgeInsets.symmetric(horizontal: 5.w, vertical: 0.5.h),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 9 / 14, crossAxisCount: 2),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.all(1.5.w),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ConversationScreen(
                                  chatRoomId: 'dfdf',
                                  userName: 'Studiesy',
                                  subject: snapshot.data.docs[index]['name'],
                                ),
                              ),
                            );
                          },
                          child: Container(
                            height: 200,
                            decoration: BoxDecoration(
                                // gradient: const LinearGradient(
                                //     begin: Alignment.topLeft,
                                //     end: Alignment.bottomRight,
                                //     colors: [
                                //       Color.fromARGB(248, 244, 87, 255),
                                //       Color.fromARGB(248, 143, 75, 147)
                                //     ]),
                                image: DecorationImage(
                                  image: AssetImage(
                                      'assets/bg.jpg'), // Replace with your image asset path
                                  fit: BoxFit
                                      .cover, // You can adjust the fit as needed
                                ),
                                borderRadius: BorderRadius.circular(20.sp)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: 2.h,
                                    left: 4.w,
                                  ),
                                  child: Text(
                                    snapshot.data.docs[index]['name'],
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: true,
                                    style: GoogleFonts.poppins(
                                        height: 1,
                                        color:
                                            const Color.fromARGB(255, 0, 0, 0),
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 4.w,
                                  ),
                                  child: Text(
                                    snapshot.data.docs[index]['teacher'],
                                    style: GoogleFonts.poppins(
                                        color: Color.fromARGB(255, 0, 0, 0),
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 4.w,
                                  ),
                                  child: Text(
                                    snapshot.data.docs[index]['date'],
                                    style: GoogleFonts.poppins(
                                        color: Color.fromARGB(255, 0, 0, 0),
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 4.w,
                                    vertical: 0.5.h,
                                  ),
                                  child: Text(
                                    snapshot.data.docs[index]['summary'],
                                    overflow: TextOverflow.fade,
                                    maxLines: 7,
                                    style: GoogleFonts.poppins(
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                        fontSize: 8.sp,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                // const Align(
                                //   alignment: Alignment.center,
                                //   child: Icon(
                                //     Icons.arrow_forward_ios,
                                //     color: Color.fromARGB(255, 0, 0, 0),
                                //   ),
                                // )
                              ],
                            ),
                          ),
                        ),
                      );
                    });
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }
}
