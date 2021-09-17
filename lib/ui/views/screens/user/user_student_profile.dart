import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:justlearn/business_logic/models/auth/params_model.dart';

import 'package:justlearn/business_logic/models/utils/networking.dart';
import 'package:justlearn/services/auth/auth_provider.dart';
import 'package:justlearn/services/bottomnav_provider.dart';
import 'package:justlearn/services/dashboardDetails.dart/dash_details_provider.dart';
import 'package:justlearn/services/lessons/lessons_list_api.dart';
import 'package:justlearn/services/push_notification_provider.dart';
import 'package:justlearn/services/tutors/tutors_list_api.dart';
import 'package:justlearn/services/user_profile/user_profile_provider.dart';
import 'package:justlearn/ui/views/screens/getstarted_screen.dart';
import 'package:justlearn/ui/views/screens/tutor/stripe_subscription_screen.dart';
import 'package:justlearn/ui/views/screens/user/edit_student_profile.dart';

import 'package:provider/provider.dart';

class UserStudentProfile extends StatefulWidget {
  static const String id = 'user_student_profile';
  final ParamsResponse params;

  const UserStudentProfile({Key key, this.params}) : super(key: key);
  @override
  _UserStudentProfileState createState() => _UserStudentProfileState();
}

class _UserStudentProfileState extends State<UserStudentProfile>
    with TickerProviderStateMixin {
  TabController _controller;
  static FirebaseAnalytics analytics = FirebaseAnalytics();

  @override
  void initState() {
    _controller = new TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //var studentImage = studentProvider.student.profileImage;

    return Scaffold(
      body: Consumer<UserProvider>(
        builder: (context, studentProvider, child) => SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                child: Row(
                  children: <Widget>[
                    Container(
                      height: 180,
                      width: 150,
                      decoration: BoxDecoration(
                          color: Colors.grey[350],
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(10))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: "${studentProvider.student.profileImage}"
                                    .isEmpty
                                ? Image(
                                    image: NetworkImage(
                                        'https://www.cdnjustlearn.com/image/intet-billede.jpg'),
                                    fit: BoxFit.cover)
                                : Image.network(
                                    '${NetworkHelper.imgUrl}${studentProvider.student.profileImage}',
                                    fit: BoxFit.cover),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      width: 150,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${studentProvider.student.firstName}',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: "WorkSans"),
                          ),
                          Text(
                            '${studentProvider.student.lastName}',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: "WorkSans"),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Material(
                  color: Color(0xFF3061cc),
                  borderRadius: BorderRadius.all(Radius.circular(16.0)),
                  elevation: 5.0,
                  child: MaterialButton(
                    onPressed: () {
                      final botnavState =
                          Provider.of<BottomNavigationBarProvider>(context,
                              listen: false);
                      botnavState.currentIndex = 0;
                      analytics.logEvent(
                        name: 'checkout_page',
                        parameters: null,
                      );
                      Navigator.pushNamed(context, StripeSubscriptionScreen.id);
                    },
                    minWidth: MediaQuery.of(context).size.width * .75,
                    height: 42.0,
                    child: Text(
                      'Buy Lesson',
                      style: TextStyle(
                        fontFamily: 'WorkSans',
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Divider(
                height: 30,
                thickness: 5,
              ),
              TabBar(controller: _controller, tabs: [
                Tab(
                  child: Column(
                    children: <Widget>[
                      Icon(Icons.settings, color: Color(0xFF3061cc)),
                      Text(
                        "General",
                        style: TextStyle(
                            color: Colors.black54, fontFamily: "WorkSans"),
                      ),
                    ],
                  ),
                ),
                Tab(
                  child: Column(
                    children: <Widget>[
                      Icon(Icons.subscriptions, color: Color(0xFF3061cc)),
                      Text(
                        "Subscription",
                        style: TextStyle(
                            color: Colors.black54, fontFamily: "WorkSans"),
                      ),
                    ],
                  ),
                ),
              ]),
              Expanded(
                child: TabBarView(
                  controller: _controller,
                  children: [
                    SingleChildScrollView(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                margin: EdgeInsets.all(15),
                                color: Colors.white,
                                shadowColor: Colors.grey[300],
                                child: Column(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 20, 20, 0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: Text(
                                              'First Name',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontFamily: 'WorkSans'),
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.all(20),
                                            decoration: BoxDecoration(
                                              color: Colors.grey[200],
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(15.0)),
                                            ),
                                            child: Text(
                                              "${studentProvider.student.firstName}",
                                              style: TextStyle(
                                                  color: Colors.grey[600],
                                                  fontSize: 18,
                                                  fontFamily: 'WorkSans',
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 10, 20, 10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: Text(
                                              'Last Name',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontFamily: 'WorkSans'),
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.all(20),
                                            decoration: BoxDecoration(
                                              color: Colors.grey[200],
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(15.0)),
                                            ),
                                            child: Text(
                                              "${studentProvider.student.lastName}",
                                              style: TextStyle(
                                                  color: Colors.grey[600],
                                                  fontSize: 18,
                                                  fontFamily: 'WorkSans',
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          bottom: 10.0,
                                          left: 20.0,
                                          right: 20.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: Text(
                                              'Email',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontFamily: 'WorkSans'),
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.all(20),
                                            decoration: BoxDecoration(
                                              color: Colors.grey[200],
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(15.0)),
                                            ),
                                            child: Text(
                                              "${studentProvider.student.email}",
                                              style: TextStyle(
                                                  color: Colors.grey[600],
                                                  fontSize: 18,
                                                  fontFamily: 'WorkSans',
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(
                                          bottom: 20.0,
                                          left: 20.0,
                                          right: 20.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: Text(
                                              'Time Zone',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontFamily: 'WorkSans'),
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.all(20),
                                            decoration: BoxDecoration(
                                              color: Colors.grey[200],
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(15.0)),
                                            ),
                                            child: Text(
                                              "${studentProvider.student.timezoneInfo}" +
                                                  " GMT(" +
                                                  "${studentProvider.student.timezoneInfoGmt}" +
                                                  ")",
                                              style: TextStyle(
                                                  color: Colors.grey[600],
                                                  fontSize: 18,
                                                  fontFamily: 'WorkSans',
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )),
                            Container(
                              margin: EdgeInsets.only(left: 15, right: 15),
                              child: RaisedButton(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    side: BorderSide(color: Colors.white)),
                                onPressed: () {
                                  Navigator.pushNamed(context, EditStudent.id);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Text(
                                    'Edit',
                                    style: TextStyle(
                                        color: Color(0xFF3061cc),
                                        fontSize: 18,
                                        fontFamily: 'WorkSans',
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 30.0),
                                child: FlatButton(
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onPressed: () async {
                                    print('Sign out fot clicked');
                                    bool response =
                                        await studentProvider.logout();
                                    if (response) {
                                      await Provider.of<LessonListApi>(context,
                                              listen: false)
                                          .setListNull();
                                      await Provider.of<TutorsListApi>(context,
                                              listen: false)
                                          .clearData();
                                      await Provider.of<
                                                  PushNotificationProvider>(
                                              context,
                                              listen: false)
                                          .deleteToken();
                                      // await Provider.of<AuthProvider>(context,
                                      //         listen: false)
                                      //     .logout();
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => GetStarted(),
                                        ),
                                      );
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 30, top: 30),
                                    child: Text(
                                      'Sign out',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontFamily: 'WorkSans',
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey),
                                      textAlign: TextAlign.end,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ]),
                    ),
                    Container(
                      padding: EdgeInsets.all(20.0),
                      child: Consumer<DashDetailsProvider>(
                        builder: (context, dashProvider, child) =>
                            dashProvider.isStripeSubs
                                ? Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            'Subscription Lessons: ',
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 18.0),
                                          ),
                                          Text(
                                            '${dashProvider.stripes.subPlanLessons} lessons',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18.0),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20.0,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            'Subscription Price: ',
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 18.0),
                                          ),
                                          Text(
                                            '\$${dashProvider.stripes.subPlanPrice}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18.0),
                                          )
                                        ],
                                      )
                                    ],
                                  )
                                : Center(
                                    child: Text(
                                        'You don\'t have any subscription in Justlearn'),
                                  ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
