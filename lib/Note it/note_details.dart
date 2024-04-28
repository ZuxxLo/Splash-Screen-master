import 'package:flutter/material.dart';

import 'package:splash_screen/Note%20it/note_model.dart';

import '../main.dart';

class NoteDetails extends StatefulWidget {
  final NoteModel note;

  const NoteDetails({
    Key? key,
    required this.note,
  }) : super(key: key);

  @override
  State<NoteDetails> createState() => _NoteDetailsState();
}

class _NoteDetailsState extends State<NoteDetails>
    with WidgetsBindingObserver, RouteAware {
  @override
  Widget build(BuildContext context) {
    @override
    void initState() {
      super.initState();
      WidgetsBinding.instance.addObserver(this);
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Details"),
        actions: [
          IconButton(
              onPressed: () {
                speakText(widget.note.noteText);
              },
              icon: const Icon(Icons.graphic_eq)),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          Align(
              alignment: Alignment.centerLeft,
              child: Text(widget.note.noteDate.toString())),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.deepPurpleAccent)),
            child: Center(
                child: Text(
              widget.note.noteText,
              style: const TextStyle(fontSize: 20),
            )),
          ),
        ],
      ),
    );
  }
}
