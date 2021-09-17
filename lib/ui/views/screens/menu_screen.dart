import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:justlearn/services/auth/auth_provider.dart';
import 'package:justlearn/services/bottomnav_provider.dart';
import 'package:justlearn/services/dashboardDetails.dart/dash_details_provider.dart';
import 'package:justlearn/services/lessons/lessons_list_api.dart';
import 'package:justlearn/services/tutors/tutors_list_api.dart';
import 'package:justlearn/ui/views/screens/lesson/lesson_list_screen.dart';
import 'package:justlearn/services/push_notification_provider.dart';
import 'package:justlearn/ui/views/screens/tutors_screen.dart';
import 'package:justlearn/ui/views/screens/tutors_screen_new.dart';
import 'package:justlearn/ui/views/screens/user/user_profile.dart';
import 'package:justlearn/ui/views/screens/user/user_profile_not_login.dart';
import 'package:justlearn/ui/views/screens/videos/videos_list_screen.dart';
import 'package:provider/provider.dart';
import 'package:rate_my_app/rate_my_app.dart';

class MenuScreen extends StatelessWidget {
  static const String id = "menu_screen";

  @override
  Widget build(BuildContext context) {
    Provider.of<AuthProvider>(context, listen: false).isLoginAlready();
    print('build 1');
    return BottomNavigationBarItems();
  }
}

class BottomNavigationBarItems extends StatefulWidget {
  static const String id = "bottom_nav";
  @override
  _BottomNavigationBarItemsState createState() =>
      _BottomNavigationBarItemsState();
}

class _BottomNavigationBarItemsState extends State<BottomNavigationBarItems> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  RateMyApp _rateMyApp = RateMyApp(
    preferencesPrefix: 'rateMyApp_',
    minDays: 3,
    minLaunches: 7,
    remindDays: 2,
    remindLaunches: 5,
    // appStoreIdentifier: '',
    googlePlayIdentifier: 'com.justlearn',
  );

  final tabs = [
    TutorsScreenNewView(), //TutorsScreen(),
    //LessonScreen(),
    LessonListScreen(),
    VideosListScreen(),
    //LiveLessonScreen(),
    UserProfile()
  ];

  final notLoginTab = [
    TutorsScreen(),
    //LessonScreen(),
    UserProfileNotLogin(),
    VideosListScreen(),
    //LiveLessonScreen(),
    UserProfileNotLogin()
  ];

  @override
  void initState() {
    super.initState();
    _loadProviders();
  }

  _loadProviders() async {
    await Provider.of<TutorsListApi>(context, listen: false).getTutorsList();
    bool isLoggedIn = Provider.of<AuthProvider>(context, listen: false).isAlreadyLogin;
    if (isLoggedIn) {
      Provider.of<DashDetailsProvider>(context, listen: false)
          .loadDashDetails();
      Provider.of<LessonListApi>(context, listen: false).getLessonsList(1);
    }
  }

  @override
  Widget build(BuildContext context) {
    print('build 2');
    print('token: ${Provider.of<PushNotificationProvider>(context).token}');
    //final bottomNavProvider = Provider.of<BottomNavigationBarProvider>(context);
    bool isLoggedIn = Provider.of<AuthProvider>(context).isAlreadyLogin;
    return WillPopScope(
      onWillPop: () async => false,
      child: Consumer<BottomNavigationBarProvider>(
        builder: (context, bottomNavProvider, child) => Scaffold(
          body: isLoggedIn
              ? tabs[bottomNavProvider.currentIndex]
              : notLoginTab[bottomNavProvider.currentIndex],
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.black38, spreadRadius: 0, blurRadius: 20),
              ],
            ),
            child: BottomNavigationBar(
              backgroundColor: Colors.white,
              currentIndex: bottomNavProvider.currentIndex,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.search,
                    color: Color(0xFF3061cc),
                    size: 30.0,
                  ),
                  title: bottomNavProvider.currentIndex == 0
                      ? Text(
                          '.',
                          style: TextStyle(
                            color: Color(0xFF3061cc),
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            height: 0.2,
                          ),
                        )
                      : Text(''),
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.playlist_play,
                    color: Color(0xFF3061cc),
                    size: 30.0,
                  ),
                  title: bottomNavProvider.currentIndex == 1
                      ? Text(
                          '.',
                          style: TextStyle(
                            color: Color(0xFF3061cc),
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            height: 0.3,
                          ),
                        )
                      : Text(''),
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.video_library,
                    color: Color(0xFF3061cc),
                    size: 30.0,
                  ),
                  title: bottomNavProvider.currentIndex == 2
                      ? Text(
                          '.',
                          style: TextStyle(
                            color: Color(0xFF3061cc),
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            height: 0.2,
                          ),
                        )
                      : Text(''),
                ),
                // BottomNavigationBarItem(
                //   icon: Icon(
                //     FontAwesomeIcons.bolt,
                //     color: Color(0xFF3061cc),
                //     size: 25.0,
                //   ),
                //   title: bottomNavProvider.currentIndex == 2
                //       ? Text(
                //           '.',
                //           style: TextStyle(
                //             color: Color(0xFF3061cc),
                //             fontWeight: FontWeight.bold,
                //             fontSize: 25,
                //             height: 0.3,
                //           ),
                //         )
                //       : Text(''),
                // ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.person,
                    color: Color(0xFF3061cc),
                    size: 30.0,
                  ),
                  title: bottomNavProvider.currentIndex == 3
                      ? Text(
                          '.',
                          style: TextStyle(
                            color: Color(0xFF3061cc),
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            height: 0.3,
                          ),
                        )
                      : Text(''),
                )
              ],
              onTap: (index) {
                bottomNavProvider.currentIndex = index;
              },
            ),
          ),
        ),
      ),
    );
  }
}
