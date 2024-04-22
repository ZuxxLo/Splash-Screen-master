import 'package:intl/intl.dart';

class NoteModel {
  late String noteText;

  String noteDate = DateFormat('EEEE, d MMM, yyyy – kk:mm:ss').format(DateTime.now());

  NoteModel({
    noteText,
  });
}
