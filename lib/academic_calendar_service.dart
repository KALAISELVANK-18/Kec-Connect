import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kecconnect/calendar_model.dart';


class AcademicCalanderService {
  Future<List<String>> getdataOfParticularDay(DateTime day) async {
    List<String> events = [];
    await FirebaseFirestore.instance
        .collection('Calendar events')
        .where('date',
        isGreaterThanOrEqualTo:
        DateTime(day.year, day.month, day.day - 1, 23, 59, 59))
        .where('date',
        isLessThanOrEqualTo: DateTime(day.year, day.month, day.day + 1))
        .get(const GetOptions(source: Source.cache))
        .then((documentSnapshot) {
      if (documentSnapshot.docs.isEmpty) {
        FirebaseFirestore.instance
            .collection('Calendar events')
            .where('date',
            isGreaterThanOrEqualTo:
            DateTime(day.year, day.month, day.day - 1, 23, 59, 59))
            .where('date',
            isLessThanOrEqualTo: DateTime(day.year, day.month, day.day + 1))
            .get(const GetOptions(source: Source.server))
            .then((value) {
          for (var element in value.docs) {
            List<dynamic> e = element.data()['event'];
            for (var element in e) {
              events.add(element.toString());
            }
          }
        });
      } else {
        for (var element in documentSnapshot.docs) {
          List<dynamic> e = element.data()['event'];
          for (var element in e) {
            events.add(element.toString());
          }
        }
      }
    });
    return events;
  }

  Future<List<DateEvent>> getAllData() async {
    List<DateEvent> allData = [];
    Query<Map<String, dynamic>> documentReference = FirebaseFirestore.instance
        .collection("Calendar events")
        .where("date",
        isGreaterThanOrEqualTo:
        Timestamp.fromDate(DateTime.utc(2023, 10, 01)))
        .where("date",
        isLessThanOrEqualTo:
        Timestamp.fromDate(DateTime.utc(2025, 09, 30)));

    await documentReference
        .get(const GetOptions(source: Source.cache))
        .then((documentSnapshot) {
      if (documentSnapshot.docs.isEmpty) {
        documentReference
            .get(const GetOptions(source: Source.server))
            .then((value) {
          for (var element in value.docs) {
            Timestamp x = element.data()['date'];
            List<String> a = [];
            List<dynamic> y = element.data()['event'];
            for (var element in y) {
              a.add(element.toString());
            }
            allData.add(DateEvent(date: x.toDate(), event: a));
          }
        });
      } else {
        for (var element in documentSnapshot.docs) {
          Timestamp x = element.data()['date'];
          List<String> a = [];
          List<dynamic> y = element.data()['event'];
          for (var element in y) {
            a.add(element.toString());
          }
          allData.add(DateEvent(date: x.toDate(), event: a));
        }
      }
    });
    return allData;
  }
}