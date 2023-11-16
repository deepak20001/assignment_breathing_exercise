// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:meditation_app/constants/assets_path.dart';
import 'package:meditation_app/screens/widgets/button_widget.dart';
import '../constants/app_constants.dart';

class BreathExerciseScreen extends StatefulWidget {
  final int time;
  const BreathExerciseScreen({
    Key? key,
    required this.time,
  }) : super(key: key);

  @override
  State<BreathExerciseScreen> createState() => _BreathExerciseScreenState();
}

class _BreathExerciseScreenState extends State<BreathExerciseScreen> {
  Timer? timer;
  late int seconds;
  bool isRunning = false;
  bool inhale = true;
  bool isPaused = false;

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (seconds > 0) {
        setState(() {
          seconds--;
          if (seconds != widget.time && seconds % 5 == 0) {
            inhale = !inhale;
          }
        });
      } else if (seconds == 0) {
        setState(() {
          stopTimer();
          seconds = widget.time;
          isRunning = false;
          inhale = true;
        });
      }
    });
  }

  void stopTimer() {
    setState(() => timer?.cancel());
  }

  void resetTimer() {
    setState(() {
      stopTimer();
      seconds = widget.time;
    });
  }

  @override
  void initState() {
    super.initState();
    seconds = widget.time;
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 300,
            width: 300,
            child: Stack(
              fit: StackFit.expand,
              children: [
                CircularProgressIndicator(
                  value: 1 - seconds / widget.time,
                  valueColor:
                      AlwaysStoppedAnimation(Colors.deepPurple.shade100),
                  backgroundColor: Colors.deepPurple,
                  strokeWidth: 12,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 15),
                      seconds == widget.time
                          ? const Text(
                              "Start Focus \n..BREATHING..",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            )
                          : inhale
                              ? Column(
                                  children: [
                                    Image.asset(
                                      AssetsPng.instance.inhale,
                                      height: 100,
                                    ),
                                    const SizedBox(height: 8),
                                    const Text("INHALE..."),
                                  ],
                                )
                              : Column(
                                  children: [
                                    Image.asset(
                                      AssetsPng.instance.exhale,
                                      height: 100,
                                    ),
                                    const SizedBox(height: 8),
                                    const Text("EXHALE..."),
                                  ],
                                ),
                      const SizedBox(height: 15),
                      Text(
                        seconds.toString(),
                        style: TextStyle(
                          fontSize: 90,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          timerButtons(),
        ],
      ),
    );
  }

  Center timerButtons() {
    return Center(
        child: isRunning == false
            ? ButtonWidget(
                title: "Start Timer",
                onPressed: () {
                  startTimer();
                  isRunning = !isRunning;
                  setState(() {});
                },
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: mq.width * .36,
                    child: isPaused == false
                        ? ButtonWidget(
                            title: "Pause Timer",
                            onPressed: () {
                              stopTimer();
                              // isRunning = !isRunning;
                              isPaused = !isPaused;
                              setState(() {});
                            },
                            btnColor: Colors.green.shade900,
                          )
                        : ButtonWidget(
                            title: "Play Timer",
                            onPressed: () {
                              startTimer();
                              isPaused = !isPaused;
                              setState(() {});
                            },
                            btnColor: Colors.lightGreen.shade500,
                          ),
                  ),
                  SizedBox(
                    width: mq.width * .36,
                    child: ButtonWidget(
                      title: "Reset Timer",
                      onPressed: () {
                        resetTimer();
                        isRunning = !isRunning;
                        setState(() {});
                      },
                      btnColor: Colors.red.shade900,
                    ),
                  ),
                ],
              ));
  }
}
