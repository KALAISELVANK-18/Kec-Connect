import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class About extends StatefulWidget {
  const About({super.key});

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
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
                child: Text("ABOUT US",
                  style:GoogleFonts.barlow(textStyle:TextStyle(color: Color.fromARGB(255, 52, 30, 157),fontWeight: FontWeight.bold,fontSize: 25)),),
              )

            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text("Kongu Engineering College",style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.bold),),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Image.asset("images/aboutkec.jpg",height: 250,width: 250,fit: BoxFit.cover,),
                    ),

                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Container(
                    child:Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                  decoration: BoxDecoration(
                                      border: Border(bottom: BorderSide(color: Color.fromARGB(255, 202, 238, 231),width: 2))
                                  ),
                                  child: Text("Vi",style: GoogleFonts.poppins(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),)),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(color: Colors.white,width: 2))
                                ),
                                  child: Text("sion ",style: GoogleFonts.poppins(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),)),
                            ],
                            mainAxisAlignment: MainAxisAlignment.start,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 6),
                            child: Text("To be a centre of excellence for development and dissemination of knowledge in Applied science, Technology, Engineering and Management for the Nation and beyond."
                              ,style: GoogleFonts.poppins(fontSize: 14,height: 1.5),textAlign: TextAlign.justify,),
                          ),
                        ],
                      ),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color:  Color.fromARGB(255, 202, 238, 231),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Container(
                    child:Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                  decoration: BoxDecoration(
                                      border: Border(bottom: BorderSide(color: Color.fromARGB(255, 249, 233, 231),width: 2))
                                  ),
                                  child: Text("Mi",style: GoogleFonts.poppins(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),)),
                              Container(
                                  decoration: BoxDecoration(
                                      border: Border(bottom: BorderSide(color: Colors.white,width: 2))
                                  ),
                                  child: Text("ssion ",style: GoogleFonts.poppins(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),)),
                            ],
                            mainAxisAlignment: MainAxisAlignment.start,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 6),
                            child: Text("We are committed to value based Education, Research and Consultancy in Engineering and Management and to bring out technically competent, ethically strong and quality professionals to keep our Nation ahead in the competitive knowledge intensive world."
                              ,style: GoogleFonts.poppins(fontSize: 14,height: 1.5),textAlign: TextAlign.justify,),
                          ),
                        ],
                      ),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color:  Color.fromARGB(255, 249, 233, 231),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Row(
                    children: [
                      Container(
                          decoration: BoxDecoration(
                              border: Border(bottom: BorderSide(color: Colors.white,width: 2))
                          ),
                          child: Text("Abo",style: GoogleFonts.poppins(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),)),
                      Container(
                          decoration: BoxDecoration(
                              border: Border(bottom: BorderSide(color: Color.fromARGB(
                                  255, 85, 168, 152),width: 2))
                          ),
                          child: Text("ut KEC ",style: GoogleFonts.poppins(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),)),
                    ],
                    mainAxisAlignment: MainAxisAlignment.start,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text("Kongu Engineering College, one of the foremost multi professional research-led Institutions is internationally a recognized leader in professional and career-oriented education. It provides an integral, inter-disciplinary education - a unique intersection between theory and practice, passion and reason. The College offers courses of study that are on the frontiers of knowledge and it connects the spiritual and practical dimensions of intellectual life, in a stimulating environment that fosters rigorous scholarship and supportive community. This Institute is a great possession of the committed Trust called 'The Kongu Vellalar Institute of Technology Trust' in Erode District, Tamilnadu. The noble Trust has taken the institute to greater heights since its inception in 1983 and has established the college as a forum for imparting value based education for men and women",
                    style: GoogleFonts.poppins(fontSize: 14,height: 1.5),
                  textAlign: TextAlign.justify,),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Text("The word 'Kongu' refers to a region of the southern state of India and the term 'Kongu Vellalar' specially means the agricultural community, predominated in the west of Tamilnadu, which was deprived of educational facility in those days. To achieve technical excellence in their rural areas, 41 philanthropists from different walks of life who realized the need for technical education for their region's economic strides, formed collectively a Trust called 'The Kongu Vellalar Institute of Technology Trust' and they tried to promote and develop equality of opportunity for the rich and the poor.",
                    style: GoogleFonts.poppins(fontSize: 14,height: 1.5),
                    textAlign: TextAlign.justify,),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text("Affiliated to Anna University Chennai,the college has completed more than three decades of dedicated service to the people of India and abroad in the field of Technical Education. The Institution has an area of 167 acres of land richly endowed with beautiful greeneries. The college with its state-of- the- art infrastructural facilities and excellent academic records has earned recognition as one of the reputed educational institutions for men and women in India.",
                    style: GoogleFonts.poppins(fontSize: 14,height: 1.5),
                    textAlign: TextAlign.justify,),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
