import 'package:flutter/material.dart';
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
    WidgetsBinding.instance!.addObserver(this);
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
        print("app in resumed");

        stopSpeaking();
        break;
      case AppLifecycleState.inactive:
        print("app in inactive");
        stopSpeaking();
        break;
      case AppLifecycleState.paused:
        print("app in paused");

        stopSpeaking();
        break;
    }
  }

  List<NoteModel> notesList = <NoteModel>[];
  addNote(NoteModel note) {
    setState(() {
      notesList.add(note);

      print(note.noteDate);
    });
    Navigator.pop(context);
  }

  deleteNote(index) {
    setState(() {
      notesList.removeAt(index);
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Note it"),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            NoteModel? note = NoteModel();
            addTextNote(value) {
              note.noteText = value;
            }

            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                content: Container(
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
                                note?.noteText = "";
                                Navigator.pop(context);
                              },
                              child: const Text("Cancel")),
                          const SizedBox(width: 10),
                          TextButton(
                              onPressed: () {
                                addNote(note!);
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
        body: Builder(builder: (context) {
          if (notesList.isEmpty) {
            return const Center(
              child: Text(
                "No notes",
                style: TextStyle(color: Colors.black),
              ),
            );
          } else {
            return ListView.builder(
              itemCount: notesList.length,
              itemBuilder: (context, index) {
                return OrientationBuilder(
                  builder: (context, orientation) {
                    print(orientation);
                    if (MediaQuery.of(context).orientation ==
                        Orientation.portrait) {
                      return InkWell(
                        onTap: () {
                          goToDetailsPage(index);
                        },
                        onLongPress: () {
                          deleteDiagMeth(context, index);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border:
                                  Border.all(color: Colors.deepPurpleAccent)),
                          child: Text(notesList[index].noteText!,
                              style: const TextStyle(fontSize: 18)),
                        ),
                      );
                    } else {
                      return InkWell(
                        onTap: () {
                          goToDetailsPage(index);
                        },
                        onLongPress: () {
                          deleteDiagMeth(context, index);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border:
                                  Border.all(color: Colors.deepPurpleAccent)),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(notesList[index].noteText!,
                                    style: const TextStyle(fontSize: 18)),
                              ),
                              Column(
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        speakText(notesList[index].noteText);
                                      },
                                      icon: const Icon(Icons.audiotrack)),
                                  Text(notesList[index].noteDate.toString()),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    }
                  },
                );
              },
            );
          }
        }));
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
        content: Container(
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
