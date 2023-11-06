import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

import 'CalendarUtils.dart';

class HomeCalendarPage extends StatefulWidget {
  @override
  _HomeCalendarPageState createState() => _HomeCalendarPageState();
}

class _HomeCalendarPageState extends State<HomeCalendarPage> {
  DateTime selectedDate=DateTime.now();
  final List<String> mont=['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
  final List<Color> colour=[Color.fromARGB(255,125, 249, 255),Color.fromARGB(255,15, 255, 80),Color.fromARGB(255,255,99,71),Color.fromARGB(255,255,255,143)];

// Create a formatter for the desired format
  DateFormat formatter = DateFormat("yyyy-MM-dd 00:00:00.000'Z'");


  late final PageController _pageController ;
  final List<DateTime> gg=[DateTime.utc(2019,6,5)];
  late  ValueNotifier<List<Event>> _selectedEvents=new ValueNotifier<List<Event>>([]);
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
      .toggledOff; // Can be toggled on/off by longpressing a date
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay ;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  final Map<DateTime, List<Event>> kEvents = {};
  @override
  void initState() {
    super.initState();
    selectedDate=_focusedDay;
    _selectedDay = _focusedDay;
    //_selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }

  @override
  void dispose() {

    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Color.fromARGB(255, 52, 30, 157),
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
                child: Text("EVENTS",
                  style:GoogleFonts.barlow(textStyle:TextStyle(color: Color.fromARGB(255, 83, 113, 255),fontWeight: FontWeight.bold,fontSize: 25)),),
              )

            ],
          ),
        ),
      ),
      body: SingleChildScrollView(

        child: Column(
              children: [


                StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance.collection('Calendar events').snapshots(),
                    builder: (context, AsyncSnapshot snapshot) {

                      if(snapshot.hasData){


                        List<Event> _getEventsForDay(DateTime day) {
                          return kEvents[day] ?? [];
                        }

                        void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
                          setState(() {
                            _selectedDay = selectedDay;
                            _focusedDay = focusedDay;
                            selectedDate=focusedDay;
                            _rangeStart = null; // Important to clean those
                            _rangeEnd = null;
                            _rangeSelectionMode = RangeSelectionMode.toggledOff;
                            _selectedEvents = ValueNotifier<List<Event>>(_getEventsForDay(selectedDay));
                          });
                        }

                        List<DocumentSnapshot> str;
                        str = snapshot.data.docs;


                        if(kEvents.length==0){
                          int lent=str.length;
                          for (int i = 0;i < lent; i++) {
                            // print((str[i]["date"] as Timestamp).toDate());
                            List<Event> dynamics=[];
                            for(int j=0;j<str[i]["event"].length;j++){
                              dynamics.add(Event(str[i]["event"][j]));
                            }

                            kEvents[DateTime.parse(formatter.format((str[i]["date"] as Timestamp).toDate()))] = dynamics;
                            if(i==lent-1){
                                }
                          }
                          _selectedEvents = ValueNotifier<List<Event>>(_getEventsForDay(DateTime.parse(formatter.format((DateTime.now())))));
                        }

                        return Container(

                          child: Column(
                            children: [

                              Padding(
                                padding: const EdgeInsets.all(0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        bottomRight:Radius.circular(15) ,bottomLeft:Radius.circular(15)
                                      )
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(height: 10,),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 4.0,bottom:4.0,left: 0,right: 15),
                                        child: Row(
                                          children: [
                                            const SizedBox(width: 16.0),
                                            SizedBox(
                                              width: 140.0,
                                              child: Row(
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      border: Border(bottom: BorderSide(color: Color.fromARGB(255, 52, 30, 157),width: 3),)
                                                    ),
                                                    child: Text(
                                                      mont[selectedDate.month-1].toString(),
                                                      style: TextStyle(fontSize: 26.0),
                                                    ),
                                                  ),
                                                  Container(

                                                    child: Text(
                                                      "  "+selectedDate.year.toString(),
                                                      style: TextStyle(fontSize: 26.0),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),

                                            IconButton(
                                              icon: Icon(Icons.calendar_today, size: 20.0),
                                              visualDensity: VisualDensity.compact,
                                              onPressed:  () {
                                                showMonthPicker(

                                                  selectedMonthBackgroundColor: Colors.lightBlueAccent,
                                                  selectedMonthTextColor: Colors.white,
                                                  unselectedMonthTextColor: Colors.black,
                                                  headerTextColor: Colors.white,
                                                  headerColor: Colors.black,
                                                  context: context,
                                                  firstDate:kFirstDay,
                                                  lastDate: kLastDay,
                                                  initialDate: selectedDate,

                                                ).then((date) {
                                                  if (date != null) {
                                                    setState(() {
                                                      selectedDate = date;
                                                    });
                                                  }
                                                });

                                              },
                                            ),


                                            const Spacer(),
                                            IconButton(
                                              icon: Icon(Icons.chevron_left),
                                              onPressed:  () {
                                                setState(() {
                                                  if(kFirstDay.compareTo(DateTime.utc(_focusedDay.year,_focusedDay.month-1,_focusedDay.day))!=1 &&
                                                      kLastDay.compareTo(DateTime.utc(_focusedDay.year,_focusedDay.month-1,_focusedDay.day))!=-1)
                                                    selectedDate=DateTime.utc(_focusedDay.year,_focusedDay.month-1,_focusedDay.day);
                                                });

                                                _pageController.previousPage(

                                                  duration: Duration(milliseconds: 300),
                                                  curve: Curves.easeOut,

                                                );
                                              },
                                            ),
                                            IconButton(
                                              icon: Icon(Icons.chevron_right),
                                              onPressed:() {

                                                setState(() {


                                                  if(kFirstDay.compareTo(DateTime.utc(_focusedDay.year,_focusedDay.month+1,_focusedDay.day))!=1 &&
                                                      kLastDay.compareTo(DateTime.utc(_focusedDay.year,_focusedDay.month+1,_focusedDay.day))!=-1)
                                                    selectedDate=DateTime.utc(_focusedDay.year,_focusedDay.month+1,_focusedDay.day);

                                                });
                                                _pageController.nextPage(
                                                  duration: Duration(milliseconds: 300),
                                                  curve: Curves.easeOut,

                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 15,bottom:15,left: 0,right: 15),
                                        child: Container(

                                          child: TableCalendar<Event>(

                                            onCalendarCreated: (controller) => _pageController = controller,
                                            headerVisible: false,
                                            pageAnimationEnabled: true,

                                            weekendDays: [7],
                                            currentDay:DateTime.now(),
                                            headerStyle: const HeaderStyle(
                                              titleCentered: true,
                                              titleTextStyle:
                                              TextStyle(color: Colors.white, fontSize: 20.0),
                                              decoration: BoxDecoration(
                                                  color: Colors.blueAccent,
                                                  borderRadius: BorderRadius.only(
                                                      topLeft: Radius.circular(0),
                                                      topRight: Radius.circular(0))),
                                              formatButtonVisible: false,
                                              leftChevronIcon: Icon(
                                                Icons.chevron_left,
                                                color: Colors.white,
                                                size: 28,
                                              ),
                                              rightChevronIcon: Icon(
                                                Icons.chevron_right,

                                                color: Colors.white,
                                                size: 28,
                                              ),

                                            ),






                                            daysOfWeekStyle: const DaysOfWeekStyle(
                                              // Weekend days color (Sat,Sun)

                                            ),

                                            firstDay: kFirstDay,
                                            lastDay: kLastDay,
                                            focusedDay:  selectedDate,
                                            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                                            rangeStartDay: _rangeStart,
                                            rangeEndDay: _rangeEnd,

                                            rangeSelectionMode: _rangeSelectionMode,
                                            eventLoader: (a){return _getEventsForDay(a);},
                                            startingDayOfWeek: StartingDayOfWeek.sunday,
                                            calendarBuilders: CalendarBuilders(

                                                dowBuilder: (context, day) {
                                                  if (day.weekday == DateTime.sunday) {
                                                    final text = DateFormat.E().format(day);

                                                    return Center(
                                                      child: Text(
                                                        text,
                                                        style: TextStyle(color: Colors.red),
                                                      ),
                                                    );
                                                  }
                                                },
                                                markerBuilder: (context,day,event){
                                                  return (event.length>0)?Center(
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(top:30.0,left: 30),
                                                      child: Container(

                                                        height: 20,
                                                        decoration: BoxDecoration(
                                                          boxShadow: [


                                                          ],
                                                          color:Color.fromARGB(
                                                              255,52, 30, 157),
                                                          borderRadius: BorderRadius.circular(2),

                                                        ),
                                                        child: Padding(
                                                          padding: const EdgeInsets.symmetric(vertical: 2.0,horizontal: 4),
                                                          child: Text(
                                                            event.length.toString(),textAlign: TextAlign.center,
                                                            style:GoogleFonts.poppins(textStyle:TextStyle(color: Colors.white,fontWeight: FontWeight.bold,)),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ):SizedBox();
                                                }
                                            ),
                                            
                                            calendarStyle: CalendarStyle(
                                              selectedDecoration: BoxDecoration(
                                                color: Color.fromARGB(255, 83, 113, 255),shape: BoxShape.circle
                                              ),
                                              selectedTextStyle: GoogleFonts.aBeeZee(textStyle:TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 15)),
                                              weekNumberTextStyle: GoogleFonts.poppins(textStyle:TextStyle(color: Colors.black,fontWeight: FontWeight.bold,)),
                                              weekendTextStyle: GoogleFonts.poppins(textStyle:TextStyle(color: Colors.redAccent,fontWeight: FontWeight.bold,)),
                                              holidayTextStyle: GoogleFonts.poppins(textStyle:TextStyle(color: Colors.redAccent,fontWeight: FontWeight.bold,)),
                                              defaultTextStyle: GoogleFonts.poppins(textStyle:TextStyle(color: Colors.black,fontWeight: FontWeight.bold,))
                                              // marker
                                            ),
                                            onDaySelected: _onDaySelected,

                                            onFormatChanged: (format) async{


                                              if (_calendarFormat != format) {
                                                setState(() {
                                                  _calendarFormat = format;
                                                });
                                              }
                                            },
                                            onPageChanged: (focusedDay) {
                                              setState(() {
                                                _focusedDay = focusedDay;
                                              });

                                            },
                                          ),
                                        ),
                                      ),
                                    ],

                                  ),
                                ),
                              ),


                              const SizedBox(height: 15.0),

                              Container(

                                decoration:BoxDecoration(

                                    //color: Color.fromARGB(255, 199, 255, 247),
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))
                                ),
                                child: Column(

                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 0,vertical: 0),
                                      //SizedBox Widget
                                      child: SizedBox(


                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              'Today Events',

                                              style:GoogleFonts.poppins(textStyle:TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 25)),textAlign: TextAlign.center,
                                            ),
                                          ), //Text
                                        ), //Card
                                      ), //SizedBox
                                    ),
                                    ValueListenableBuilder<List<Event>>(
                                      valueListenable: _selectedEvents,
                                      builder: (BuildContext context, List<Event> value,child) {
                                        return ListView.builder(
                                          shrinkWrap: true,
                                          physics: NeverScrollableScrollPhysics(),
                                          itemCount: value.length,
                                          itemBuilder: (context, index) {

                                            return Container(
                                              margin: const EdgeInsets.symmetric(
                                                horizontal: 12.0,
                                                vertical: 4.0,
                                              ),

                                              decoration: BoxDecoration(
                                                //color: Colors.white,
                                                borderRadius: BorderRadius.circular(12.0),
                                                border: Border.all(color: Colors.white)
                                              ),
                                              child: ListTile(
                                                // onTap: () => print('${value[index]}'),
                                                title: Row(
                                                  children: [
                                                    Icon(Icons.play_arrow,color: colour[index%4],),SizedBox(width: 5,),
                                                    Text('${value[index]}',style:GoogleFonts.poppins(textStyle:TextStyle(color: Colors.white,fontWeight: FontWeight.w600,)),),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );


                      }
                      else{
                        return LinearProgressIndicator();

                      }
                    }
                ),


              ],
            )




      ),
    );
  }
}
