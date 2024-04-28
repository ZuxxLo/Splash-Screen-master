import 'package:intl/intl.dart';

class NoteModel {
  int? id;
  String noteText;

  String noteDate;

  static dateFormat(DateTime date) {
    return DateFormat('EEEE, d MMM, yyyy – kk:mm:ss').format(date);
  }

  NoteModel({this.id, required this.noteText, required this.noteDate});

  factory NoteModel.fromMap(Map<String, dynamic> map) {
    return NoteModel(
        id: map["id"], noteText: map["note"], noteDate: map["date"]);
  }
}
