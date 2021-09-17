import 'package:flutter/material.dart';
import 'package:justlearn/business_logic/models/auth/params_model.dart';
import 'package:justlearn/business_logic/models/users/users_model.dart';
import 'package:justlearn/business_logic/models/utils/networking.dart';
import 'package:justlearn/services/auth/auth_provider.dart';
import 'package:justlearn/services/lessons/lessons_list_api.dart';
import 'package:justlearn/services/push_notification_provider.dart';
import 'package:justlearn/services/tutors/tutors_list_api.dart';
import 'package:justlearn/services/user_profile/user_profile_provider.dart';
import 'package:justlearn/ui/views/screens/getstarted_screen.dart';
import 'package:justlearn/ui/views/screens/user/edit_teacher_profile.dart';
import 'package:provider/provider.dart';

class UserTeacherProfile extends StatefulWidget {
  static const String id = 'user_teacher_profile';
  final ParamsResponse params;

  const UserTeacherProfile({Key key, this.params}) : super(key: key);

  @override
  _UserTeacherProfileState createState() => _UserTeacherProfileState();
}

class _UserTeacherProfileState extends State<UserTeacherProfile> {
  ParamsResponse loadParams = ParamsResponse();

  bool isLoading = false;
  Profile teacher = Profile();
  Info infos = Info();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Consumer<UserProvider>(
            builder: (context, teacherProvider, child) => SafeArea(
                    child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
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
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Expanded(
                                        child: "${teacher.profileImage}".isEmpty
                                            ? Image(
                                                image: NetworkImage(
                                                    'https://www.cdnjustlearn.com/image/intet-billede.jpg'),
                                                fit: BoxFit.cover)
                                            : Image.network(
                                                '${NetworkHelper.imgUrl}${teacherProvider.teacher.profileImage}',
                                                fit: BoxFit.cover)),
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
                                      '${teacherProvider.teacher.firstName}',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "WorkSans"),
                                    ),
                                    Text(
                                      '${teacherProvider.teacher.lastName}',
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
                        Container(
                            margin:
                                EdgeInsets.only(top: 10, left: 10, right: 10),
                            padding: EdgeInsets.only(top: 10, bottom: 10),
                            color: Color(0xFF3061cc),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(Icons.settings, color: Colors.white),
                                Text(
                                  'General',
                                  style: TextStyle(
                                    color: Colors.white60,
                                  ),
                                ),
                              ],
                            )),
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
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 20, 20, 0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
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
                                          "${teacherProvider.teacher.firstName}",
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
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 10, 20, 0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
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
                                          "${teacherProvider.teacher.lastName}",
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
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 10, 20, 0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
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
                                          "${teacherProvider.teacher.email}",
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
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 10, 20, 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Text(
                                          'Phone Number',
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
                                          "${teacherProvider.teacher.phone}",
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
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
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
                                                'Age',
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
                                                "${teacherProvider.teacher.age}",
                                                style: TextStyle(
                                                    color: Colors.grey[600],
                                                    fontSize: 18,
                                                    fontFamily: 'WorkSans',
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
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
                                                'Gender',
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
                                                "${teacherProvider.teacher.gender}",
                                                style: TextStyle(
                                                    color: Colors.grey[600],
                                                    fontSize: 18,
                                                    fontFamily: 'WorkSans',
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                      bottom: 20.0, left: 20.0, right: 20.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Text(
                                          'Lives in',
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
                                          "${teacherProvider.teacher.country}",
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
                                      bottom: 20.0, left: 20.0, right: 20.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Text(
                                          'From',
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
                                          "${teacherProvider.infos.countryFrom}",
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
                                      bottom: 20.0, left: 20.0, right: 20.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Text(
                                          'Address',
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
                                          "${teacherProvider.teacher.address}",
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
                                      bottom: 10.0, left: 20.0, right: 20.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Text(
                                          'City',
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
                                          "${teacherProvider.teacher.city}",
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
                                      bottom: 20.0, left: 20.0, right: 20.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
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
                                          "${teacherProvider.teacher.timezoneInfo}" +
                                              " GMT(" +
                                              "${teacherProvider.teacher.timezoneInfoGmt}" +
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
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            EditTeacher(params: loadParams)));
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Text('Edit',
                                    style: TextStyle(
                                        color: Color(0xFF3061cc),
                                        fontSize: 18,
                                        fontFamily: 'WorkSans',
                                        fontWeight: FontWeight.bold)),
                              )),
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
                                bool response = await teacherProvider.logout();
                                if (response) {
                                  await Provider.of<LessonListApi>(context,
                                          listen: false)
                                      .setListNull();
                                  await Provider.of<TutorsListApi>(context,
                                          listen: false)
                                      .clearData();
                                  await Provider.of<PushNotificationProvider>(context,
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
                                padding:
                                    const EdgeInsets.only(bottom: 30, top: 30),
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
                ))));
  }
}
