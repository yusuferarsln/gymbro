import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gymbro/models/gym_model.dart';
import 'package:gymbro/providers/fetch_state.dart';
import 'package:gymbro/providers/gym_provider.dart';
import 'package:gymbro/providers/user_provider.dart';
import 'package:gymbro/ui/widgets/gym_tiles.dart';

import '../constants/appcolors.dart';
import '../models/basic_user_model.dart';
import '../services/api_service.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fun1();
  }

  fun1() async {
    final bla = await api.getUserID();
    setState(() {
      userID = bla;
    });
  }

  int userID = 0;

  @override
  Widget build(BuildContext context) {
    final gymNotifier = ref.read(gymProvider.notifier);
    final gymState = ref.watch(gymProvider);
    final userState = ref.watch(userProvider);

    ref.listen(gymProvider, (previous, next) {
      if (next is Fetched<List<GymModel>>) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Spor Salonları Yüklendi')),
        );
      }
    });
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: const Text('Kayıtlı Spor Salonları'),
        backgroundColor: AppColors.firstBlack,
        actions: [
          Builder(builder: (context) {
            if (userState is Fetched<List<BasicUserModel>>) {
              final value = userState.value;
              userID = value[0].id;
            } else if (userState is FetchError) {
              print("er");
            } else if (userState is Fetching) {
              return const SizedBox.shrink();
            }
            return const SizedBox.shrink();
          }),
          IconButton(
              onPressed: () {
                gymNotifier.fetch();
              },
              icon: const Icon(Icons.refresh))
        ],
      ),
      body: SafeArea(
          child: Column(
        children: [
          Builder(builder: (context) {
            if (gymState is Fetched<List<GymModel>>) {
              final records = gymState.value;
              return Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    print(userID);
                    return GymTiles(
                      records: records,
                      index: index,
                      userID: userID,
                    );
                  },
                  itemCount: records.length,
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
        ],
      )),
    );
  }
}
