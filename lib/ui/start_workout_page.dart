import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gymbro/constants/appcolors.dart';
import 'package:gymbro/models/image_model.dart';
import 'package:gymbro/models/workout_model.dart';

class StartWorkoutPage extends ConsumerStatefulWidget {
  StartWorkoutPage(
      {super.key,
      required this.workoutModel,
      required this.imageModel,
      required this.indexA});
  WorkoutModel workoutModel;
  List<ImageModel> imageModel;
  int indexA;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _StartWorkoutPageState();
}

class _StartWorkoutPageState extends ConsumerState<StartWorkoutPage> {
  PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Program Başladı'),
          backgroundColor: AppColors.firstBlack,
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.firstBlack,
          onPressed: () {
            print(widget.workoutModel.workouts.length);
            if (pageController.page! <=
                widget.workoutModel.workouts.length - 2) {
              pageController.nextPage(
                duration: const Duration(milliseconds: 350),
                curve: Curves.ease,
              );
            } else {
              Navigator.pop(context);
            }
          },
          child: const Icon(Icons.skip_next),
        ),
        body: PageView(
          controller: pageController,
          physics: const NeverScrollableScrollPhysics(),
          onPageChanged: (value) {},
          children: widget.workoutModel.workouts.map((part) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 10,
                child: firstContainer(
                    part, widget.imageModel[part.id - 1].move_img),
              ),
            );
          }).toList(),
        ));
  }

  Padding firstContainer(Parts part, String? img) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Text(
            part.name,
            style: const TextStyle(fontSize: 20),
          ),
          Image.network(img!),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Set sayısı : ',
                style: TextStyle(fontSize: 20),
              ),
              Text(
                part.setc.toString(),
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                width: 10,
              ),
              const Text(
                'Tekrar sayısı : ',
                style: TextStyle(fontSize: 20),
              ),
              Text(
                part.repeat.toString(),
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
