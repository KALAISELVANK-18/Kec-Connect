
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:progress_indicator/progress_indicator.dart';



class MyHomePage1 extends StatefulWidget {
  const MyHomePage1({Key? key}) : super(key: key);


  static const String routeName = "/signup";


  @override
  State<MyHomePage1> createState() => _MyHomePage1State();
}

class _MyHomePage1State extends State<MyHomePage1> {

  FilePickerResult? pickedFile;
  String value1 = 'CAT1';
  double perc=0;
  int bo=0;
  TextEditingController x1 = new TextEditingController();

  @override
  Widget build(BuildContext context) {

return WillPopScope(
  onWillPop: ()async{

    return false;
  },
  child:   Scaffold(

    backgroundColor: Colors.black,



    appBar: AppBar(



      backgroundColor: Colors.white,



      title: Text(



        "KEC",



        style: GoogleFonts.nunitoSans(



            fontWeight: FontWeight.bold, color: Colors.black),



      ),



      // leading: Icon(



      //   Icons.menu,



      //   color: Colors.black,



      // ),







    ),



    body:   SingleChildScrollView(



      scrollDirection: Axis.vertical,

      child: Container(



        decoration: BoxDecoration(



          color: Colors.black,



        ),



        child: Column(

            children: [

              Center(),



            SizedBox(height: 50,),



            Text("Now you can upload mark details...",style: GoogleFonts.aBeeZee(textStyle: TextStyle(



              fontSize: 20,color: Colors.white



            )),),
            Padding(
              padding: const EdgeInsets.only(left: 10,right: 10,top: 10),
              child: TextField(
                controller: x1,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter the current sem',
                ),
              ),
            ),
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 20),
                ),
                onPressed: ()async {
                  await FirebaseFirestore.instance.collection('Details').doc('21Semdetails').update({
                    "currentsem": int.parse(x1.text),
                  });

                },
                child: const Text('Set'),
              ),

            SizedBox(height: 50,),

            Container(

              decoration: BoxDecoration(



                borderRadius: BorderRadius.circular(12),



                color: Colors.white,

                boxShadow: [


                  BoxShadow(



                    color: Colors.grey.withOpacity(0.5),



                    spreadRadius: 5,



                    blurRadius: 7,



                    offset: Offset(0, 3),



                  ),



                ],



              ),



              child: Column(



                children: [



                  Container(



                    height:120,



                    width: 230,



                    child: Row(



                      children: [



                        Image.network("https://img.freepik.com/premium-vector/job-exam-test-vector-illustration_138676-243.jpg?w=2000"),



                        Text("Exam",style: GoogleFonts.aBeeZee(textStyle: TextStyle(



                          fontSize: 20,



                        )),)



                      ],



                    ),



                    padding: const EdgeInsets.all(12),



                  ),











                ],



              ),



            ),



            SizedBox(height: 50,),



            Container(







              decoration: BoxDecoration(



                borderRadius: BorderRadius.circular(12),



                color: Colors.white,







                boxShadow: [



                  BoxShadow(



                    color: Colors.grey.withOpacity(0.5),



                    spreadRadius: 5,



                    blurRadius: 7,



                    offset: Offset(0, 3),



                  ),



                ],



              ),



              child: Column(



                children: [

                  Container(

                    height:120,

                    width: 230,

                    child: Row(

                      children: [

                        Image.network("https://img.freepik.com/premium-vector/job-exam-test-vector-illustration_138676-243.jpg?w=2000"),

                        Text("Exam",style: GoogleFonts.aBeeZee(textStyle: TextStyle(

                          fontSize: 20,

                        )),)

                      ],

                    ),

                    padding: const EdgeInsets.all(12),

                  ),

                  TextButton(onPressed: ()async{



                    FilePickerResult? result=await FilePicker.platform.pickFiles(

                      type: FileType.custom,

                      allowedExtensions: ['xlsx'],

                      withData: true,

                      allowMultiple: false,

                    );



                    if (result != null) {

                      setState((){

                        pickedFile=result;



                      });

                      PlatformFile file = result.files.first;

                      var excel = Excel.decodeBytes(file.bytes as List<int>);



                      for (var table in excel.tables.keys) {





                        if(excel.tables[table]!.maxCols<15)

                        {



                          setState((){

                              perc=0;

                              bo=1;

                          });

                        }

                        else{

                          bo=2;

                        }

                      }

                    }



                    /// Use FilePicker to pick files in Flutter Web







                    },

                    child: Container(



                      width: 230,



                      height: 50,



                      decoration: BoxDecoration(color: Colors.greenAccent,borderRadius: BorderRadius.circular(10)),



                      child: Padding(



                        padding: const EdgeInsets.all(8.0),



                        child: Center(child: Text("Attach Document",style: TextStyle(color:Colors.black),)),



                      )),

                  ),],),



            ),



            SizedBox(height: 60,),

              if(bo==1)TextButton(onPressed: ()async{





      PlatformFile file = pickedFile!.files.first;

      var excel = Excel.decodeBytes(file.bytes as List<int>);

      if(perc==0){

      for (var table in excel.tables.keys) {


        int len=excel.tables[table]!.rows.length;
        for (int i=1;i<len;i++) {
              await FirebaseFirestore.instance.collection(excel.tables[table]!.rows[i][11]!.value.toString()).doc(excel.tables[table]!.rows[i][10]?.value.toString()).collection(excel.tables[table]!.rows[i][10]!.value.toString()).doc(excel.tables[table]!.rows[i][1]?.value.toString()).set({
                "eid":excel.tables[table]!.rows[i][1]?.value.toString(),
                "name":excel.tables[table]!.rows[i][2]?.value.toString(),
                "email1":excel.tables[table]!.rows[i][3]?.value.toString(),
                "email2":excel.tables[table]!.rows[i][4]?.value.toString(),
                "designation":excel.tables[table]!.rows[i][5]?.value.toString(),
                "category":excel.tables[table]!.rows[i][10]?.value.toString(),
                "phoneno":excel.tables[table]!.rows[i][6]?.value.toString(),
                "whatsappno":excel.tables[table]!.rows[i][7]?.value.toString(),
                "staffroom":excel.tables[table]!.rows[i][8]?.value.toString(),
                "url":excel.tables[table]!.rows[i][9]?.value.toString(),
              });



          setState(() {
            perc=((i+1)/excel.tables[table]!.rows.length);
          });

         // print(perc);





        }

      }}







              }, child:Column(

                children: [

                  (perc==0)?Container(

                      width: 230,

                      height: 50,

                      decoration: BoxDecoration(color: Color.fromARGB(255,115, 208, 251),borderRadius: BorderRadius.circular(10)),

                      child: Center(

                        child: Row(

                          mainAxisAlignment: MainAxisAlignment.center,

                          children: [

                            Icon(Icons.cloud_upload_outlined,size: 40,color: Colors.white,),SizedBox(width: 20,),

                            Padding(



                              padding: const EdgeInsets.all(8.0),



                              child: Center(child: Text("upload",style: TextStyle(color:Colors.black),)),



                            ),

                          ],

                        ),

                      )):SizedBox(),(perc>0 && perc<=1)?Column(

                        children: [

                          SizedBox(height: 20,),

                          Container(

                            width: 200,

                            height: 30,

                            decoration: BoxDecoration(

                              borderRadius: BorderRadius.circular(20)



                            ),

                            child: BarProgress(

                              percentage: perc*100,
                              backColor: Colors.white,
                              gradient: LinearGradient(colors: [Colors.lightGreenAccent, Colors.lightGreenAccent]),
                              showPercentage: true,
                              textStyle:TextStyle(color: Colors.orange,fontSize: 20),
                              stroke: 20,
                              round: true,





                              //center: Text((perc<1)?"uploading...":"uploaded!!",style: TextStyle(color: Colors.white),),

                            ),

                          ),



                        ],

                      ):SizedBox(),





                ],

              ), )

                else if(bo==2)

      Container(

      width: 230,

      height: 50,

      decoration: BoxDecoration(color: Colors.redAccent,borderRadius: BorderRadius.circular(10)),

      child: Center(

      child: Row(

      mainAxisAlignment: MainAxisAlignment.center,

      children: [



      Padding(



      padding: const EdgeInsets.all(8.0),



      child: Center(child: Text("file format is incorrect!",style: TextStyle(color:Colors.black),)),



      ),

      ],

      ),

      ))

              else if(pickedFile!=null)

                  Container(

                      width: 230,

                      height: 50,

                      decoration: BoxDecoration(color: Color.fromARGB(255,115, 208, 251),borderRadius: BorderRadius.circular(10)),

                      child: Center(

                        child: Row(

                          mainAxisAlignment: MainAxisAlignment.center,

                          children: [



                            Padding(



                              padding: const EdgeInsets.all(8.0),



                              child: Center(child: Text("file checking",style: TextStyle(color:Colors.black),)),



                            ),SizedBox(height: 20,width: 20,

                                child: (bo!=2)?CircularProgressIndicator(color: Colors.white,):SizedBox())

                          ],

                        ),

                      )),













          ],







        ),



      ),

    ),



  ),
);
  }


}












