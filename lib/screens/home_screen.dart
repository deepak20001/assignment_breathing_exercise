// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:meditation_app/constants/assets_path.dart';
import 'package:meditation_app/screens/breath_exercise_screen.dart';

import '../constants/app_constants.dart';
import '../constants/routes.dart';
import 'widgets/button_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Breathing Exercise"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: mq.height * .06),
          Container(
            height: mq.height * .5,
            width: mq.width * .8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.deepPurple, width: 0.5),
            ),
            child: SvgPicture.asset(
              AssetsSvg.instance.meditate,
              fit: BoxFit.contain,
            ),
          ),
          const Spacer(),
          const Text(
            "Begin Focus Timer",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w300,
            ),
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ButtonWidget(
                title: "1 min",
                onPressed: () {
                  Routes.instance.push(
                      widget: const BreathExerciseScreen(time: 60),
                      context: context);
                },
              ),
              ButtonWidget(
                title: "2 min",
                onPressed: () {
                  Routes.instance.push(
                      widget: const BreathExerciseScreen(time: 120),
                      context: context);
                },
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ButtonWidget(
                title: "3 min",
                onPressed: () {
                  Routes.instance.push(
                      widget: const BreathExerciseScreen(time: 180),
                      context: context);
                },
              ),
              ButtonWidget(
                title: "5 min",
                onPressed: () {
                  Routes.instance.push(
                      widget: const BreathExerciseScreen(time: 300),
                      context: context);
                },
              ),
            ],
          ),
          SizedBox(
            height: mq.height * .08,
          )
        ],
      ),
    );
  }
}
