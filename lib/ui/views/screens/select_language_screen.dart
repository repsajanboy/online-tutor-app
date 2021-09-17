import 'package:flutter/material.dart';
import 'package:justlearn/business_logic/models/languageList/language_list_model.dart';
import 'package:justlearn/services/auth/auth_provider.dart';
import 'package:justlearn/services/bottomnav_provider.dart';
import 'package:justlearn/services/dashboardDetails.dart/dash_details_provider.dart';
import 'package:justlearn/services/languageList/language_list_provider.dart';
import 'package:justlearn/services/lessons/lessons_list_api.dart';
import 'package:justlearn/services/tutors/tutors_list_api.dart';
import 'package:provider/provider.dart';

class SelectLanguageScreen extends StatefulWidget {
  static const String id = "select_language";
  @override
  _SelectLanguageScreenState createState() => _SelectLanguageScreenState();
}

class _SelectLanguageScreenState extends State<SelectLanguageScreen> {
  @override
  void initState() {
    Provider.of<AuthProvider>(context, listen: false).isLoginAlready();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(bottom: 20.0),
                child: Center(
                  child: Image(
                    width: MediaQuery.of(context).size.width * .5,
                    image: AssetImage('assets/img/logo/justlearn.png'),
                  ),
                ),
              ),
              Text(
                'I want to learn...',
                style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: Consumer<LanguageListProvider>(
                  builder: (context, languageList, child) => ListView.builder(
                    primary: false,
                    shrinkWrap: true,
                    itemCount: languageList.languageRes.length,
                    itemBuilder: (context, index) {
                      LanguageResult list = languageList.languageRes[index];
                      return GestureDetector(
                        child: Card(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.all(
                                Radius.circular(8.0),
                              ),
                            ),
                            child: ListTile(
                              title: Text('${list.isoName}'),
                              trailing: Icon(Icons.keyboard_arrow_right),
                            ),
                          ),
                        ),
                        onTap: () async {
                          bool isLoggedIn =
                              Provider.of<AuthProvider>(context, listen: false)
                                  .isAlreadyLogin;
                          if (isLoggedIn) {
                            Provider.of<DashDetailsProvider>(context,
                                    listen: false)
                                .loadDashDetails();
                            Provider.of<LessonListApi>(context, listen: false)
                                .getLessonsList(1);
                          }
                          // Provider.of<TutorsListApi>(context, listen: false)
                          //     .setIso(list.iso);
                          final botnavState =
                              Provider.of<BottomNavigationBarProvider>(context,
                                  listen: false);
                          botnavState.currentIndex = 0;
                          // Provider.of<TutorsListApi>(context, listen: false)
                          //     .getNativeTutorsList();
                          Navigator.pushNamed(context, 'menu_screen');
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
