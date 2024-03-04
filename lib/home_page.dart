import 'package:flutter/material.dart';
import 'package:splash_screen/how_model.dart';

import 'salat_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLongPressed = false;
  int indexState = 0;
  List<SalatModel> salawat = [
    SalatModel(
        salat: "Fajr",
        rakaat: 2,
        image: "assets/fajr.png",
        isLongPressed: false),
    SalatModel(
        salat: "Dohr",
        rakaat: 4,
        image: "assets/dohr.png",
        isLongPressed: false),
    SalatModel(
        salat: "Asr", rakaat: 4, image: "assets/asr.png", isLongPressed: false),
    SalatModel(
        salat: "Magreb",
        rakaat: 3,
        image: "assets/maghreb.png",
        isLongPressed: false),
    SalatModel(
        salat: "3icha",
        rakaat: 4,
        image: "assets/3icha.png",
        isLongPressed: false)
  ];
  List<HowModel> steps = [
    HowModel(step: "wodo2", image: "assets/1.png"),
    HowModel(step: "Takbir", image: "assets/2.jpg"),
    HowModel(step: "Taslim", image: "assets/3.jpg"),
    HowModel(step: "Do3a2", image: "assets/4.jpg")
  ];

  int isFirstTimeRotated = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Salatuk'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            for (int index = 0; index < salawat.length; index++)
              InkWell(
                  onTap: () {
                    String text = "${salawat[index].rakaat}";
                    ScaffoldMessenger.of(context).removeCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      margin: EdgeInsets.fromLTRB(50, 0, 50, 20),
                      content:
                          Text("Rakaat :$text", textAlign: TextAlign.center),
                    ));
                  },
                  onLongPress: () {
                    isFirstTimeRotated=0;
                    print(index);
                    setState(() {
                      salawat[index].isLongPressed =
                          !salawat[index].isLongPressed;
                    });
                  },
                  child: !salawat[index].isLongPressed
                      ? TweenAnimationBuilder(
                          tween: Tween<double>(begin: 0.0, end: 1.0),
                          duration: Duration(seconds: 1),
                          builder: (context, value, child) {
                            print(value);
                            return Transform.rotate(
                              angle: isFirstTimeRotated *
                                  value *
                                  2 *
                                  3.141592653589793, // 2π radians = 360 degrees

                              child: Container(
                                height: 400,
                                margin: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.purple)),
                                child: Column(
                                  children: [
                                    Text(
                                      salawat[index].salat,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          backgroundColor: Colors.deepPurple),
                                    ),
                                    Image.asset(salawat[index].image),
                                    // index != salawat.length - 1
                                    //     ? Divider(
                                    //         color: Colors.purple,
                                    //         thickness: 10,
                                    //       )
                                    //     : SizedBox()
                                  ],
                                ),
                              ),
                            );
                          })
                      : SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Container(
                            margin: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.purple)),
                            child: Row(
                              children: [
                                for (int index = 0;
                                    index < steps.length;
                                    index++)
                                  Column(
                                    children: [
                                      SizedBox(
                                          height: 400,
                                          child: Image.asset(
                                            steps[index].image,
                                          )),
                                      Text(
                                        steps[index].step,
                                        style: const TextStyle(
                                            fontSize: 20,
                                            backgroundColor:
                                                Colors.purpleAccent),
                                      ),
                                    ],
                                  )
                              ],
                            ),
                          ),
                        ))
          ],
        ),
      ),
    );
  }
}
