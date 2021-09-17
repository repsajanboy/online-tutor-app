import 'package:flutter/material.dart';
import 'package:justlearn/business_logic/models/languageList/language_list_model.dart';
import 'package:justlearn/business_logic/models/tutors/tutors_model.dart';
import 'package:justlearn/services/languageList/language_list_provider.dart';
import 'package:justlearn/services/tutors/tutors_list_api.dart';
import 'package:justlearn/ui/views/screens/select_language_screen.dart';
import 'package:justlearn/ui/views/screens/tutor/tutor_profile.dart';
import 'package:justlearn/ui/views/screens/tutor/tutor_shimmer_list.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:dropdown_search/dropdown_search.dart';

class TutorsScreen extends StatefulWidget {
  TutorsScreen({Key key}) : super(key: key);
  static const String id = 'tutors_screen';
  @override
  _TutorsScreenState createState() => _TutorsScreenState();
}

class _TutorsScreenState extends State<TutorsScreen> {
  ScrollController _controller = new ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tutor = Provider.of<TutorsListApi>(context);
    var _languageList = Provider.of<LanguageListProvider>(context).languageRes;
    var selectedLanguage =
        Provider.of<LanguageListProvider>(context).selectedLanguage;
    final _tutorListProvider =
        Provider.of<TutorsListApi>(context, listen: false);
    final _languageListProvider =
        Provider.of<LanguageListProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
        brightness: Brightness.light,
        title: Text(
          'Learn ${selectedLanguage.isoName}',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              tutor.nativeTutors.length == 0
                  ? Expanded(
                      child: Shimmer.fromColors(
                          baseColor: Colors.grey[300],
                          highlightColor: Colors.grey[100],
                          child: ListView.builder(
                            itemCount: 3,
                            itemBuilder: (context, index) {
                              return TutorShimmerList();
                            },
                          )),
                    )
                  : Expanded(
                      child: NotificationListener<ScrollNotification>(
                        onNotification: (ScrollNotification scrollInfo) {
                          if (!tutor.isDone &&
                              !tutor.isFetching &&
                              scrollInfo.metrics.pixels ==
                                  scrollInfo.metrics.maxScrollExtent) {
                            if (selectedLanguage == null) {
                              tutor.setFetching(true);
                              tutor.getTutorsList();
                            } else {
                              tutor.setFetching(true);
                              // tutor.getTutorsList();
                              _tutorListProvider
                                  .getNativeTutorsList(selectedLanguage.iso);
                            }
                          }
                        },
                        child: ListView.builder(
                          itemCount: tutor.nativeTutors.length,
                          itemBuilder: (context, index) {
                            Tutors tutorItem = tutor.nativeTutors[index];
                            //print(tutorItem.profile.subjectNames);
                            return _tutorList(tutorItem);
                          },
                        ),
                      ),
                    ),
              tutor.nativeTutors.length == 0
                  ? SizedBox()
                  : _buildProgressIndicator()
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProgressIndicator() {
    final tutorState = Provider.of<TutorsListApi>(context, listen: false);
    return Container(
      padding: const EdgeInsets.all(8.0),
      height: tutorState.isFetching ? 50.0 : 0,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _tutorList(Tutors tutorsL) {
    //bool isLoggedIn = Provider.of<AuthProvider>(context).isAlreadyLogin;
    return InkWell(
      child: Container(
        padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 5.0),
        margin: const EdgeInsets.fromLTRB(13, 5, 13, 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          boxShadow: [
            BoxShadow(
              offset: Offset(1, 1),
              spreadRadius: 2,
              blurRadius: 1,
              color: Colors.grey[100],
            ),
          ],
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(
                    '${tutorsL.profile.imageRelativePath}${tutorsL.profile.profileImage}'),
                maxRadius: 40,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * .5,
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      '${tutorsL.profile.firstName} ${tutorsL.profile.lastName}',
                      style: TextStyle(
                          color: Color(0xFF3061cc),
                          fontSize: 16,
                          fontFamily: 'WorkSans',
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * .5,
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      '${tutorsL.countryFrom}',
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 14,
                          fontFamily: 'WorkSans',
                          fontWeight: FontWeight.bold),
                      overflow: TextOverflow.clip,
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              '${tutorsL.profile.subjectNames}',
              style: TextStyle(
                  color: Colors.green,
                  fontSize: 16,
                  fontFamily: 'WorkSans',
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              '${tutorsL.profile.shortIntroduction}',
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
            ),
          )
        ]),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TutorProfile(
              tutor: tutorsL,
            ),
          ),
        );
      },
    );
  }
}
