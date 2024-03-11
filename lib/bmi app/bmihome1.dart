import 'dart:math';

 import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

Color purpleColor = Colors.purple;
Color purpleColorAccent = Colors.purpleAccent;

class _HomeState extends State<Home> {
  OutlineInputBorder borderDecor = OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide(color: purpleColor));
  valdator(value) {
    if (value!.isEmpty) {
      return "Please enter a value";
    }
    if (double.parse(value) == 0) {
      return "can't be 0";
    }
    if (double.parse(value) < 0) {
      return "Please enter a positive value";
    }

    return null;
  }

  bool canAffic = false;
  double? bmi;
  int? age = 0;
  double? height;
  double? weight;
  final formKey = GlobalKey<FormState>();
  String interpretBMI(double bmi) {
    if (bmi < 18.5) {
      return "underweight";
    } else if (bmi >= 18.5 && bmi < 25) {
      return "healthy";
    } else if (bmi >= 25.0 && bmi < 30) {
      return "خشين";
    } else {
      return "obesity";
    }
  }

  double calculatePosition(double bmi) {
    // Assuming that bmi ranges from 0 to 100
    return (bmi / 100) * (MediaQuery.of(context).size.width - 50);
  }

  selectGender(bool value) {
    genderMale = value;
    calculateBMI(genderMale, age!, height!, weight!);
  }

  ageInput(value) {
    bmi = null;
    age = double.parse(value).toInt();
  }

  heightInput(value) {
    bmi = null;

    height = double.parse(value);
  }

  weightInput(value) {
    bmi = null;

    weight = double.parse(value);
  }

  bool genderMale = true;

  double calculateBMI(bool genderMale, int age, double height, double weight) {
    double cmHei = height / 100;
    double bmiT = weight / (cmHei * cmHei);

    if (!genderMale) {
      bmiT += 1.5;
      bmiT -= (age > 30) ? ((age - 30) / 5) : 0;
    } else {
      bmiT += (age > 30) ? ((age - 30) / 5) : 0;
    }

    bmi = bmiT;
    print(bmi);

    return bmiT < 100 ? bmiT : 100;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BMI calcultor"),
        centerTitle: true,
      ),
      resizeToAvoidBottomInset: true,
      body: Form(
        key: formKey,
        child: Container(
          padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
          height: 800,
          child: Card(
            child: ListView(children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
                child: Row(
                  children: [
                    const Expanded(
                        child: Text(
                      "Your gender",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )),
                    ToggleButtons(
                        borderRadius: BorderRadius.circular(15),
                        isSelected: [
                          false,
                          false
                        ],
                        children: [
                          TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: genderMale
                                  ? purpleColor
                                  : Colors.grey.withOpacity(0.5),
                            ),
                            child: Icon(
                              Icons.male,
                              size: 35,
                              color:
                                  genderMale ? Colors.white : purpleColorAccent,
                            ),
                            onPressed: () {
                              setState(() {
                                selectGender(true);
                              });
                            },
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: !genderMale
                                  ? purpleColor
                                  : Colors.grey.withOpacity(0.5),
                            ),
                            child: Icon(
                              Icons.female,
                              size: 35,
                              color: !genderMale
                                  ? Colors.white
                                  : purpleColorAccent,
                            ),
                            onPressed: () {
                              setState(() {
                                selectGender(false);
                              });
                            },
                          ),
                        ]),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
                child: Row(
                  children: [
                    const Expanded(
                        child: Text(
                      "Your age",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )),
                    Flexible(
                        child: TextFormField(
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          labelText: "Enter your age",
                          focusedBorder: borderDecor,
                          errorMaxLines: 2,
                          border: borderDecor),
                      validator: (value) => valdator(value),
                      onChanged: (value) {
                        setState(() {});
                        ageInput(value);
                      },
                    )),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
                child: Row(
                  children: [
                    const Expanded(
                        child: Text(
                      "Your height",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )),
                    Flexible(
                        child: TextFormField(
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          labelText: "Enter your height",
                          suffixText: "cm",
                          focusedBorder: borderDecor,
                          border: borderDecor),
                      validator: (value) => valdator(value),
                      onChanged: (value) {
                        setState(() {});
                        heightInput(value);
                      },
                    )),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
                child: Row(
                  children: [
                    const Expanded(
                        child: Text(
                      "Your weight",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )),
                    Flexible(
                        child: TextFormField(
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          suffixText: "kg",
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          labelText: "Enter your weight",
                          focusedBorder: borderDecor,
                          border: borderDecor),
                      validator: (value) => valdator(value),
                      onChanged: (value) {
                        setState(() {});
                        weightInput(value);
                      },
                    )),
                  ],
                ),
              ),
              const SizedBox(height: 45),
              Padding(
                padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                child: TextButton.icon(
                    style: ButtonStyle(
                        fixedSize: const MaterialStatePropertyAll(Size(50, 50)),
                        textStyle: MaterialStateProperty.all(
                            const TextStyle(fontSize: 17)),
                        backgroundColor: MaterialStateProperty.all(purpleColor),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white)),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        print("object");
                        setState(() {
                          canAffic = true;
                          calculateBMI(genderMale, age!, height!, weight!);
                        });
                      }
                    },
                    icon: const Icon(Icons.calculate),
                    label: const Text("Calculate")),
              ),
              const SizedBox(height: 20),
              if (bmi != null)
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: Card(
                    color: Colors.grey.withOpacity(0.8),
                    child: Column(
                      children: [
                        const SizedBox(height: 50),
                        Center(
                          child: Text(
                            bmi!.toStringAsFixed(2),
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Center(
                          child: Text(
                            interpretBMI(bmi!),
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),

                        Stack(
                          clipBehavior: Clip.none,
                          alignment: Alignment.center,
                          children: [
                            Container(
                              height: 10,
                              width: double.maxFinite,
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  stops: [0, 0.25, 0.36, 0.4],
                                  
                                  colors: [
                                    Colors.red,
                                    Colors.green,
                                    Colors.blue,
                                    Colors.red
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              left: calculatePosition(bmi!),
                              child: Stack(
                                clipBehavior: Clip.none,
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    height: 26.0,
                                    width: 26.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.amber,
                                    ),
                                  ),
                                  Positioned(
                                    bottom: -10,
                                    child: Container(
                                      color: Colors.purple.withOpacity(0.5),
                                      child: Text(interpretBMI(bmi!)),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        // Slider(
                        //   divisions: 4,
                        //   value: bmi!,
                        //   label: interpretBMI(bmi!),
                        //   min: 0,
                        //   max: 100,
                        //   onChanged: (value) {},
                        // ),
                        const SizedBox(
                          height: 50,
                        ),

                        // )
                      ],
                    ),
                  ),
                )
              else
                SizedBox(),
              const SizedBox(height: 80),
            ]),
          ),
        ),
      ),
    );
  }
}
