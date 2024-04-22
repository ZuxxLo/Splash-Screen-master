 
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:splash_screen/bmi%20app/bmihome1.dart';

import 'salat_model.dart';

 
class SalatDetails extends StatefulWidget {
  const SalatDetails({
    Key? key,
    required this.salatModel,
  }) : super(key: key);

  final SalatModel salatModel;

  @override
  State<SalatDetails> createState() => _SalatDetailsState();
}

class _SalatDetailsState extends State<SalatDetails> {
  PlayerState isPlaying = PlayerState.playing;
  bool isPlayingbool = true;

  final player = AudioPlayer();

  // playAudio() async {
  //   String audioasset = "assets/nature_sounds.mp3";
  //   ByteData bytes = await rootBundle.load(audioasset); //load audio from assets
  //   Uint8List audiobytes =
  //       bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);
  //   await player.play(BytesSource(audiobytes));
  //   player.setReleaseMode(ReleaseMode.loop);
  // }

  // stopAudio() async {
  //   await player.stop();
  // }

  // pauseAudio() async {
  //   isPlayingbool = false;
  //   await player.pause();
  // }

  // resumeAudio() async {
  //   isPlayingbool = true;

  //   await player.resume();
  // }

  // @override
  // void initState() {
  //   playAudio();
  //   setState(() {
  //     player.onPlayerStateChanged.listen((event) {
  //       isPlaying = event;
  //       isPlayingbool = event == PlayerState.playing;
  //     });
  //   });

  //   super.initState();
  // }

  // @override
  // void dispose() {
  //   player.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.salatModel.salat),
        // actions: [
        //   IconButton(
        //       onPressed: () {
        //         if (isPlayingbool)
        //           pauseAudio();
        //         else
        //           resumeAudio();

        //         setState(() {});
        //       },
        //       icon: Icon((isPlayingbool ? Icons.pause : Icons.play_arrow))),
        // ],
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(20),
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(border: Border.all(color: Colors.purple)),
          child: Column(children: [
            Image.asset(widget.salatModel.image),
            Text(
              "Description",
              style: TextStyle(
                  color: purpleColorAccent,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            Text(
              widget.salatModel.salatDescription,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.italic),
            )
          ]),
        ),
      ),
    );
  }
}
