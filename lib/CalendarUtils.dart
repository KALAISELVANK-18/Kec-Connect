

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

/// Example event class.
class Event {
  final String title;

  const Event(this.title);

  @override
  String toString() => title;

}



Future<Map<DateTime, List<Event>>> dod() async{
  final kEvents = <DateTime, List<Event>>{}; // Explicitly specify the map type.

  await FirebaseFirestore.instance
      .collection('Calendar Events').get()
      .then((QuerySnapshot documentSnapshot) {

      var data;
      List<dynamic>? str;


      data = documentSnapshot.docs;
      str=data as List<DocumentSnapshot>;

      for (int i = 0;i < str.length; i++) {
                print(str[i]["date"]);
              kEvents[str[i]["date"]] = str[i]["event"];
              print(kEvents[str[i]["date"]]);
            }

        });

  return kEvents;
}

var kEvents = dod();
final kToday = DateTime.now();
final kFirstDay = DateTime(2023, 10, 1);
final kLastDay = DateTime(2024, 6, 10);

