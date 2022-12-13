import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gymbro/constants/appcolors.dart';
import 'package:gymbro/extensions/context_extension.dart';
import 'package:gymbro/services/firebase_authenticate.dart';
import 'package:gymbro/ui/sign_in_page.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
        backgroundColor: AppColors.firstBlack,
        actions: [
          IconButton(
              onPressed: () {
                auth.authSignOut();
                context.replace(const SignInPage());
              },
              icon: const Icon(Icons.logout))
        ],
      ),
    );
  }
}
