import 'package:splash_screen/Note%20it/db_helper.dart';
import 'package:splash_screen/Note%20it/note_model.dart';
import 'package:sqflite/sqflite.dart';

class Db {
  final tableName = "notes";

  createTable(Database database) async {
    await database.execute("""CREATE TABLE IF NOT EXISTS $tableName (
        "id" INTEGER NOT NULL, 
        "note" TEXT NOT NULL,
        "date" TEXT NOT NULL,
        PRIMARY KEY ("id" AUTOINCREMENT));""");
  }

  create({required NoteModel note}) async {
    final database = await DatabaseHelper().dataBase;
    return await database.rawInsert(
        '''INSERT INTO $tableName (note, date) VALUES (?, ?)''',
        [note.noteText, note.noteDate]);
  }

  delete({required NoteModel note}) async {
    print(note.id);
    final database = await DatabaseHelper().dataBase;
    return await database
        .delete(tableName, where: "id=?", whereArgs: [note.id]);
  }

  clearNotesTable() async {
    final database = await DatabaseHelper().dataBase;

    return await database.rawDelete("DELETE FROM $tableName");
  }

  Future<List<NoteModel>> getAllNotes() async {
    final database = await DatabaseHelper().dataBase;
    final notes =
        await database.rawQuery('''SELECT * FROM $tableName ORDER BY (date)''');

    return notes.map((e) => NoteModel.fromMap(e)).toList();
  }
}
