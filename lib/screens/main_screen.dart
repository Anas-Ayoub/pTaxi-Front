import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:taxi_app/constant/const.dart';
import 'package:taxi_app/providers/app_provider.dart';
import 'package:taxi_app/providers/map_provider.dart';
import 'package:taxi_app/screens/home_screen.dart';
import 'package:taxi_app/Router/route_names.dart';
import 'package:taxi_app/services/authentication_service.dart';
import 'package:taxi_app/utils/utils.dart';
import 'package:taxi_app/widgets/buttons/drawer_button.dart';
import 'package:taxi_app/widgets/profile_container.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
final cardSoundPlayer = AudioPlayer();

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {

  
  Future<void> _loadAudio() async {
    await cardSoundPlayer.setSource(AssetSource('sounds/pop3.mp3'));
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  late TabController _tabController;
  int currentTabBarIndex = 0;

  User? user = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    super.initState();
    _loadAudio();
    if (user != null) {
      print("=== TOKEN ===");
      user!.getIdToken(true).then(
        (value) {
          print("========");
          log("\n\n${value}\n\n");
          print("====UID====");
          log("\n\n${user!.uid}\n\n");
        },
      );
    } else {
      AuthService().signOutGoogle();
    }
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    cardSoundPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MapProvider _mapProvider = Provider.of<MapProvider>(context, listen: true);
    User? user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      key: _scaffoldKey,
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartTop,
      drawer: Drawer(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProfileFrame(),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  child: Text(
                    user!.displayName ?? 'N/A',
                    style: getFontStyle(context).copyWith(fontSize: 25),
                  ),
                  onTap: () => log(user.uid),
                ),
                const Divider(),
                const SizedBox(
                  height: 30,
                ),
                DrawerIconButton(
                  iconPath: "assets/user.png",
                  text: AppLocalizations.of(context)!.profile,
                  onPressed: () => context.pushNamed(RouteNames.profile),
                ),
                DrawerIconButton(
                  iconPath: "assets/history.png",
                  text: AppLocalizations.of(context)!.history,
                  onPressed: () => context.pushNamed(RouteNames.history),
                ),
                DrawerIconButton(
                  iconPath: "assets/setting.png",
                  text: AppLocalizations.of(context)!.settings,
                  onPressed: () => context.pushNamed(RouteNames.settings),
                ),
                DrawerIconButton(
                  iconPath: "assets/question.png",
                  text: AppLocalizations.of(context)!.helpAndSupport,
                  onPressed: () => context.pushNamed(RouteNames.helpScreen),
                ),
                const Spacer(),
                DrawerIconButton(
                  iconPath: "assets/exit.png",
                  text: AppLocalizations.of(context)!.logOut,
                  onPressed: () => AuthService().signOutGoogle(),
                ),
              ],
            ),
          ),
        ),
      ),
      body: const HomeScreen(),
      floatingActionButton: Visibility(
        visible: !_mapProvider.isPickingLocation,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: SizedBox(
            child: SizedBox(
                width: 40,
                height: 40,
                child: Consumer<MapProvider>(
                  builder: (context, value, child) {
                    return Visibility(
                      visible: !value.isFindingTaxi,
                      child: FloatingActionButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              10), // Set the border radius
                        ),
                        backgroundColor: primaryColor,
                        onPressed: () {
                          // showDriverComingSheet(context);
                          // showPickingLocationSheet(context);
                          _scaffoldKey.currentState?.openDrawer();
                        },
                        child: const Icon(
                          Icons.menu,
                          color: Colors.white,
                          size: 25,
                        ),
                      ),
                    );
                  },
                )),
          ),
        ),
      ),
    );
  }
}

































// import 'package:flutter/material.dart';
// import 'package:taxi_app/dummy_data.dart';
// import 'package:taxi_app/mainScreens/bottom_sheet.dart';
// import 'package:taxi_app/scrn1%20copy%202.dart';
// import 'package:taxi_app/scrn1%20copy%203.dart';
// import 'package:taxi_app/scrn1%20copy.dart';
// import 'package:taxi_app/scrn1.dart';
// import 'package:taxi_app/theme/colors.dart';

// class MainScreen extends StatefulWidget {
//   const MainScreen({super.key});

//   @override
//   State<MainScreen> createState() => _MainScreenState();
// }

// class _MainScreenState extends State<MainScreen>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//   int currentTabBarIndex = 0;
//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 4, vsync: this);
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: TabBarView(
//         controller: _tabController,
//         physics: const NeverScrollableScrollPhysics(),
//         children: [
//           MyWidget1(),
//           MyWidget2(),
//           MyWidget3(),
//           MyWidget4(),
//         ],
//       ),
//       bottomNavigationBar: Theme(
//         data: Theme.of(context).copyWith(splashColor: Colors.transparent),
//         child: BottomNavigationBar(
//           currentIndex: currentTabBarIndex,
//           items: const [
//             BottomNavigationBarItem(
//               icon: Icon(Icons.verified_user),
//               label: "data",
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.verified_user),
//               label: "data",
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.verified_user),
//               label: "data",
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.verified_user),
//               label: "data",
//             ),
//           ],
//           backgroundColor: Colors.black,
//           unselectedItemColor: Colors.white,
//           selectedItemColor: primary,
//           showUnselectedLabels: false,
//           type: BottomNavigationBarType.fixed,
//           onTap: (value) {
//             onTabBarClicked(value);
//           },
//         ),
//       ),
//     );
//   }

//   void onTabBarClicked(int index) {
//     setState(() {
//       currentTabBarIndex = index;
//       _tabController.index = currentTabBarIndex;
//     });
//   }
// }
