import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gymbro/ui/home_page.dart';
import 'package:gymbro/ui/profile_page.dart';
import 'package:gymbro/ui/workout_page.dart';

class LandingPage extends ConsumerStatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  ConsumerState<LandingPage> createState() => _MenteeLandingPageState();
}

class _MenteeLandingPageState extends ConsumerState<LandingPage>
    with AutomaticKeepAliveClientMixin {
  int currentIndex = 0;

  final List<Widget> screens = [
    const HomePage(),
    const ProfilePage(),
    const WorkoutPage()
  ];

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: IndexedStack(
        index: currentIndex,
        children: screens.map((screen) {
          return screen;
        }).toList(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        currentIndex: currentIndex,
        elevation: 11.0,
        onTap: (index) {
          setState(() => currentIndex = index);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.groups_outlined),
            label: 'Spor Salonları',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'Profil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sports_gymnastics),
            label: 'Workout',
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
