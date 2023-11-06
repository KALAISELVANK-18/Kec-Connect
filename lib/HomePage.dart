import 'dart:async';
import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kecconnect/About.dart';
import 'package:kecconnect/Calendar.dart';
import 'package:kecconnect/Contact.dart';
import 'package:kecconnect/Schedule.dart';
import 'package:path_provider/path_provider.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String pathPDF = "";

  @override
  void initState() {
    super.initState();
    fromAsset('images/Schedule.pdf', 'Schedule.pdf').then((f) {
      setState(() {
        pathPDF = f.path;
      });
    });
  }

  Future<File> fromAsset(String asset, String filename) async {
    Completer<File> completer = Completer();
    try {
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/$filename");
      var data = await rootBundle.load(asset);
      var bytes = data.buffer.asUint8List();
      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }

    return completer.future;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 52, 30, 157),
      // appBar: AppBar(
      //
      //   flexibleSpace: Center(
      //     child: Text(
      //       "KEC CONNECT",style: GoogleFonts.roboto(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 18),
      //     ),
      //   ),

      //
      // ),
      body: SingleChildScrollView(
        child: Container(
          child : Column(
            children: [
              Container(

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                  )
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Column(
                    children: [

                       Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           Container(
                               child: Padding(
                                 padding: const EdgeInsets.all(15),
                                 child: Row(
                                   children: [
                                     Image.asset("images/logo-color.png",width: 250,height:100,),
                                     //Text("KEC CONNECT",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: 28,color:Color.fromARGB(255, 29, 190, 115) )),
                                   ],
                                   mainAxisAlignment: MainAxisAlignment.center,
                                 ),
                               ),

                             decoration: BoxDecoration(
                               color: Color.fromARGB(255, 255, 255, 255),
                               borderRadius: BorderRadius.only(
                                 bottomLeft: Radius.circular(30),
                                 bottomRight: Radius.circular(30),
                               )
                             ),

                           ),

                         ],

                       ),

                      Padding(
                        padding: const EdgeInsets.only(top: 10,bottom: 5),
                        child: Row(
                          children: [
                            Image.asset("images/home.png",
                              height: 280,width: MediaQuery.of(context).size.width*0.7,
                            ),
                          ],
                          mainAxisAlignment: MainAxisAlignment.center,
                        )
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  //color: Color.fromARGB(255, 29, 190, 115),
                    color: Color.fromARGB(255, 52, 30, 157),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30))
                ),
                child: Column(
                  children:[
                Padding(

                  padding: const EdgeInsets.only(top: 20),
                  child: Text("What would you like to do?",style: GoogleFonts.poppins(fontWeight: FontWeight.w600,fontSize: 20,color: Colors.white),),
                ),
                Row(mainAxisAlignment: MainAxisAlignment.spaceAround,children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(

                              children: [
                                GestureDetector(

                                  child: Container(
                                    height: 110,
                                    width: 110,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(30),

                                    ),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(top: 30),
                                          child: Container(
                                            height: 50,
                                            width: 50,
                                            child: ClipOval(
                                                child: SizedBox.fromSize(
                                                    size: Size.fromRadius(48),
                                                    child: Icon(Icons.groups,color: Color.fromARGB(255, 29, 190, 115),size: 50,))
                                            ),
                                          ),
                                        ),

                                      ],
                                    ),

                                  ),
                                  onTap: (){
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) => const About(),
                                      ),
                                    );
                                  },
                                ),
                                Text("About KEC",style: GoogleFonts.poppins(fontSize: 20,color: Colors.white),),
                              ],mainAxisAlignment: MainAxisAlignment.center,
                            ),
                              SizedBox(height: 20,),

                            Column(
                              children: [
                                GestureDetector(

                                  child: Container(
                                    height: 110,
                                    width: 110,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(30),

                                    ),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(top: 30),
                                          child: Container(
                                            height: 50,
                                            width: 50,
                                            child: ClipOval(
                                              child: SizedBox.fromSize(
                                                  size: Size.fromRadius(48), // Image radius
                                                  child: Icon(Icons.calendar_month,size: 50,color:Color.fromARGB(255, 29, 190, 115) ,)
                                              ),
                                            ),
                                          ),
                                        ),

                                      ],
                                    ),

                                  ),
                                  onTap: (){
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) => HomeCalendarPage(),
                                      ),
                                    );
                                  },
                                ),
                                Text("Events",style: GoogleFonts.poppins(fontSize: 20,color: Colors.white),),
                              ],
                            ),
                          ],
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Column(
                          children: [
                            Column(
                              children: [
                                GestureDetector(
                                  onTap: (){
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) => const Contact(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    height: 110,
                                    width: 110,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(30),

                                    ),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(top: 30),
                                          child: Container(
                                            height: 50,
                                            width: 50,
                                            child: ClipOval(
                                              child: SizedBox.fromSize(
                                                  size: Size.fromRadius(48), // Image radius
                                                  child: Icon(Icons.call,color: Color.fromARGB(255, 29, 190, 115),size: 50,)
                                              ),
                                            ),
                                          ),
                                        ),

                                      ],
                                    ),

                                  ),
                                ),
                                Text("Contacts",style: GoogleFonts.poppins(fontSize: 20,color: Colors.white),),
                              ],mainAxisAlignment: MainAxisAlignment.center,
                            ),
                            SizedBox(height: 20,),
                            Column(
                              children: [
                                GestureDetector(
                                  onTap: (){
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) => PDFScreen(path: pathPDF),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    height: 110,
                                    width: 110,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(30),

                                    ),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(top: 30),
                                          child: Container(
                                            height: 50,
                                            width: 50,
                                            child: ClipOval(
                                              child: SizedBox.fromSize(
                                                  size: Size.fromRadius(48), // Image radius
                                                  child: Icon(Icons.schedule,size: 50,color:Color.fromARGB(255, 29, 190, 115) ,)
                                              ),
                                            ),
                                          ),
                                        ),

                                      ],
                                    ),

                                  ),
                                ),
                                Text("Schedule",style: GoogleFonts.poppins(fontSize: 20,color: Colors.white),),
                              ],
                            ),
                          ],
                          mainAxisAlignment: MainAxisAlignment.center,
                        ),
                      ),
                    ],
                  )
                ],)


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
