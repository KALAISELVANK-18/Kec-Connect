import "dart:io";
import 'package:shimmer/shimmer.dart';
import "package:awesome_snackbar_content/awesome_snackbar_content.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:connectivity_plus/connectivity_plus.dart";
import "package:flutter/material.dart";
import "package:flutter/rendering.dart";
import "package:geocoding/geocoding.dart";
import "package:geolocator/geolocator.dart";
import "package:get/get.dart";
import "package:google_fonts/google_fonts.dart";
import 'package:url_launcher/url_launcher.dart';
import "package:url_launcher/url_launcher_string.dart";
import 'package:map_launcher/map_launcher.dart';

class Contact extends StatefulWidget {
  const Contact({super.key});

  @override
  State<Contact> createState() => _ContactState();
}

class _ContactState extends State<Contact> with AutomaticKeepAliveClientMixin{
  List<String> alldepartments=["All","CSE","AIDS","AIML","AUTOMOBILE","CIVIL","CSD","CT-UG",
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
  List<DocumentSnapshot> datas=[];
  List<DocumentSnapshot> datasonly=[];


  Future<void> _determinePosition(String lat,String lon) async {
    bool serviceEnabled;
    LocationPermission permission;
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      Navigator.pop(context);
      final snackBar = SnackBar(
        /// need to set following properties for best effect of awesome_snackbar_content
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Issue!',
          message:
          'Check your Internet connections!',

          /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
          contentType: ContentType.failure,
        ),
      );

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
      return;
    }
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Navigator.pop(context);
      final snackBar = SnackBar(
        /// need to set following properties for best effect of awesome_snackbar_content
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Turn on Location!',
          message:
          'Your location services is disabled, please enable to have access maps!',

          /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
          contentType: ContentType.failure,
        ),
      );

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
      return ;
    }
    try {
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          // Permissions are denied, next time you could try
          // requesting permissions again (this is also where
          // Android's shouldShowRequestPermissionRationale
          // returned true. According to Android guidelines
          // your App should show an explanatory UI now.
          return Future.error('Location permissions are denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        // Permissions are denied forever, handle appropriately.
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }

      // When we reach here, permissions are granted and we can
      // continue accessing the position of the device.
      var news = await Geolocator.getCurrentPosition();


      List<Placemark> placemarks = await placemarkFromCoordinates(
          news.latitude, news.longitude);
      // return [placemarks.first.locality,placemarks.first.administrativeArea];


      final available = await MapLauncher.installedMaps;

      await available.first.showDirections(

          destination: Coords(double.parse(lat), double.parse(lon)),
          origin: Coords(news.latitude, news.longitude),
          originTitle: "Your location",
          destinationTitle: "Department of CSE"

      );
    }on Exception catch(e,_){
      final snackBar = SnackBar(
        /// need to set following properties for best effect of awesome_snackbar_content
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Issue!',
          message:
          'Check your Internet connections!',

          /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
          contentType: ContentType.failure,
        ),
      );

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
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
        title: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("images/logo2.png",width: 35,height: 35,),
              Padding(
                padding: const EdgeInsets.only(right: 50.0),
                child: Text("CONTACTS",
                  style:GoogleFonts.barlow(textStyle:TextStyle(color: Color.fromARGB(255, 52, 30, 157),fontWeight: FontWeight.bold,fontSize: 25,letterSpacing: 1.5)),),
              )

            ],
          ),
        ),
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
                    duration:const Duration(milliseconds: 100),
                    width:MediaQuery.of(context).size.width*((expand==1)?0.8:0.65) ,
                    //height: (expand==1)?70:60,
                    child: Container(
                      width: MediaQuery.of(context).size.width*((expand==1)?0.8:0.65),
                      //height:(expand==1)?70:60,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20)
                      ),
                      padding: EdgeInsets.all(8.0),
                      child: Center(
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
                          textAlign: TextAlign.left,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: (expand==1)?18:6),
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
                                color: Colors.black,
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
                  ),

                ],
              ),
              SizedBox(height: 10,),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: GestureDetector(
                      onTap: (){
                        setState(() {
                          _category_var=0;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Color.fromARGB(255,52, 30, 157)),
                            borderRadius: BorderRadius.circular(20),
                            color: (_category_var==0)?Color.fromARGB(255,52, 30, 157):Colors.white
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Row(
                            children: [
                              Icon(Icons.circle,size: 7, color:Colors.white)
                              ,Text(" "+_category[0],

                            style:GoogleFonts.poppins(textStyle:TextStyle(color:(_category_var==0)?Colors.white:Color.fromARGB(255,52, 30, 157),fontWeight: FontWeight.w600,fontSize: 13))),


                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: GestureDetector(
                      onTap: (){
                        setState(() {
                          _category_var=1;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Color.fromARGB(255,52, 30, 157)),
                            color: (_category_var==1)?Color.fromARGB(255,52, 30, 157):Colors.white
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(7),
                          child: Row(
                            children: [
                              Icon(Icons.circle,size: 7,color:Colors.white)
                            ,Text(" "+_category[1],style:GoogleFonts.poppins(textStyle:TextStyle(color:(_category_var==1)?Colors.white:Color.fromARGB(255,52, 30, 157),fontWeight: FontWeight.w600,fontSize: 13))),

                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4),
                    child: Container(

                      height: 35,width: MediaQuery.of(context).size.width*0.32,
                      margin:EdgeInsets.only(left:5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(200,52, 30, 157).withOpacity(0.06),
                            spreadRadius: 5.0,
                            blurRadius: 5.0,
                            offset: Offset(0, 3), // changes the shadow position
                          ),

                        ],
                        color: Colors.white,
                        shape:BoxShape.rectangle
                      ),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(

                            menuMaxHeight: 400,
                            iconSize: 24,
                            iconDisabledColor: Colors.white,
                            dropdownColor: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            // Initial Value
                            value: department,

                            // Down Arrow Icon
                            icon: Padding(
                              padding: const EdgeInsets.only(right: 0),
                              child: const Icon(Icons
                                  .keyboard_arrow_down,color:  Colors.black,),
                            ),
                            isExpanded: false,
                            // Array list of items
                            items: alldepartments.map((
                                String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Container(
                                  width: MediaQuery.of(context).size.width*0.26,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left:5.0,bottom: 5,top: 5),
                                    child: Text(
                                      items,
                                        // overflow: TextOverflow.fade,
                                        style:GoogleFonts.poppins(textStyle:TextStyle(color:Colors.black,fontWeight: FontWeight.bold,fontSize: 13))),
                                  ),
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
                          child: Text('Faculty members',style: TextStyle(

                            color: Colors.black,fontWeight: FontWeight.bold,fontSize: 25
                          ),textAlign: TextAlign.center,),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              Container(
                child: FutureBuilder<DocumentSnapshot>(
                  future:FirebaseFirestore.instance.collection("Locations").doc("Locations").get() ,
                  builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot<Object?>> snapshotlocation) {

                    if(snapshotlocation.hasData){
                          print("inside the streamsdsdsd");
                      return FutureBuilder<QuerySnapshot>(

                        future:(department!="All")?FirebaseFirestore.instance.collection(department).doc(_category[_category_var]).collection(_category[_category_var]).orderBy("designation",descending: true).get():
                        FirebaseFirestore.instance.collection("CSE").doc(_category[_category_var]).firestore.collectionGroup(_category[_category_var]).orderBy("designation",descending: true).get(),


                        builder: (context, AsyncSnapshot snapshot) {


                          if(snapshot.hasError)
                          {
                            return Text("${snapshot.error}");
                          }
                          else
                          {
                            if(snapshot.hasData && snapshot.data.docs!=datasonly) {

                              if(_searchController.text!=""){

                              datas=snapshot.data.docs;
                              datasonly=[];
                              dataonlylenth=datas.length;
                              for(forvar =0;forvar<dataonlylenth;forvar++){
                                if((datas[forvar]["name"].toString().toLowerCase()).contains(_searchController.text.toLowerCase()))
                                  datasonly.add(datas[forvar]);
                              }}
                              else
                              datasonly=snapshot.data.docs;
                              return GridView.builder(
                                key: Key("_newkey"),
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,

                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: 0.70,
                                  crossAxisCount: 2, // Number of columns
                                ),
                                itemCount: datasonly.length, // Total number of items in the grid
                                itemBuilder: (context, index) {

                                  return KeyedSubtree(
                                    key: ValueKey<int>(index),
                                    child: Center(
                                      
                                      child: TextButton(

                                        onPressed: (){
                                          showDialog(context: context, builder: (BuildContext context){return Dialog(
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(Radius.circular(10))),
                                            child: Container(

                                              height: MediaQuery.of(context).size.height*0.53,

                                              child: SingleChildScrollView(
                                                child: Padding(
                                                  padding: const EdgeInsets.only(right: 8.0,left: 8,bottom: 8),
                                                  child: Center(
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            SizedBox(),
                                                            SizedBox(
                                                              // height: 40,
                                                              // width: 40,
                                                              child: IconButton(

                                                                  onPressed: (){
                                                                    Navigator.of(context).pop();
                                                                  },
                                                                  icon: SizedBox(

                                                                      width: 40,
                                                                      child: Icon(Icons.close,color: Colors.black,))
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
                                                            child: ClipRRect(
                                                                borderRadius: BorderRadius.circular(8.0),
                                                                child: Image.network(
                                                                    loadingBuilder: (BuildContext context,child,loadingProgress){
                                                                      if(loadingProgress==null)return child;

                                                                      return Shimmer.fromColors(enabled: true,
                                                                        baseColor: Colors.grey.shade300,
                                                                        highlightColor: Colors.grey.shade100,
                                                                        child:Container(
                                                                          color: Colors.grey,
                                                                          child: SizedBox(),
                                                                          height: 150,width: 150,
                                                                        ),);
                                                                    },
                                                                    errorBuilder: (context,O,j){

                                                                      return Shimmer.fromColors(enabled: true,
                                                                        baseColor: Colors.grey.shade300,
                                                                        highlightColor: Colors.grey.shade100,
                                                                        child:Container(
                                                                          color: Colors.grey,
                                                                          child: SizedBox(),
                                                                          height: 150,width: 150,
                                                                        ),);
                                                                    },
                                                                    frameBuilder: (context,i,j,k){
                                                                      return ClipRRect(
                                                                          borderRadius: BorderRadius.circular(8.0),
                                                                          child: Image.network(datasonly[index]["url"].toString(),fit: BoxFit.cover,
                                                                            width:150,height:150,));
                                                                    },
                                                                    fit: BoxFit.cover,
                                                                    width:150,height:150,datasonly[index]["url"].toString()))
                                                        ),),
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
                                                                gradient: LinearGradient(
                                                                    begin: Alignment.topCenter,
                                                                    end: Alignment.bottomCenter,
                                                                    colors: [
                                                                      //Color.fromARGB(255,58,151,238),
                                                                      Color.fromARGB(255,13,81,145),
                                                                      Color.fromARGB(255,52, 30, 157)

                                                                    ]
                                                                ),
                                                                //color: Color.fromARGB(255,52, 30, 157)
                                                            ),
                                                            child: Padding(
                                                              padding: const EdgeInsets.all(8.0),
                                                              child: Text(datasonly[index]["designation"].toString().toString().capitalize!,style: TextStyle(

                                                                  color: Colors.white,fontWeight: FontWeight.bold,fontSize: 15
                                                              )),
                                                            )),
                                                        SizedBox(height: 5,),
                                                        GestureDetector(
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
                                                          child: Padding(
                                                            padding: const EdgeInsets.all(6.0),
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              children: [
                                                                Icon(Icons.email,color: Colors.black,),
                                                                SizedBox(width: 5,)
                                                                ,Text(datasonly[index]["email2"],
                                                                style:GoogleFonts.poppins(textStyle:TextStyle(color:Colors.black,fontWeight: FontWeight.bold,fontSize: 13))),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        (datasonly[index]["email1"].toString().length>9)?GestureDetector(

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
                                                          child: Padding(
                                                            padding: const EdgeInsets.all(6.0),
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              children: [
                                                                Icon(Icons.email,color: Colors.black,),
                                                                SizedBox(width: 5,)
                                                                ,Text(datasonly[index]["email1"],style:GoogleFonts.poppins(textStyle:TextStyle(color:Colors.black,fontWeight: FontWeight.bold,fontSize: 13)))
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


                                                                    Navigator.pop(context);
                                                                    final snackBar = SnackBar(
                                                                      /// need to set following properties for best effect of awesome_snackbar_content
                                                                      elevation: 0,
                                                                      behavior: SnackBarBehavior.floating,
                                                                      backgroundColor: Colors.transparent,
                                                                      content: AwesomeSnackbarContent(
                                                                        title: 'Issue!',
                                                                        message:
                                                                        'Check if whatsapp is installed!',

                                                                        /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                                                                        contentType: ContentType.failure,
                                                                      ),
                                                                    );

                                                                    ScaffoldMessenger.of(context)
                                                                      ..hideCurrentSnackBar()
                                                                      ..showSnackBar(snackBar);


                                                                }
                                                              },
                                                              child: Row(
                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                  children:[

                                                                    Image.asset("images/whatsapp.png",height: 20,width: 20,)
                                                                    ,SizedBox(width: 5,)
                                                                    ,Text(datasonly[index]["whatsappno"],style:GoogleFonts.poppins(textStyle:TextStyle(color:Colors.black,fontWeight: FontWeight.bold,fontSize: 13)))] ),
                                                            ),

                                                            TextButton(
                                                              onPressed: (){
                                                                launchUrl(Uri.parse("tel://+91${datasonly[index]["whatsappno"]}"));
                                                              },
                                                              child: Row(
                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                  children:[Image.asset("images/phone-call.png",height: 20,width: 20,),SizedBox(width: 5,),

                                                                    Text(datasonly[index]["phoneno"],style:GoogleFonts.poppins(textStyle:TextStyle(color:Colors.black,fontWeight: FontWeight.bold,fontSize: 13))),] ),
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
                                                                    gradient: LinearGradient(
                                                                        begin: Alignment.topCenter,
                                                                        end: Alignment.bottomCenter,
                                                                        colors: [
                                                                          //Color.fromARGB(255,58,151,238),
                                                                          Color.fromARGB(255,52, 30, 157),
                                                                          Color.fromARGB(255,13,81,145),


                                                                        ]
                                                                    ),
                                                                    //color: Color.fromARGB(255,52, 30, 157)
                                                                ),
                                                                child: Padding(
                                                                  padding: const EdgeInsets.all(8.0),
                                                                  child: Text(department,style:TextStyle(color: Colors.white,fontWeight: FontWeight.w600)),
                                                                ),
                                                              ),
                                                            ),


                                                            SizedBox(width: 15,),
                                                            TextButton(
                                                              onPressed: () async{
                                                                    try {
                                                                      _determinePosition(
                                                                          snapshotlocation
                                                                              .data![department]["latitude"],
                                                                          snapshotlocation
                                                                              .data![department]["longitude"]);
                                                                    }on Exception catch(e,_){


                                                                    }

                                                              },
                                                              child: Center(
                                                                child: Row(

                                                                  children:[
                                                                    Container(

                                                                        child: Row(
                                                                          mainAxisAlignment:MainAxisAlignment.center,
                                                                          children: [
                                                                            Image.asset("images/placeholder.png",height: 25,width: 25,),
                                                                            SizedBox(width: 5,),
                                                                            Container(
                                                                              width: MediaQuery.of(context).size.width* (((datasonly[index]["staffroom"].toString().length/30)>0.3)?0.3:(datasonly[index]["staffroom"].toString().length/30)),
                                                                              child: Text(

                                                                                datasonly[index]["staffroom"],style:GoogleFonts.poppins(textStyle:TextStyle(color:Colors.black,fontWeight: FontWeight.bold,fontSize: 13))
                                                                                ,softWrap: true,
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
                                            ),
                                          ); });
                                        },

                                        child: Center(
                                          child: Container(
                                            height: MediaQuery.of(context).size.width*0.6,
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

                                            child: Stack(
                                              children: [
                                                Center(
                                                child: Column(
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.all(5.0),
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(30)
                                                        ),
                                                        child: ClipRRect(
                                                            borderRadius: BorderRadius.circular(8.0),
                                                            child: Image.network(datasonly[index]["url"].toString(),
                                                                loadingBuilder: (BuildContext context,child,loadingProgress){

                                                                  if(loadingProgress==null)return child;

                                                                  return Shimmer.fromColors(enabled: true,
                                                                    baseColor: Colors.grey.shade300,
                                                                    highlightColor: Colors.grey.shade100,
                                                                    child:Container(
                                                                      color: Colors.grey,
                                                                      child: SizedBox(),
                                                                      height: 150,width: 150,
                                                                    ),);
                                                                },
                                                                errorBuilder: (context,i,j){

                                                                  return Shimmer.fromColors(enabled: true,
                                                                    baseColor: Colors.grey.shade300,
                                                                    highlightColor: Colors.grey.shade100,
                                                                    child:Container(
                                                                      color: Colors.grey,
                                                                      child: SizedBox(),
                                                                      height: 150,width: 150,
                                                                    ),);
                                                                },
                                                                frameBuilder: (context,i,j,k){

                                                                    return i;
                                                                  return ClipRRect(
                                                                      borderRadius: BorderRadius.circular(8.0),
                                                                      child: Image.network(datasonly[index]["url"].toString(),fit: BoxFit.cover,
                                                                        width:150,height:150,));
                                                                },
                                                                fit: BoxFit.cover,
                                                                width:150,height:150,))
                                                      ),
                                                    ),

                                                    Padding(
                                                      padding: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 6),
                                                      child: Container(
                                                        height: 20,
                                                        child: SingleChildScrollView(
                                                              scrollDirection: Axis.horizontal,
                                                          child: Text(datasonly[index]["name"].toString().toUpperCase(),textAlign: TextAlign.center,
                                                              style:GoogleFonts.poppins(textStyle:TextStyle(color:Color.fromARGB(255,52, 30, 157),fontWeight: FontWeight.bold,fontSize: 13))),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(height: 5,),

                                                    Container(
                                                        width: 130,
                                                        height: 35,
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
                                                          gradient: LinearGradient(
                                                              begin: Alignment.topCenter,
                                                              end: Alignment.bottomCenter,
                                                              colors: [
                                                                //Color.fromARGB(255,58,151,238),
                                                                Color.fromARGB(255,13,81,145),
                                                                Color.fromARGB(255,52, 30, 157)

                                                              ]
                                                          ),
                                                          //color:Color.fromARGB(255,52, 30, 157)
                                                        ),
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            Padding(
                                                              padding: const EdgeInsets.all(4.0),
                                                              child:SingleChildScrollView(
                                                                scrollDirection: Axis.horizontal,
                                                                child: Text(datasonly[index]["designation"].toString().toLowerCase().capitalize!,style:GoogleFonts.poppins(textStyle:TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 12)),
                                                                  textAlign: TextAlign.center,),
                                                              ),
                                                            ),
                                                          ],
                                                        )),
                                                  ],
                                                ),
                                              ),

                                              ]
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
                      );
                    }
                    else{
                      return CircularProgressIndicator();
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

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
