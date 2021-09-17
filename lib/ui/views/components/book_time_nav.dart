import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:justlearn/services/action_buttons/action_buttons.dart';
//import 'package:justlearn/services/auth/auth_provider.dart';
import 'package:justlearn/services/dashboardDetails.dart/dash_details_provider.dart';
import 'package:justlearn/services/lessons/lessons_list_api.dart';
import 'package:justlearn/ui/views/components/new_lesson_calendar.dart';
//import 'package:justlearn/ui/views/screens/tutor/stripe_subscription_not_login.dart';
import 'package:justlearn/ui/views/screens/tutor/stripe_subscription_screen.dart';
import 'package:provider/provider.dart';

class BookTimeNav extends StatelessWidget {
  final int tutorsId;
  final String language;
  static FirebaseAnalytics analytics = FirebaseAnalytics();

  const BookTimeNav({Key key, this.tutorsId, this.language}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    print(tutorsId);
    final dashProvider =
        Provider.of<DashDetailsProvider>(context, listen: false);
    //final authState = Provider.of<AuthProvider>(context, listen: false);
    Provider.of<ActionButtonsProvider>(context, listen: false).loadParamsAsync;
    return Consumer<ActionButtonsProvider>(
      builder: (context, actionState, child) => Container(
        margin: EdgeInsets.all(10),
        child: FlatButton(
          color: Color(0xFF3061cc),
          onPressed: () async {
            final lessonState =
                Provider.of<LessonListApi>(context, listen: false);
            if (dashProvider.dashDetails.subscriptionLessons == 0 &&
                dashProvider.dashDetails.subscriptionStatus == 0) {
              analytics.logEvent(
                name: 'checkout_page',
                parameters: null,
              );
              Navigator.pushNamed(context, StripeSubscriptionScreen.id);
            } else {
              if (dashProvider.dashDetails.subscriptionStatus == 1 &&
                  dashProvider.dashDetails.subscriptionLessons == 0 &&
                  dashProvider.dashDetails.isTrialPeriod) {
                bool response = await actionState
                    .getMoreLessonTrial(int.parse(actionState.loadParams.id));
                if (response) {
                  print('more-lesson-endtrial');
                  analytics.logEvent(
                    name: 'more_lesson-trial',
                    parameters: {
                      'plan': dashProvider.stripes.subPlanLessons,
                      'price': dashProvider.stripes.subPlanPrice,
                    },
                  );
                  await dashProvider.loadDashDetails();
                  await lessonState.loadParamsAsync;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          NewLessonCalender(teachersId: tutorsId),
                    ),
                  );
                }
              } else if (dashProvider.dashDetails.subscriptionStatus == 1 &&
                  dashProvider.dashDetails.subscriptionLessons == 0) {
                print("charge for stripe");
                bool response = await actionState
                    .getMoreLesson(dashProvider.stripes.subPlanLessons);
                if (response) {
                  analytics.logEvent(
                    name: 'more_lesson',
                    parameters: {
                      'plan': dashProvider.stripes.subPlanLessons,
                      'price': dashProvider.stripes.subPlanPrice,
                    },
                  );
                  //await dashProvider.loadParamsAsync;
                  await dashProvider.loadDashDetails();
                  await lessonState.loadParamsAsync;
                  //await lessonState.setListNull();
                  //await lessonState.getLessonsList(lessonState.page);
                  //Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          NewLessonCalender(teachersId: tutorsId),
                    ),
                  );
                }
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        NewLessonCalender(teachersId: tutorsId),
                  ),
                );
              }
            }
          },
          child: actionState.isMoreLessonLoads
              ? Container(
                  height: 65.0,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "BOOK",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 23,
                            fontFamily: "WorkSans",
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
