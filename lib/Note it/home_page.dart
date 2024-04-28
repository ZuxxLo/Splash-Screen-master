import 'package:flutter/material.dart';
import 'package:splash_screen/Note%20it/db.dart';
import 'package:splash_screen/Note%20it/note_details.dart';
import 'package:splash_screen/Note%20it/note_model.dart';

import '../main.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with WidgetsBindingObserver, RouteAware {
  @override
  void initState() {
    setState(() {});

    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context) as PageRoute);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPushNext() {
    stopSpeaking();
    super.didPushNext();
  }

  @override
  void didPopNext() {
    stopSpeaking();
    super.didPopNext();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        stopSpeaking();
        break;
      case AppLifecycleState.inactive:
        stopSpeaking();
        break;
      case AppLifecycleState.paused:
        stopSpeaking();
        break;
      case AppLifecycleState.detached:
        break;
      case AppLifecycleState.hidden:
        break;
    }
  }

  List<NoteModel> notesList = <NoteModel>[];
  addNote(NoteModel note) {
    setState(() {
      notesList.add(note);
      Db().create(note: note);
    });
    Navigator.pop(context);
  }

  deleteNote(index) {
    setState(() {
      Db().delete(note: notesList[index]);
      notesList.removeAt(index);
    });
    detailsIndex = 0;
    Navigator.pop(context);
  }

  int? detailsIndex;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Note it"),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      content: SizedBox(
                        height: 110,
                        child: Column(
                          children: [
                            const Text(
                                "Are you sure you want to delete all notes"),
                            const SizedBox(height: 20),
                            Row(
                              children: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text("Cancel")),
                                const SizedBox(width: 10),
                                TextButton(
                                    onPressed: () {
                                      setState(() {});
                                      Db().clearNotesTable();
                                      Navigator.pop(context);
                                    },
                                    child: const Text("Delete all notes"))
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.delete_forever))
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            NoteModel? note = NoteModel(
                noteText: "", noteDate: NoteModel.dateFormat(DateTime.now()));
            addTextNote(value) {
              note.noteText = value;
            }

            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                content: SizedBox(
                  height: 200,
                  child: Column(
                    children: [
                      const Text("Add note"),
                      TextField(
                        maxLines: 4,
                        onChanged: (value) {
                          addTextNote(value);
                        },
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          TextButton(
                              onPressed: () {
                                note.noteText = "";
                                Navigator.pop(context);
                              },
                              child: const Text("Cancel")),
                          const SizedBox(width: 10),
                          TextButton(
                              onPressed: () {
                                addNote(note);
                              },
                              child: const Text("Add note"))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        body: FutureBuilder(
          future: Db().getAllNotes(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              notesList = snapshot.data!;

              if (notesList.isEmpty) {
                return const Center(
                  child: Text(
                    "No notes",
                    style: TextStyle(color: Colors.black),
                  ),
                );
              } else {
                return OrientationBuilder(builder: (context, orientation) {
                  return Row(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: notesList.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  detailsIndex = index;
                                });
                              },
                              onDoubleTap: () {
                                goToDetailsPage(index);
                              },
                              onLongPress: () {
                                deleteDiagMeth(context, index);
                              },
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                margin:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 0),
                                decoration: BoxDecoration(
                                    color: Colors.deepPurpleAccent
                                        .withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: Colors.deepPurpleAccent)),
                                child: Text(notesList[index].noteText,
                                    style: const TextStyle(fontSize: 18)),
                              ),
                            );
                          },
                        ),
                      ),
                      MediaQuery.of(context).orientation ==
                                  Orientation.landscape &&
                              notesList.isNotEmpty &&
                              detailsIndex != null
                          ? SizedBox(
                              width: 270,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 100,
                                    width: 100,
                                    child: IconButton(
                                        onPressed: () {
                                          speakText(notesList[detailsIndex!]
                                              .noteText);
                                        },
                                        icon: const Icon(Icons.graphic_eq,
                                            size: 80.0)),
                                  ),
                                  Text(
                                    notesList[detailsIndex!]
                                        .noteDate
                                        .toString(),
                                    style:
                                        const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            )
                          : const SizedBox(),
                    ],
                  );
                });
              }
            }
          },
        ));
  }

  goToDetailsPage(index) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => NoteDetails(note: notesList[index]),
    ));
  }

  Future<dynamic> deleteDiagMeth(BuildContext context, int index) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: SizedBox(
          height: 110,
          child: Column(
            children: [
              const Text("Are you sure you want to delete this note"),
              const SizedBox(height: 20),
              Row(
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Cancel")),
                  const SizedBox(width: 10),
                  TextButton(
                      onPressed: () {
                        deleteNote(index);
                      },
                      child: const Text("Delete note"))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
