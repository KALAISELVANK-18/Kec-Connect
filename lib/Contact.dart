import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import 'package:url_launcher/url_launcher.dart';
import "package:url_launcher/url_launcher_string.dart";
import 'package:map_launcher/map_launcher.dart';
class Contact extends StatefulWidget {
  const Contact({super.key});

  @override
  State<Contact> createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  List<String> alldepartments=["CSE","AIDS","AIML","AUTOMOBILE","CIVIL","CSD","CT-UG",
  "CT-PG","Chemical","Chemistry","ECE","EEE","EIE","English","FT","IT",
  "MBA","MCA","MECHANICAL","MECHTRONICS","Maths","Physics","Placement Cell","Training Cell"];
  TextEditingController _searchController=new TextEditingController();
  String search_var="";
  List<String> _category=["Teaching","Non-Teaching"];
  int _category_var=0;
  String department="CSE";
  int dataonlylenth=0;
  int forvar=0;
  int expand=0;

  static Future<void> openMap(double latitude, double longitude) async {
    String googleUrl = 'https://www.google.com/maps/dir/?api=1&destination=$latitude,$longitude';
    if (await canLaunchUrlString(googleUrl)) {
      await launchUrlString(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.of(context).pop();
        },icon: Icon(Icons.arrow_back,color: Colors.black,)),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Image.asset("images/logo-color.png",width: 250,height: 90,),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  AnimatedContainer(
                    duration:const Duration(milliseconds: 200),
                    width:MediaQuery.of(context).size.width*((expand==1)?0.8:0.65) ,
                    height: (expand==1)?70:60,
                    child: Container(
                      width: MediaQuery.of(context).size.width*((expand==1)?0.8:0.65),
                      height:(expand==1)?70:60,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20)
                      ),
                      padding: EdgeInsets.all(8.0),
                      child: TextFormField(
                        onTap: (){
                          setState(() {
                            expand=1;
                          });
                          },
                        onTapOutside:(pointerevent){
                                setState(() {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                expand=0;
                                });
                                },
                        controller: _searchController,
                        onChanged: (val){
                          setState(() {

                          });
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color.fromARGB(100,229, 228, 226),
                          disabledBorder:OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(100,229, 228, 226)
                              ),
                              borderRadius: BorderRadius.circular(20)
                          ) ,
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(100,229, 228, 226)
                              ),
                              borderRadius: BorderRadius.circular(20)
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromARGB(100,229, 228, 226)
                              ),
                              borderRadius: BorderRadius.circular(20)
                          ),
                          hintText: 'Search',

                          hintStyle: TextStyle(
                            fontWeight: FontWeight.normal,
                              color: Colors.black
                          ),

                          suffixIcon: IconButton(

                              onPressed: (){
                                setState(() {
                                  search_var=_searchController.text;
                                });

                              },
                              icon: Icon(Icons.search,size: 25,)),
                          suffixIconColor: Colors.black54,
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromARGB(100,0, 255, 127)
                              ),
                              borderRadius: BorderRadius.circular(20)
                          ),

                        ),  cursorColor:Colors.black,

                      ),
                    ),
                  ),

                ],
              ),
              SizedBox(height: 10,),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: (){
                        setState(() {
                          _category_var=0;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Color.fromARGB(255,63,184,241)),
                            borderRadius: BorderRadius.circular(20),
                            color: (_category_var==0)?Color.fromARGB(255,63,184,241):Colors.white
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Row(
                            children: [
                              Icon(Icons.circle,size: 7, color:Colors.white)
                              ,Text(" "+_category[0],style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: (_category_var==0)?Colors.white:Color.fromARGB(255,63,184,241)
                              ),),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: (){
                        setState(() {
                          _category_var=1;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Color.fromARGB(255,63,184,241)),
                            color: (_category_var==1)?Color.fromARGB(255,63,184,241):Colors.white
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(7),
                          child: Row(
                            children: [
                              Icon(Icons.circle,size: 7,color:Colors.white)
                            ,Text(" "+_category[1],style: TextStyle(
                                fontWeight: FontWeight.bold,fontSize: 15,
                                  color:(_category_var==1)?Colors.white:Color.fromARGB(255,63,184,241)
                              ),),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Stack(
                    children: [
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 5,top: 5),
                      //   child: Container(
                      //     height: 35,width:107,
                      //     margin:EdgeInsets.only(left:5),
                      //     decoration: ShapeDecoration(
                      //       color: Colors.greenAccent,
                      //       shape: RoundedRectangleBorder(
                      //         side: BorderSide(width: 0.0, style: BorderStyle.solid,color: Colors.white),
                      //         borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      //       ),
                      //     ),
                      //     child: SizedBox()
                      //   ),
                      // ),
                      Padding(
                        padding: const EdgeInsets.only(right:0),
                        child: Container(

                          height: 35,width:107,
                          margin:EdgeInsets.only(left:5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.greenAccent.withOpacity(0.1),
                                spreadRadius: 5.0,
                                blurRadius: 5.0,
                                offset: Offset(0, 3), // changes the shadow position
                              ),

                            ],
                            color: Colors.white,
                            shape:BoxShape.rectangle
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(

                              menuMaxHeight: 400,
                              iconSize: 15,
                              iconDisabledColor: Colors.white,
                              dropdownColor: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              // Initial Value
                              value: department,

                              // Down Arrow Icon
                              icon: const Icon(Icons
                                  .keyboard_arrow_down,color:  Colors.black,),
                              isExpanded: false,
                              // Array list of items
                              items: alldepartments.map((
                                  String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Container(
                                    width: 90,
                                    child: Text(
                                      items,style: TextStyle(color:Colors.black,fontSize: 13,fontWeight: FontWeight.bold),),
                                  ),
                                );
                              }).toList(), onChanged: (String? value) {
                              setState(() {
                                department =
                                value!;
                              });
                            },

                            ),
                          ),
                        ),
                      ),
                    ],
                  )

                ],
              ),
              SizedBox(
                height: 13,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left:8.0),
                    child: Container(

                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),

                          boxShadow: [
                            BoxShadow(
                              color: Colors.white.withOpacity(0.1),
                              spreadRadius: 5.0,
                              blurRadius: 5.0,
                              offset: Offset(0, 3), // changes the shadow position
                            ),

                          ],
                          color: Colors.white
                      ),

                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0,right: 8,top: 5),
                          child: Text('Staffs',style: TextStyle(

                            color: Colors.black,fontWeight: FontWeight.bold,fontSize: 25
                          ),textAlign: TextAlign.center,),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              Container(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection(department).doc(_category[_category_var]).collection(_category[_category_var]).orderBy("designation",descending: true).snapshots(),


                  builder: (context, AsyncSnapshot snapshot) {


                    if(snapshot.hasError)
                    {
                      return Text("${snapshot.error}");
                    }
                    else
                    {
                    if(snapshot.hasData) {
                    List<DocumentSnapshot> datas=snapshot.data.docs;
                    List<DocumentSnapshot> datasonly=[];
                    dataonlylenth=datas.length;
                    for(forvar =0;forvar<dataonlylenth;forvar++){
                    if((datas[forvar]["name"].toString().toLowerCase()).contains(_searchController.text.toLowerCase()))
                    datasonly.add(datas[forvar]);
                    }
                        return GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,

                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 0.80,
                            crossAxisCount: 2, // Number of columns
                          ),
                          itemCount: datasonly.length, // Total number of items in the grid
                          itemBuilder: (context, index) {

                             return Center(
                              child: TextButton(

                                onPressed: (){
                                  showDialog(context: context, builder: (BuildContext context){return Dialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(10))),
                                    child: Container(

                                      height: 360,

                                      child: SingleChildScrollView(
                                        child: Center(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  SizedBox(height: 20,),
                                                  SizedBox(
                                                    height: 20,
                                                    child: IconButton(
                                                      onPressed: (){
                                                        Navigator.of(context).pop();
                                                      },
                                                      icon: Icon(Icons.close,color: Colors.black,)
                                                    ),
                                                  )
                                                ],
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(5.0),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(30)
                                                  ),
                                                  child: Image.network(
                                                      fit: BoxFit.cover,
                                                      width:100,height:100,"https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"),
                                                ),
                                              ),
                                              SizedBox(height: 5,),
                                              Text(datasonly[index]["name"],textAlign: TextAlign.center,style: TextStyle(

                                                  color: Colors.black,fontWeight: FontWeight.bold,fontSize: 15
                                              )),
                                              SizedBox(height: 5,),
                                              Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(6),

                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.white.withOpacity(0.1),
                                                          spreadRadius: 5.0,
                                                          blurRadius: 5.0,
                                                          offset: Offset(0, 3), // changes the shadow position
                                                        ),

                                                      ],
                                                      color: Color.fromARGB(255, 179, 244, 246)
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(4.0),
                                                    child: Text(datasonly[index]["designation"].toString().toLowerCase(),style: TextStyle(

                                                        color: Colors.black,fontWeight: FontWeight.bold,fontSize: 15
                                                    )),
                                                  )),
                                              SizedBox(height: 5,),
                                              Padding(
                                                padding: const EdgeInsets.all(5.0),
                                                child: GestureDetector(
                                                  onTap: ()async{
                                                    try{
                                                    await launchUrl(
                                                        Uri(
                                                          scheme: 'mailto',
                                                          path: datasonly[index]["email2"].toString(),
                                                          query: "",
                                                        ));

                                                    }catch(e){

                                                    }
                                                  },
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Icon(Icons.email,color: Colors.black,),
                                                      SizedBox(width: 5,)
                                                      ,Text(datasonly[index]["email2"],style: TextStyle(color: Colors.black),)
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              (datasonly[index]["email1"].toString().length>9)?Padding(
                                                padding: const EdgeInsets.all(5.0),
                                                child: GestureDetector(

                                                  onTap: ()async {
                                                    try{
                                                      await launchUrl(
                                                          Uri(
                                                            scheme: 'mailto',
                                                            path: datasonly[index]["email1"].toString(),
                                                            query: "",
                                                          ));

                                                    }catch(e){

                                                    }
                                                  },
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Icon(Icons.email,color: Colors.black,),
                                                      SizedBox(width: 5,)
                                                      ,Text(datasonly[index]["email1"],style: TextStyle(color: Colors.black),)
                                                    ],
                                                  ),
                                                ),
                                              ):SizedBox(),
                                              Row(

                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [

                                                  TextButton(
                                                    style: ButtonStyle(
                                                        tapTargetSize: MaterialTapTargetSize.padded
                                                    ),
                                                    onPressed: () async{
                                                      try{
                                                      await launchUrlString(
                                                          "https://wa.me/${datasonly[index]["whatsappno"]}?text=Respected teacher,");
                                                      }catch(e){

                                                      }
                                                    },
                                                    child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children:[

                                                      Image.asset("images/whatsapp.png",height: 20,width: 20,)
                                                      ,SizedBox(width: 5,)
                                                      ,Text(datasonly[index]["whatsappno"],style:TextStyle(color: Colors.black,)),] ),
                                                  ),

                                                  TextButton(
                                                    onPressed: (){
                                                      launchUrl(Uri.parse("tel://+91${datasonly[index]["whatsappno"]}"));
                                                    },
                                                    child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children:[Image.asset("images/phone-call.png",height: 20,width: 20,),SizedBox(width: 5,),

                                                          Text(datasonly[index]["phoneno"],style:TextStyle(color: Colors.black,)),] ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [

                                                  Center(
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(6),

                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Colors.white.withOpacity(0.3),
                                                              spreadRadius: 5.0,
                                                              blurRadius: 5.0,
                                                              offset: Offset(0, 3), // changes the shadow position
                                                            ),

                                                          ],
                                                          color: Color.fromARGB(255,0,192,163)
                                                      ),
                                                      child: Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: Text(department,style:TextStyle(color: Colors.black,)),
                                                      ),
                                                    ),
                                                  ),


                                                  SizedBox(width: 15,),
                                                  GestureDetector(
                                                    onTap: () async{

                                                        final available=await MapLauncher.installedMaps;

                                                        await  available.first.showMarker(

                                                          coords: Coords(39.925533, 32.866287),
                                                          title: "Itpark",

                                                        );


                                                    },
                                                    child: Center(
                                                      child: Row(

                                                          children:[
                                                        Container(

                                                            child: Row(
                                                              mainAxisAlignment:MainAxisAlignment.center,
                                                              children: [
                                                                Image.asset("images/placeholder.png",height: 20,width: 20,),
                                                                SizedBox(width: 5,),
                                                                Container(
                                                                  width: MediaQuery.of(context).size.width* (((datasonly[index]["staffroom"].toString().length/30)>0.3)?0.3:(datasonly[index]["staffroom"].toString().length/30)),
                                                                  child: Text(

                                                                  datasonly[index]["staffroom"],style:TextStyle(color: Colors.black,),
                                                                  softWrap: true,
                                                                    maxLines: 4,
                                                                  ),
                                                                ),
                                                              ],
                                                            )),],mainAxisAlignment: MainAxisAlignment.center, ),
                                                    ),
                                                  ),


                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ); });
                                },

                                child: Center(
                                  child: Container(
                                    height: MediaQuery.of(context).size.width*0.49,
                                    margin:EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),

                                        boxShadow: [
                                          BoxShadow(

                                            color: Colors.blueGrey.withOpacity(0.1),
                                            spreadRadius: 5.0,
                                            blurRadius: 5.0,
                                            offset: Offset(0, 3),
                                            blurStyle: BlurStyle.inner// changes the shadow position
                                          ),

                                        ],
                                        color: Colors.grey.shade100
                                    ),

                                    // margin: EdgeInsets.all(5),

                                    child: SingleChildScrollView(
                                      child: Center(
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(30)
                                                ),
                                                child: Image.network(
                                                    fit: BoxFit.cover,
                                                    width:100,height:100,"https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"),
                                              ),
                                            ),

                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 6),
                                              child: Text(datasonly[index]["name"].toString().toUpperCase(),textAlign: TextAlign.center,style: TextStyle(

                                                  color: Colors.black,fontWeight: FontWeight.bold,fontSize: 12
                                              )),
                                            ),
                                            SizedBox(height: 5,),
                                            Container(
                                                  width: 130,
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(6),

                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.white.withOpacity(0.1),
                                                        spreadRadius: 5.0,
                                                        blurRadius: 5.0,
                                                        offset: Offset(0, 3), // changes the shadow position
                                                      ),

                                                    ],
                                                    color:Color.fromARGB(255,0,192,163)
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(4.0),
                                                  child: Text(datasonly[index]["designation"].toString().toLowerCase(),style: TextStyle(

                                                      color: Colors.white,fontWeight: FontWeight.bold,fontSize: 15
                                                  ),textAlign: TextAlign.center,),
                                                )),

                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );


                          },
                        );
                      }
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }
}
