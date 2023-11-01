import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:table_calendar/table_calendar.dart';

import 'CalendarUtils.dart';

class HomeCalendarPage extends StatefulWidget {
  @override
  _HomeCalendarPageState createState() => _HomeCalendarPageState();
}

class _HomeCalendarPageState extends State<HomeCalendarPage> {
  DateTime selectedDate=DateTime.now();
  final List<String> mont=['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
  @override


  late final PageController _pageController ;
  final List<DateTime> gg=[DateTime.utc(2019,6,5)];
  late  List<Event> _selectedEvents=[];
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
      .toggledOff; // Can be toggled on/off by longpressing a date
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay ;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

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

  // List<Event> _getEventsForDay(DateTime day) {
  //   // Implementation example
  //   return kEvents[day] ?? [];
  // }









  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("cddf"),
      ),
      body: Column(
        children: [

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                const SizedBox(width: 16.0),
                SizedBox(
                  width: 140.0,
                  child: Text(
                    mont[selectedDate.month-1].toString()+"  "+selectedDate.year.toString(),
                    style: TextStyle(fontSize: 26.0),
                  ),
                ),

                IconButton(
                  icon: Icon(Icons.calendar_today, size: 20.0),
                  visualDensity: VisualDensity.compact,
                  onPressed:  () {
                    showMonthPicker(
                      context: context,
                      firstDate:DateTime.utc(2020,12,12),
                      lastDate: DateTime.now(),
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

                      {print(selectedDate.month);
                      selectedDate=DateTime.utc(_focusedDay.year,_focusedDay.month+1,_focusedDay.day);}

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

          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('Calendar events').snapshots(),
              builder: (context, AsyncSnapshot snapshot) {
                final Map<DateTime, List<Event>> kEvents = {};
                if(snapshot.hasData){


                  List<Event> _getEventsForDay(DateTime day) {
                    // Implementation example
                    setState(() {
                      _selectedEvents = kEvents[day] ?? [];
                    });


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
                      _selectedEvents = _getEventsForDay(selectedDay);
                    });
                  }

                  List<DocumentSnapshot> data;
                  List<dynamic>? str;


                  data = snapshot.data.docs;
                  str=data as List<DocumentSnapshot>;

                  for (int i = 0;i < str.length; i++) {
                    // print((str[i]["date"] as Timestamp).toDate());
                    List<Event> dynamics=[];
                    for(int j=0;j<str[i]["event"].length;j++){
                      dynamics.add(Event(str[i]["event"][j]));
                    }
                    kEvents[(str[i]["date"] as Timestamp).toDate()] = dynamics;
                    // print(kEvents[(str[i]["date"] as Timestamp).toDate()]);
                  }



                  if(kEvents.length>0 && _selectedEvents.length>0){

                    return

                      Column(
                        children: [
                          Container(

                            child: TableCalendar<Event>(

                              onCalendarCreated: (controller) => _pageController = controller,
                              headerVisible: false,
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





                              calendarBuilders: CalendarBuilders(

                                markerBuilder: (context,day,events){
                                  return Center(
                                    child: Text(events.length.toString()),
                                  );
                                }
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
                              calendarStyle: CalendarStyle(

                                // Use `CalendarStyle` to customize the UI
                                weekendTextStyle: TextStyle(color: Colors.red,fontSize: 16),
                                holidayTextStyle: TextStyle(color: Colors.red),
                                defaultTextStyle: TextStyle(color: Colors.black),

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

                          const SizedBox(height: 8.0),

                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 0,vertical: 0),
                            //SizedBox Widget
                            child: SizedBox(
                              width: 80.0,
                              height: 40.0,
                              child: Card(
                                color: Colors.blueAccent,
                                child: Center(
                                  child: Text(
                                    'Events',

                                    style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                                  ), //Text
                                ), //Center
                              ), //Card
                            ), //SizedBox
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: _selectedEvents.length,
                            itemBuilder: (context, index) {

                              return Container(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 12.0,
                                  vertical: 4.0,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: ListTile(
                                  onTap: () => print('${_selectedEvents[index]}'),
                                  title: Text('${_selectedEvents[index]}'),
                                ),
                              );
                            },
                          )
                        ],
                      );
                  }
                  else{
                    return SizedBox();
                  }
                }
                else{
                  return SizedBox();
                  print(1);
                }
              }
          ),






          // Expanded(
          //   child: ValueListenableBuilder<List<Event>>(
          //     valueListenable: _selectedEvents,
          //     builder: (context, value, _) {
          //       return ListView.builder(
          //
          //         itemCount: value.length,
          //         itemBuilder: (context, index) {
          //           return Container(
          //             margin: const EdgeInsets.symmetric(
          //               horizontal: 12.0,
          //               vertical: 4.0,
          //             ),
          //             decoration: BoxDecoration(
          //               border: Border.all(),
          //               borderRadius: BorderRadius.circular(12.0),
          //             ),
          //             child: ListTile(
          //               onTap: () => print('${value[index]}'),
          //               title: Text('${value[index]}'),
          //             ),
          //           );
          //         },
          //       );
          //     },
          //   ),
          // ),


        ],
      ),
    );
  }
}
