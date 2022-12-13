import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gymbro/constants/appcolors.dart';
import 'package:gymbro/extensions/context_extension.dart';
import 'package:gymbro/ui/start_workout_page.dart';

import '../models/image_model.dart';
import '../models/workout_model.dart';
import '../providers/fetch_state.dart';
import '../providers/move_provider.dart';

class WorkoutListPage extends ConsumerStatefulWidget {
  WorkoutListPage({
    super.key,
    required this.workouts,
    required this.indexA,
  });

  List<WorkoutModel> workouts;
  int indexA;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _WorkoutListPageState();
}

List<bool> boolList = [];

class _WorkoutListPageState extends ConsumerState<WorkoutListPage> {
  @override
  Widget build(BuildContext context) {
    final moveIMG = ref.watch(getImagesProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Program ${widget.indexA + 1}'),
        backgroundColor: AppColors.firstBlack,
      ),
      body: SafeArea(
          child: Expanded(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.max,
            children: [
              Builder(builder: (context) {
                if (moveIMG is Fetched<List<ImageModel>>) {
                  final value = moveIMG.value;
                  final zeroList = List<bool>.filled(
                    widget.workouts[widget.indexA].workouts.length,
                    false,
                  );
                  boolList.clear();
                  boolList.addAll(zeroList);

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Programa başla',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            IconButton(
                                onPressed: () {
                                  context.go(StartWorkoutPage(
                                    workoutModel:
                                        widget.workouts[widget.indexA],
                                    indexA: widget.indexA,
                                    imageModel: value,
                                  ));
                                },
                                icon: const Icon(
                                  Icons.play_circle,
                                  size: 40,
                                )),
                          ],
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: ((context, index) {
                          return Card(
                              color: AppColors.white,
                              elevation: 10,
                              child: IgnorePointer(
                                ignoring: boolList[index],
                                child: ExpansionTile(
                                  key: GlobalKey(),
                                  textColor: AppColors.danger,
                                  iconColor: AppColors.danger,
                                  title: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(widget
                                            .workouts[widget.indexA]
                                            .workouts[index]
                                            .name),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Row(
                                        children: [
                                          Text(widget.workouts[widget.indexA]
                                              .workouts[index].setc
                                              .toString()),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          const Text('X'),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(widget.workouts[widget.indexA]
                                              .workouts[index].repeat
                                              .toString()),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  children: [
                                    Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Image.network(
                                              value[widget
                                                          .workouts[
                                                              widget.indexA]
                                                          .workouts[index]
                                                          .id -
                                                      1]
                                                  .move_img
                                                  .toString(),
                                              height: 200,
                                            ),
                                            Text(
                                                'Etkilediği Bölge : ${widget.workouts[widget.indexA].workouts[index].area}')
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ));
                        }),
                        itemCount:
                            widget.workouts[widget.indexA].workouts.length,
                      ),
                    ],
                  );
                } else if (moveIMG is FetchError) {
                  print("er");
                } else if (moveIMG is Fetching) {
                  print("burdayım");
                }
                return const Align(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator());
              }),
            ],
          ),
        ),
      )),
    );
  }
}
