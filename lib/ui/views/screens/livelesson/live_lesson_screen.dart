import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:justlearn/services/action_buttons/action_buttons.dart';
import 'package:justlearn/services/articles/articles_provider.dart';
import 'package:justlearn/services/auth/auth_provider.dart';
import 'package:justlearn/services/dashboardDetails.dart/dash_details_provider.dart';
import 'package:justlearn/ui/views/screens/tutor/stripe_subscription_screen.dart';
import 'package:provider/provider.dart';
import 'package:justlearn/ui/views/screens/articles/articles_list_screen.dart';
import 'package:justlearn/ui/views/screens/chatbot/chatbot_screen.dart';

class LiveLessonScreen extends StatefulWidget {
  static const String id = "livelesson_screen";
  @override
  _LiveLessonScreenState createState() => _LiveLessonScreenState();
}

class _LiveLessonScreenState extends State<LiveLessonScreen> {
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  @override
  void initState() {
    final articleState = Provider.of<ArticlesProvider>(context, listen: false);
    articleState.getAllArticles();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dashProvider =
        Provider.of<DashDetailsProvider>(context, listen: false);
    bool isLoggedIn = Provider.of<AuthProvider>(context).isAlreadyLogin;
    Widget _child;
    _child = Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Padding(
              padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 15.0),
              child: Column(
                children: [
                  // Row(
                  //   children: [
                  //     Expanded(
                  //       child: Container(
                  //         margin: EdgeInsets.only(bottom: 8),
                  //         padding: EdgeInsets.only(top: 10, bottom: 10),
                  //         decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.circular(5.0),
                  //           border: Border.all(
                  //             color: Colors.grey,
                  //             width: 1,
                  //           ),
                  //         ),
                  //         child: Column(
                  //           crossAxisAlignment: CrossAxisAlignment.center,
                  //           children: [
                  //             Row(
                  //               mainAxisAlignment:
                  //                   MainAxisAlignment.spaceAround,
                  //               children: [
                  //                 Text(
                  //                   'Live English Tutor',
                  //                   style: TextStyle(
                  //                     fontWeight: FontWeight.bold,
                  //                     fontFamily: 'WorkSans',
                  //                     fontSize: 22.0,
                  //                   ),
                  //                 ),
                  //               ],
                  //             ),
                  //             SizedBox(height: 50.0),
                  //             Text('Get 25 minutes English tutoring now.'),
                  //             Padding(
                  //               padding: const EdgeInsets.all(8.0),
                  //               child: Material(
                  //                 color: Color(0xFF3061cc),
                  //                 borderRadius:
                  //                     BorderRadius.all(Radius.circular(5.0)),
                  //                 elevation: 5.0,
                  //                 child: MaterialButton(
                  //                   onPressed: () {
                  //                     if (!isLoggedIn) {
                  //                       Navigator.pushNamed(
                  //                           context, 'not_yet_login');
                  //                     } else {
                  //                       if (dashProvider.dashDetails
                  //                                   .subscriptionStatus ==
                  //                               0 ||
                  //                           dashProvider.dashDetails
                  //                                   .subscriptionLessons ==
                  //                               0) {
                  //                         analytics.logEvent(
                  //                           name: 'checkout_page',
                  //                           parameters: null,
                  //                         );
                  //                         Navigator.pushNamed(context,
                  //                             StripeSubscriptionScreen.id);
                  //                       } else {
                  //                         Navigator.pushNamed(
                  //                             context, CountDownLive.id);
                  //                       }
                  //                     }
                  //                   },
                  //                   minWidth:
                  //                       MediaQuery.of(context).size.width * .75,
                  //                   height: 42.0,
                  //                   child: Text(
                  //                     'Start',
                  //                     style: TextStyle(
                  //                       fontFamily: 'WorkSans',
                  //                       fontSize: 16.0,
                  //                       fontWeight: FontWeight.bold,
                  //                       color: Colors.white,
                  //                     ),
                  //                   ),
                  //                 ),
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(bottom: 8),
                          padding: EdgeInsets.only(top: 10, bottom: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            border: Border.all(
                              color: Colors.grey,
                              width: 1,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                child: Center(
                                  child: Text(
                                    'Read useful information about language learning',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'WorkSans',
                                      fontSize: 22.0,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              SizedBox(height: 50.0),
                              Text(
                                  'There are more than 280 articles you can read.'),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Material(
                                  color: Color(0xFF3061cc),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
                                  elevation: 5.0,
                                  child: MaterialButton(
                                    onPressed: () async {
                                      if (!isLoggedIn) {
                                        Navigator.pushNamed(
                                            context, 'not_yet_login');
                                      } else {
                                        if (dashProvider.dashDetails
                                                    .subscriptionStatus ==
                                                1 &&
                                            dashProvider.dashDetails
                                                    .subscriptionLessons ==
                                                0 &&
                                            dashProvider
                                                .dashDetails.isTrialPeriod) {
                                          final actionState = Provider.of<
                                                  ActionButtonsProvider>(
                                              context,
                                              listen: false);
                                          bool response = await actionState
                                              .getMoreLessonTrial(int.parse(
                                                  actionState.loadParams.id));
                                          if (response) {
                                            print('more-lesson-endtrial');
                                            analytics.logEvent(
                                              name: 'more_lesson-trial',
                                              parameters: {
                                                'plan': dashProvider
                                                    .stripes.subPlanLessons,
                                                'price': dashProvider
                                                    .stripes.subPlanPrice,
                                              },
                                            );
                                            await dashProvider
                                                .loadDashDetails();
                                            Navigator.pushNamed(
                                                context, ArticlesListScreen.id);
                                          }
                                        } else if (dashProvider.dashDetails
                                                    .subscriptionStatus ==
                                                1 &&
                                            dashProvider.dashDetails
                                                    .subscriptionLessons ==
                                                0) {
                                          print("charge for stripe");
                                          final actionState = Provider.of<
                                                  ActionButtonsProvider>(
                                              context,
                                              listen: false);
                                          final dashProvider =
                                              Provider.of<DashDetailsProvider>(
                                                  context,
                                                  listen: false);
                                          bool response = await actionState
                                              .getMoreLesson(dashProvider
                                                  .stripes.subPlanLessons);
                                          if (response) {
                                            analytics.logEvent(
                                              name: 'more_lesson',
                                              parameters: {
                                                'plan': dashProvider
                                                    .stripes.subPlanLessons,
                                                'price': dashProvider
                                                    .stripes.subPlanPrice,
                                              },
                                            );
                                            //await dashProvider.loadParamsAsync;
                                            await dashProvider
                                                .loadDashDetails();
                                            Navigator.pushNamed(
                                                context, ArticlesListScreen.id);
                                          }
                                        } else if (dashProvider.dashDetails
                                                    .subscriptionStatus ==
                                                0 ||
                                            dashProvider.dashDetails
                                                    .subscriptionLessons ==
                                                0) {
                                          analytics.logEvent(
                                            name: 'checkout_page',
                                            parameters: null,
                                          );
                                          Navigator.pushNamed(context,
                                              StripeSubscriptionScreen.id);
                                        } else {
                                          Navigator.pushNamed(
                                              context, ArticlesListScreen.id);
                                        }
                                      }
                                    },
                                    minWidth:
                                        MediaQuery.of(context).size.width * .75,
                                    height: 42.0,
                                    child: Text(
                                      'Start',
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
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(bottom: 8),
                          padding: EdgeInsets.only(top: 10, bottom: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            border: Border.all(
                              color: Colors.grey,
                              width: 1,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                child: Center(
                                  child: Text(
                                    'English Chatting Bot',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'WorkSans',
                                      fontSize: 22.0,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              SizedBox(height: 50.0),
                              Text(
                                  'Practice your english with our Chatting Bot.'),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Material(
                                  color: Color(0xFF3061cc),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
                                  elevation: 5.0,
                                  child: MaterialButton(
                                    onPressed: () async {
                                      if (!isLoggedIn) {
                                        Navigator.pushNamed(
                                            context, 'not_yet_login');
                                      } else {
                                        if (dashProvider.dashDetails
                                                    .subscriptionStatus ==
                                                1 &&
                                            dashProvider.dashDetails
                                                    .subscriptionLessons ==
                                                0 &&
                                            dashProvider
                                                .dashDetails.isTrialPeriod) {
                                          final actionState = Provider.of<
                                                  ActionButtonsProvider>(
                                              context,
                                              listen: false);
                                          bool response = await actionState
                                              .getMoreLessonTrial(int.parse(
                                                  actionState.loadParams.id));
                                          if (response) {
                                            print('more-lesson-endtrial');
                                            analytics.logEvent(
                                              name: 'more_lesson-trial',
                                              parameters: {
                                                'plan': dashProvider
                                                    .stripes.subPlanLessons,
                                                'price': dashProvider
                                                    .stripes.subPlanPrice,
                                              },
                                            );
                                            await dashProvider
                                                .loadDashDetails();
                                            Navigator.pushNamed(
                                                context, ChatbotScreen.id);
                                          }
                                        } else if (dashProvider.dashDetails
                                                    .subscriptionStatus ==
                                                1 &&
                                            dashProvider.dashDetails
                                                    .subscriptionLessons ==
                                                0) {
                                          print("charge for stripe");
                                          final actionState = Provider.of<
                                                  ActionButtonsProvider>(
                                              context,
                                              listen: false);
                                          final dashProvider =
                                              Provider.of<DashDetailsProvider>(
                                                  context,
                                                  listen: false);
                                          bool response = await actionState
                                              .getMoreLesson(dashProvider
                                                  .stripes.subPlanLessons);
                                          if (response) {
                                            analytics.logEvent(
                                              name: 'more_lesson',
                                              parameters: {
                                                'plan': dashProvider
                                                    .stripes.subPlanLessons,
                                                'price': dashProvider
                                                    .stripes.subPlanPrice,
                                              },
                                            );
                                            //await dashProvider.loadParamsAsync;
                                            await dashProvider
                                                .loadDashDetails();
                                            Navigator.pushNamed(
                                              context, ChatbotScreen.id);
                                          }
                                        } else if (dashProvider.dashDetails
                                                    .subscriptionStatus ==
                                                0 ||
                                            dashProvider.dashDetails
                                                    .subscriptionLessons ==
                                                0) {
                                          analytics.logEvent(
                                            name: 'checkout_page',
                                            parameters: null,
                                          );
                                          Navigator.pushNamed(context,
                                              StripeSubscriptionScreen.id);
                                        } else {
                                          Navigator.pushNamed(
                                              context, ChatbotScreen.id);
                                        }
                                      }
                                    },
                                    minWidth:
                                        MediaQuery.of(context).size.width * .75,
                                    height: 42.0,
                                    child: Text(
                                      'Start',
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
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(bottom: 8),
                          padding: EdgeInsets.only(top: 10, bottom: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            border: Border.all(
                              color: Colors.grey,
                              width: 1,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    'Test English Level',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'WorkSans',
                                      fontSize: 22.0,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 50.0),
                              Text('Test your english vocabulary.'),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Material(
                                  color: Color(0xFF3061cc),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
                                  elevation: 5.0,
                                  child: MaterialButton(
                                    onPressed: () async {
                                      if (!isLoggedIn) {
                                        Navigator.pushNamed(
                                            context, 'not_yet_login');
                                      } else {
                                        if (dashProvider.dashDetails
                                                    .subscriptionStatus ==
                                                1 &&
                                            dashProvider.dashDetails
                                                    .subscriptionLessons ==
                                                0 &&
                                            dashProvider
                                                .dashDetails.isTrialPeriod) {
                                          final actionState = Provider.of<
                                                  ActionButtonsProvider>(
                                              context,
                                              listen: false);
                                          bool response = await actionState
                                              .getMoreLessonTrial(int.parse(
                                                  actionState.loadParams.id));
                                          if (response) {
                                            print('more-lesson-endtrial');
                                            analytics.logEvent(
                                              name: 'more_lesson-trial',
                                              parameters: {
                                                'plan': dashProvider
                                                    .stripes.subPlanLessons,
                                                'price': dashProvider
                                                    .stripes.subPlanPrice,
                                              },
                                            );
                                            await dashProvider
                                                .loadDashDetails();
                                            Navigator.pushNamed(
                                              context, 'quiz_home_screen');
                                          }
                                        } else if (dashProvider.dashDetails
                                                    .subscriptionStatus ==
                                                1 &&
                                            dashProvider.dashDetails
                                                    .subscriptionLessons ==
                                                0) {
                                          print("charge for stripe");
                                          final actionState = Provider.of<
                                                  ActionButtonsProvider>(
                                              context,
                                              listen: false);
                                          final dashProvider =
                                              Provider.of<DashDetailsProvider>(
                                                  context,
                                                  listen: false);
                                          bool response = await actionState
                                              .getMoreLesson(dashProvider
                                                  .stripes.subPlanLessons);
                                          if (response) {
                                            analytics.logEvent(
                                              name: 'more_lesson',
                                              parameters: {
                                                'plan': dashProvider
                                                    .stripes.subPlanLessons,
                                                'price': dashProvider
                                                    .stripes.subPlanPrice,
                                              },
                                            );
                                            //await dashProvider.loadParamsAsync;
                                            await dashProvider
                                                .loadDashDetails();
                                            Navigator.pushNamed(
                                              context, 'quiz_home_screen');
                                          }
                                        } else if (dashProvider.dashDetails
                                                    .subscriptionStatus ==
                                                0 ||
                                            dashProvider.dashDetails
                                                    .subscriptionLessons ==
                                                0) {
                                          analytics.logEvent(
                                            name: 'checkout_page',
                                            parameters: null,
                                          );
                                          Navigator.pushNamed(context,
                                              StripeSubscriptionScreen.id);
                                        } else {
                                          Navigator.pushNamed(
                                              context, 'quiz_home_screen');
                                        }
                                      }
                                    },
                                    minWidth:
                                        MediaQuery.of(context).size.width * .75,
                                    height: 42.0,
                                    child: Text(
                                      'Start',
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
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
    return _child;
  }
}
