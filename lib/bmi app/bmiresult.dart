import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  const Result({
    Key? key,
    required this.bmi,
  }) : super(key: key);
  final double bmi;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Affichage(bmi: bmi),
    );
  }
}

class Affichage extends StatelessWidget {
  const Affichage({
    super.key,
    required this.bmi,
  });

  final double bmi;

  @override
  Widget build(BuildContext context) {
    String interpretBMI(double bmi) {
      if (bmi < 18.5) {
        return "underweight";
      } else if (bmi >= 18.5 && bmi < 25) {
        return "healthy";
      } else if (bmi >= 25.0 && bmi < 30) {
        return "overweight";
      } else {
        return "obesity";
      }
    }

    double calculatePosition(double bmi) {
      // Assuming that bmi ranges from 0 to 100
      return (bmi / 100) * (MediaQuery.of(context).size.width - 26);
    }

    return Column(
      children: [
        const SizedBox(height: 50),
        Center(
          child: Text(
            bmi.toString(),
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        Center(
          child: Text(
            interpretBMI(bmi),
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
              width: 500,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0, 0.25, 0.5, 1],
                  colors: [Colors.red, Colors.green, Colors.blue, Colors.red],
                ),
              ),
            ),
            Positioned(
              left: calculatePosition(bmi),
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
                      color: Colors.grey.withOpacity(0.5),
                      child: Text(interpretBMI(bmi)),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
        Slider(
          divisions: 4,
          value: bmi,
          label: interpretBMI(bmi),
          min: 0,
          max: 100,
          onChanged: (value) {},
        ),
        const SizedBox(
          height: 50,
        ),

        // )
      ],
    );
  }
}
