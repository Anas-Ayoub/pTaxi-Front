import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taxi_app/constant/const.dart';
import 'package:taxi_app/screens/home_screen.dart';
import 'package:taxi_app/route_names.dart';
import 'package:taxi_app/widgets/drawer_button.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int currentTabBarIndex = 0;

  User? user = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    super.initState();
    if (user != null) {
      print("=== TOKEN ===");
      user!.getIdToken(true).then((value) {
        print("========");
        log("\n\n${value}\n\n");
        print("====UID====");
        log("\n\n${user!.uid}\n\n");
      });
    }
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 25,
                ),
                ProfilePicture(
                  
                  name: user!.displayName ?? 'NO NAM',
                  radius: 40,
                  fontsize: 40,
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  child: Text(
                    user.displayName ?? 'N/A',
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
                  text: "Profile",
                  onPressed: () => context.pushNamed(RouteNames.history),
                ),
                DrawerIconButton(
                  iconPath: "assets/setting.png",
                  text: "Settings",
                  onPressed: () {
                    
                  },
                ),
                DrawerIconButton(
                  iconPath: "assets/question.png",
                  text: "Help & Support",
                  onPressed: () {
                    
                  },
                ),
                const Spacer(),
                DrawerIconButton(
                  iconPath: "assets/exit.png",
                  text: "Log Out",
                  onPressed: () {
                    
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      body: HomeScreen(),
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
