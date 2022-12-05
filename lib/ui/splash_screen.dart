import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gymbro/extensions/context_extension.dart';
import 'package:gymbro/providers/auth_state.dart';
import 'package:gymbro/ui/landing.dart';
import 'package:gymbro/ui/sign_in_page.dart';

import '../providers/firebase_provider.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    ref.listen(firebaseProvider, (previous, next) {
      if (previous is! Checked && next is Checked) {
        final result = next.value;
        result == true
            ? Timer(const Duration(seconds: 5),
                () => context.replace(const LandingPage()))
            : Timer(const Duration(seconds: 5),
                () => context.go(const SignInPage()));
      }
    });

    return Center(
        child: Image.network(
            "https://gymbrofitness.com/wp-content/themes/gymbro/assets/img/bottom-logo.png"));
  }
}
