import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:justlearn/business_logic/models/languageList/language_list_model.dart';
import 'package:justlearn/business_logic/models/languageList/language_with_tutors_model.dart';
import 'package:justlearn/business_logic/models/tutors/tutors_model.dart';
import 'package:justlearn/services/languageList/language_list_provider.dart';
import 'package:justlearn/services/tutors/tutors_list_api.dart';
import 'package:justlearn/ui/views/components/search_language.dart';
import 'package:justlearn/ui/views/screens/tutor/tutor_profile.dart';
import 'package:justlearn/ui/views/screens/tutor/tutor_profile_from_language.dart';
import 'package:justlearn/ui/views/screens/tutor/tutor_shimmer_grid.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class TutorsScreenNewView extends StatefulWidget {
  TutorsScreenNewView({Key key}) : super(key: key);
  static const String id = "tutors_screen_grid";
  @override
  _TutorsScreenNewViewState createState() => _TutorsScreenNewViewState();
}

class _TutorsScreenNewViewState extends State<TutorsScreenNewView> {
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
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2.6;
    final double itemWidth = size.width / 2;
    var _languageList = Provider.of<LanguageListProvider>(context);
    var selectedLanguage =
        Provider.of<LanguageListProvider>(context).selectedLanguage;
    final _tutorListProvider =
        Provider.of<TutorsListApi>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Find Online Tutor',
                      style: TextStyle(
                          fontSize: 22.0,
                          fontFamily: 'WorkSans',
                          fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        showSearch(
                            context: context,
                            delegate: SearchLanguageDelegate());
                      },
                    )
                  ],
                ),
              ),
              _languageList.languageListWithTutors.length == 0
                  ? Expanded(
                      child: Shimmer.fromColors(
                          baseColor: Colors.grey[300],
                          highlightColor: Colors.grey[100],
                          child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 8.0,
                              mainAxisSpacing: 4.0,
                              childAspectRatio: (itemWidth / itemHeight),
                            ),
                            itemCount: 10,
                            itemBuilder: (context, index) {
                              return TutorShimmerGrid();
                            },
                          )),
                    )
                  : Expanded(
                      child: ListView.builder(
                        itemCount: _languageList.languageListWithTutors.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          LanguageWithTutors languageWithTutors =
                              _languageList.languageListWithTutors[index];
                          //print(tutorItem.profile.subjectNames);
                          return _languageWithTutorList(languageWithTutors);
                        },
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _languageWithTutorList(LanguageWithTutors languageTutors) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Learn ${languageTutors.language}',
            style: TextStyle(
              fontSize: 18.0,
            ),
          ),
          SizedBox(height: 5.0,),
          Container(
            height: 230.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: languageTutors.tutors.length,
              itemBuilder: (context, index) {
                Tutor tutorsL = languageTutors.tutors[index];
                return Card(
                  elevation: 5.0,
                  child: Container(
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(8.0),
                          height: 150.0,
                          //width: 50.0,
                          child: CachedNetworkImage(
                            imageUrl: '${tutorsL.profile.imageRelativePath}${tutorsL.profile.profileImage}',
                            fit: BoxFit.fill,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, right: 8.0, top: 4.0),
                          child: Text(
                            '${tutorsL.profile.name}',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'WorkSans',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: FlatButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TutorsProfileFromLanguage(
                                    tutor: tutorsL,
                                  ),
                                ),
                              );
                            },
                            textColor: Color(0xFF3061cc),
                            child: Text('Just Speak'),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: Color(0xFF3061cc),
                                  width: 1,
                                  style: BorderStyle.solid),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
