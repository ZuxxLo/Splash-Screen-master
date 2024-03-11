import 'package:flutter/material.dart';
import 'package:splash_screen/how_model.dart';
import 'package:splash_screen/salat_details.dart';

import 'salat_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isDoubleClicked = false;
  int indexState = 0;
  List<SalatModel> salawat = [
    SalatModel(
        salat: "Fajr",
        rakaat: 2,
        image: "assets/fajr.png",
        salatDescription:
            "Salat Sobh ou salat Fajr est une prière pratiquée par les musulmans entre l'aube et le lever du soleil. C'est la première, ou la troisième, des cinq prières quotidiennes appelées salat. Elle comprend deux rak'ah. ",
        isDoubleClicked: false),
    SalatModel(
        salat: "Dohr",
        rakaat: 4,
        image: "assets/dohr.png",
        salatDescription:
            "Salat Dhuhr est une prière pratiquée par les musulmans juste après que le soleil passe au zénith. C'est la deuxième, ou la quatrième, des cinq prières quotidiennes appelées salat. Le vendredi elle est remplacée par la prière du vendredi à la mosquée. Elle comprend quatre rak'ahs.",
        isDoubleClicked: false),
    SalatModel(
        salat: "Asr",
        rakaat: 4,
        salatDescription:
            "Salat Asr est une prière pratiquée par les musulmans lorsque le soleil est à mi-chemin entre le zénith et le coucher. C'est la troisième, ou la cinquième, des cinq prières quotidiennes appelées salat.",
        image: "assets/asr.png",
        isDoubleClicked: false),
    SalatModel(
        salat: "Maghrib",
        rakaat: 3,
        salatDescription:
            "Salat Maghrib est une prière pratiquée par les musulmans entre le coucher du soleil et la tombée de la nuit. C'est la quatrième, ou la première, des cinq prières quotidiennes appelées salat. ",
        image: "assets/maghreb.png",
        isDoubleClicked: false),
    SalatModel(
        salat: "3icha",
        rakaat: 4,
        salatDescription:
            "Salat Icha est une prière pratiquée par les musulmans après la tombée de la nuit. C'est la cinquième, ou la deuxième, des cinq prières quotidiennes obligatoires appelées salat. ",
        image: "assets/3icha.png",
        isDoubleClicked: false)
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
                  onLongPress: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              SalatDetails(salatModel: salawat[index]),
                        ));
                  },
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
                  onDoubleTap: () {
                    isFirstTimeRotated = 0;
                    print(index);
                    setState(() {
                      salawat[index].isDoubleClicked =
                          !salawat[index].isDoubleClicked;
                    });
                  },
                  child: !salawat[index].isDoubleClicked
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
