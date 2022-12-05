import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gymbro/extensions/context_extension.dart';
import 'package:gymbro/models/gym_model.dart';
import 'package:gymbro/providers/fetch_state.dart';
import 'package:gymbro/providers/gym_provider.dart';
import 'package:gymbro/ui/sign_in_page.dart';
import 'package:gymbro/ui/widgets/gym_tiles.dart';

import '../services/firebase_authenticate.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    final gymNotifier = ref.read(gymProvider.notifier);
    final gymState = ref.watch(gymProvider);

    ref.listen(gymProvider, (previous, next) {
      if (next is Fetched<List<GymModel>>) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('asdfadsf')));
      }
    });
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                await auth.authSignOut();
                context.replace(const SignInPage());
              },
              icon: const Icon(Icons.logout)),
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
          ElevatedButton(
              onPressed: () {
                context.go(const SignInPage());
              },
              child: const Text('go')),
          Builder(builder: (context) {
            if (gymState is Fetched<List<GymModel>>) {
              final records = gymState.value;
              return Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return GymTiles(records: records, index: index);
                  },
                  itemCount: records.length,
                ),
              );
            } else {
              return const Text('loading');
            }
          }),
        ],
      )),
    );
  }
}
