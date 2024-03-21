import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_PARENTS/modules/screens/home/widgets/home_screen_body.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_PARENTS/modules/screens/profile/profile_screen.dart';
import 'package:repetiteur_mobile_app_definitive/MODULES/PARTIE_PARENTS/modules/screens/teachers/teachers_screen.dart';
import 'package:repetiteur_mobile_app_definitive/core/constants/PARENTS/constants.dart';
import 'package:repetiteur_mobile_app_definitive/provider/database/db_provider.dart';

class ParentHomeScreen extends StatefulWidget {
  const ParentHomeScreen({super.key});

  static String routeName = "/parent_home";

  @override
  State<ParentHomeScreen> createState() => _ParentHomeScreenState();
}

class _ParentHomeScreenState extends State<ParentHomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  DateTime backPressedTime = DateTime.now();

  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  static const List<Widget> _widgetOptions = <Widget>[
    ParentHomeScreenBody(),
    ParentTeachersScreen(),
    ParentProfileScreen(),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark));
    return WillPopScope(
      onWillPop: () => _onBackButtonClickedDoubleClicked(context),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: PageView(
            controller: _pageController,
            children: _widgetOptions,
            onPageChanged: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 20,
                color: Colors.black.withOpacity(.1),
              )
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
              child: GNav(
                rippleColor: Colors.blue.shade400,
                hoverColor: Colors.blueAccent.shade100,
                gap: 8,
                activeColor: kPrimaryColor,
                iconSize: 20,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                duration: const Duration(milliseconds: 400),
                tabBackgroundColor: Colors.blue.withOpacity(0.3),
                color: kPrimaryColor,
                tabs: const [
                  GButton(
                    icon: LineIcons.home,
                    text: 'Accueil',
                  ),
                  GButton(
                    icon: CupertinoIcons.person_2,
                    text: 'Nos Répétiteurs',
                  ),
                  /*GButton(
                    icon: LineIcons.search,
                    text: 'Rechercher',
                  ),*/
                  GButton(
                    icon: LineIcons.user,
                    text: 'Profile',
                  ),
                ],
                selectedIndex: _selectedIndex,
                onTabChange: (index) {
                  _pageController.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeInOut,
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _onBackButtonClickedDoubleClicked(BuildContext context) async {
    final difference = DateTime.now().difference(backPressedTime);
    backPressedTime = DateTime.now();

    if (difference >= const Duration(seconds: 2)) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Appuyer encore pour quitter')));
      return false;
    } else {
      GetStorage().remove('userName');
      GetStorage().remove('userMail');
      GetStorage().remove('userId');
      GetStorage().remove('token');
      DatabaseProvider().logOut(context);
      SystemNavigator.pop(animated: true);
      return true;
    }
  }
}
