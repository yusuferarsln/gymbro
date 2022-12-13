import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gymbro/constants/appcolors.dart';
import 'package:gymbro/extensions/context_extension.dart';
import 'package:gymbro/models/workout_model.dart';
import 'package:gymbro/ui/workout_list_page.dart';

import '../providers/fetch_state.dart';
import '../providers/move_provider.dart';
import '../services/api_service.dart';

class WorkoutPage extends ConsumerStatefulWidget {
  const WorkoutPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MainDashboardPageState();
}

class _MainDashboardPageState extends ConsumerState<WorkoutPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await fun1();
      await fun2(userID);

      ref.read(getProgramProvider.notifier).fetch(gymID, userID);
    });
  }

  int userID = 0;
  int gymID = 0;

  Future<void> fun1() async {
    final bla = await api.getUserID();
    fun2(bla);
    setState(() {
      userID = bla;
    });
  }

  Future<void> fun2(int userID) async {
    final bla = await api.getGymID(userID);
    setState(() {
      gymID = bla;
    });
  }

  List<bool> boolList = [];

  @override
  Widget build(BuildContext context) {
    final workouts = ref.watch(getProgramProvider);

    print(gymID);
    print(userID);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.firstBlack,
        title: const Text('Programlarım'),
        actions: [
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
                onPressed: () {
                  ref.read(getProgramProvider.notifier).fetch(gymID, userID);
                },
                icon: const Icon(Icons.refresh)),
          ),
        ],
      ),
      body: SafeArea(
          child: SingleChildScrollView(
              child: Column(
        children: [
          Builder(builder: (context) {
            if (workouts is Fetched<List<WorkoutModel>>) {
              final value = workouts.value;
              print('this is value ');
              print(value);

              return ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  print(value[index].workouts[0].id);
                  print('sa');
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Card(
                      color: AppColors.secondWhite,
                      elevation: 8,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SizedBox(
                          height: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Program ID : ${index + 1}',
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                    onPressed: () async {
                                      context.go((WorkoutListPage(
                                        workouts: value,
                                        indexA: index,
                                      )));
                                      ref
                                          .read(getImagesProvider.notifier)
                                          .fetch();
                                    },
                                    icon: const Icon(Icons.display_settings),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
                itemCount: value.length,
              );
            } else if (workouts is FetchError) {
              return const Center(
                child: Text('Görüntülenecek program yok'),
              );
            } else if (workouts is Fetching) {
              return const Center(child: CircularProgressIndicator());
            }
            return const Text('Programlarınızı göremiyorsanız yenileyin');
          }),
        ],
      ))),
    );
  }
}
