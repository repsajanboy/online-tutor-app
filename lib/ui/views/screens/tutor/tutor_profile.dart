import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:justlearn/business_logic/models/tutors/tutors_model.dart';
import 'package:justlearn/ui/views/components/book_time_nav.dart';
import 'package:justlearn/ui/views/components/tutors_calendar.dart';

class TutorProfile extends StatefulWidget {
  static const String id = 'tutor_profile';
  final Tutors tutor;

  const TutorProfile({this.tutor});
  @override
  _TutorProfileState createState() => _TutorProfileState();
}

class _TutorProfileState extends State<TutorProfile>
    with TickerProviderStateMixin {
  TabController _controller;
  List<ProfileLanguageList> profileLanguages;
  TeacherReviewList teacherReviewList;

  // Text _buildRatingStars(int rating) {
  //   String stars = '';
  //   for (int i = 0; i < rating; i++) {
  //     stars += '⭐ ';
  //   }
  //   stars.trim();
  //   return Text(stars);
  // }

  @override
  void initState() {
    _controller = new TabController(length: 3, vsync: this);
    profileLanguages = widget.tutor.profile.profileLanguageList;
    teacherReviewList = widget.tutor.profile.teacherReviewList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
        brightness: Brightness.light,
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Padding(
                  //   padding: EdgeInsets.only(
                  //     top: 10.0,
                  //   ),
                  //   child: Row(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: <Widget>[
                  //       IconButton(
                  //         onPressed: () => Navigator.pop(context),
                  //         icon: Icon(Icons.arrow_back),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 10, 0),
                        child: CircleAvatar(
                          maxRadius: 50,
                          backgroundImage: NetworkImage(
                              '${widget.tutor.profile.imageRelativePath}${widget.tutor.profile.profileImage}'),
                        ),
                      ),
                      Container(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "${widget.tutor.profile.firstName}",
                            style: TextStyle(
                                fontSize: 23,
                                fontFamily: 'WorkSans',
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Row(
                            children: <Widget>[
                              Icon(Icons.star, color: Colors.yellow[700],),
                              Icon(Icons.star, color: Colors.yellow[700],),
                              Icon(Icons.star, color: Colors.yellow[700],),
                              Icon(Icons.star, color: Colors.yellow[700],),
                              Icon(Icons.star, color: Colors.yellow[700],),
                              //_buildRatingStars(5),
                              Text(
                                  '(${widget.tutor.profile.ratingAverageLessons})')
                            ],
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            '${widget.tutor.profile.subjectNames} Tutor',
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'WorkSans',
                            ),
                          ),
                        ],
                      )),
                    ],
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        'From',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 10.0),
                      Text(
                        '${widget.tutor.countryFrom}',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        "Speaks:",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * .65,
                        height: 30.0,
                        child: ListView.builder(
                            itemCount: profileLanguages.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, int index) {
                              ProfileLanguageList profLanguage =
                                  profileLanguages[index];
                              return Container(
                                padding: EdgeInsets.only(right: 5.0),
                                child: Row(
                                  children: <Widget>[
                                    Text('${profLanguage.languageName}'),
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                    Text(
                                      '${profLanguage.levelName}',
                                      style: TextStyle(color: Colors.blue),
                                    )
                                  ],
                                ),
                              );
                            }),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Divider(
              height: 30,
              thickness: 5,
            ),
            TabBar(
              controller: _controller,
              labelColor: Colors.blue,
              unselectedLabelColor: Colors.black54,
              tabs: <Widget>[
                Tab(
                  child: Text(
                    'ABOUT ME',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Tab(
                  child: Text(
                    'SCHEDULE',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Tab(
                  child: Text(
                    'REVIEWS',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _controller,
                children: <Widget>[
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        Card(
                          margin: EdgeInsets.all(10.0),
                          elevation: 5.0,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                                '${widget.tutor.profile.shortIntroduction}'),
                          ),
                        ),
                        Container(
                          child: Card(
                            margin: EdgeInsets.all(10.0),
                            elevation: 5.0,
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'Ratings',
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(10.0),
                                    color: Colors.grey[300],
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text('Skills'),
                                              Text(
                                                '5.0',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text('Quality'),
                                              Text(
                                                '5.0',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text('Materials'),
                                              Text(
                                                '5.0',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text('Punctionality'),
                                              Text(
                                                '5.0',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text('Communication'),
                                              Text(
                                                '5.0',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text('Recommend'),
                                              Text(
                                                '5.0',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                            height: 1610.0,
                            child: TutorsCalendar(
                              tutors: widget.tutor,
                            )),
                      ],
                    ),
                  ),
                  ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    itemCount: teacherReviewList.reviews.length == 0
                        ? teacherReviewList.reviews.length + 1
                        : teacherReviewList.reviews.length,
                    itemBuilder: (BuildContext context, int index) {
                      if (teacherReviewList.reviews.length == 0) {
                        return Card(
                          elevation: 5.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 150,
                                child: Center(
                                  child: Text(
                                    'No reviews yet.',
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      } else {
                        Review review = teacherReviewList.reviews[index];
                        return Card(
                          elevation: 5.0,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  backgroundImage: review.profileImage == null
                                      ? NetworkImage(
                                          'https://www.cdnjustlearn.com/image/intet-billede.jpg')
                                      : NetworkImage(
                                          '${widget.tutor.profile.imageRelativePath}${review.profileImage}'),
                                  maxRadius: 30,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .35,
                                            child: Text(
                                              '${review.studentName}',
                                              overflow: TextOverflow.clip,
                                              maxLines: 2,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontFamily: 'WorkSans',
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 20.0,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(4.0),
                                            child: Container(
                                              padding: EdgeInsets.all(8.0),
                                              color: Colors.grey[400],
                                              child: Text(
                                                'STUDENT',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w900),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Text(
                                        '${DateFormat.yMMMMd().format(review.endDate)}',
                                        style: TextStyle(
                                            color: Colors.black54,
                                            fontFamily: 'WorkSans',
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .65,
                                        child: Text('${review.feedbackText}',
                                            style: TextStyle(
                                              color: Colors.black,
                                            )),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BookTimeNav(
        tutorsId: widget.tutor.profile.registrationId,
        language: widget.tutor.profile.subjectNames,
      ),
    );
  }
}
