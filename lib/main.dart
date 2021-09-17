import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:justlearn/business_logic/models/quiz/colors_model.dart';
import 'package:justlearn/business_logic/models/quiz/stats_model.dart';
import 'package:justlearn/services/action_buttons/action_buttons.dart';
import 'package:justlearn/services/auth/auth_provider.dart';
import 'package:justlearn/services/auth/login_provider.dart';
import 'package:justlearn/services/auth/forgot_password_provider.dart';
import 'package:justlearn/services/auth/signup_provider.dart';
import 'package:justlearn/services/auth/social_login_provider.dart';
import 'package:justlearn/services/auth/update_password_provider.dart';
import 'package:justlearn/services/bottomnav_provider.dart';
import 'package:justlearn/services/calendar/calendar_provider.dart';
import 'package:justlearn/services/dashboardDetails.dart/dash_details_provider.dart';
import 'package:justlearn/services/languageList/language_list_provider.dart';
import 'package:justlearn/services/lessons/lessons_list_api.dart';
import 'package:justlearn/services/livelesson/live_lesson_provider.dart';
import 'package:justlearn/services/quiz/colors_provider.dart';
import 'package:justlearn/services/quiz/quiz_provider.dart';
import 'package:justlearn/services/push_notification_provider.dart';
import 'package:justlearn/services/timezone_provider.dart';
import 'package:justlearn/services/tutors/tutors_list_api.dart';
import 'package:justlearn/services/user_profile/user_edit_profile_provider.dart';
import 'package:justlearn/services/user_profile/user_profile_provider.dart';
import 'package:justlearn/services/videos/videos_screen_provider.dart';
import 'package:justlearn/ui/views/components/edit_time_lesson.dart';
import 'package:justlearn/ui/views/components/new_lesson_calendar.dart';
import 'package:justlearn/ui/views/components/tutors_calendar.dart';
import 'package:justlearn/ui/views/screens/articles/articles_list_screen.dart';
import 'package:justlearn/ui/views/screens/auth/forgot_password.dart';
import 'package:justlearn/ui/views/screens/auth/not_login_screen.dart';
import 'package:justlearn/ui/views/screens/auth/reset_password.dart';
import 'package:justlearn/ui/views/screens/auth/update_password.dart';
import 'package:justlearn/ui/views/screens/auth/verification_code.dart';
import 'package:justlearn/ui/views/screens/auth/website_login.dart';
import 'package:justlearn/ui/views/screens/get_started_login.dart';
import 'package:justlearn/ui/views/screens/getstarted_screen.dart';
import 'package:justlearn/ui/views/screens/livelesson/countdown_live_screen.dart';
import 'package:justlearn/ui/views/screens/livelesson/live_lesson_screen.dart';
import 'package:justlearn/ui/views/screens/menu_screen.dart';
import 'package:justlearn/ui/views/screens/quiz/quiz_home.dart';
import 'package:justlearn/ui/views/screens/select_language_screen.dart';
import 'package:justlearn/ui/views/screens/tutor/stripe_subscription_not_login.dart';
import 'package:justlearn/ui/views/screens/tutor/stripe_subscription_screen.dart';
import 'package:justlearn/ui/views/screens/tutors_screen.dart';
import 'package:justlearn/ui/views/screens/user/edit_student_profile.dart';
import 'package:justlearn/ui/views/screens/videos/video_player_screen.dart';
import 'package:justlearn/ui/views/screens/welcome_screen.dart';
import 'package:provider/provider.dart';
import 'package:time_machine/time_machine.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:justlearn/services/articles/articles_provider.dart';

import 'services/chat/chat_Lesson_provider.dart';
import 'ui/views/screens/auth/login_screen.dart';
import 'ui/views/screens/auth/signup_screen.dart';
//import 'ui/views/screens/home_screen.dart.txt';
import 'ui/views/screens/lesson/chat_lesson_screen.dart';
import 'ui/views/screens/lesson/lessons_screen.dart.txt';
import 'ui/views/screens/tutor/tutor_profile.dart';
import 'ui/views/screens/user/edit_teacher_profile.dart';
import 'ui/views/screens/user/user_profile.dart';
import 'ui/views/screens/user/user_setting.dart';
import 'ui/views/screens/user/user_student_profile.dart';
import 'ui/views/screens/user/user_teacher_profile.dart';
import 'ui/views/screens/articles/article_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'ui/views/screens/chatbot/chatbot_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await Hive.initFlutter();
  Hive.registerAdapter(StatsModelAdapter());
  await Hive.openBox('stats');
  FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  await TimeMachine.initialize({'rootBundle': rootBundle});

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(new MyApp());
  });
}

class MyApp extends StatelessWidget {
  final FirebaseAnalytics analytics = FirebaseAnalytics();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<BottomNavigationBarProvider>(
          create: (context) => BottomNavigationBarProvider(),
        ),
        ChangeNotifierProvider<TutorsListApi>(
          create: (context) => TutorsListApi(),
        ),
        ChangeNotifierProvider<LessonListApi>(
          create: (context) => LessonListApi(),
        ),
        ChangeNotifierProvider<UserProvider>(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider<EditProfileProvider>(
          create: (context) => EditProfileProvider(),
        ),
        ChangeNotifierProvider<LoginProvider>(
          create: (context) => LoginProvider(),
        ),
        ChangeNotifierProvider<ForgotProvider>(
          create: (context) => ForgotProvider(),
        ),
        ChangeNotifierProvider<SocialLoginProvider>(
          create: (context) => SocialLoginProvider(),
        ),
        ChangeNotifierProvider<SignupProvider>(
          create: (context) => SignupProvider(),
        ),
        ChangeNotifierProvider<AuthProvider>(
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProvider<CalendarProvider>(
          create: (context) => CalendarProvider(),
        ),
        ChangeNotifierProvider<DashDetailsProvider>(
          create: (context) => DashDetailsProvider(),
        ),
        ChangeNotifierProvider<ActionButtonsProvider>(
          create: (context) => ActionButtonsProvider(),
        ),
        ChangeNotifierProvider<TimezoneProvider>(
          create: (context) => TimezoneProvider(),
        ),
        ChangeNotifierProvider<ChatLessonProvider>(
          create: (context) => ChatLessonProvider(),
        ),
        ChangeNotifierProvider<LiveLessonProvider>(
          create: (context) => LiveLessonProvider(),
        ),
        ChangeNotifierProvider<LanguageListProvider>(
          create: (context) => LanguageListProvider(),
        ),
        ChangeNotifierProvider<ArticlesProvider>(
          create: (context) => ArticlesProvider(),
        ),
        ChangeNotifierProvider<QuizProvider>(
            create: (context) => QuizProvider()),
        FutureProvider<ColorsModel>(
          create: (context) => ColorsProvider().setColors,
        ),
        ChangeNotifierProvider<PushNotificationProvider>(
          create: (context) => PushNotificationProvider(),
        ),
        ChangeNotifierProvider<UpdatePassProvider>(
          create: (context) => UpdatePassProvider(),
        ),
        ChangeNotifierProvider<VideosProvider>(
          create: (context) => VideosProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: GetStarted.id,
        routes: {
          GetStarted.id: (context) => GetStarted(),
          SelectLanguageScreen.id: (context) => SelectLanguageScreen(),
          WelcomeScreen.id: (context) => WelcomeScreen(),
          LoginScreen.id: (context) => LoginScreen(),
          MenuScreen.id: (context) => MenuScreen(),
          TutorProfile.id: (context) => TutorProfile(),
          UserProfile.id: (context) => UserProfile(),
          UserTeacherProfile.id: (context) => UserTeacherProfile(),
          UserSetting.id: (context) => UserSetting(),
          LessonScreen.id: (context) => LessonScreen(),
          SignupScreen.id: (context) => SignupScreen(),
          //HomeScreen.id: (context) => HomeScreen(),
          TutorsCalendar.id: (context) => TutorsCalendar(),
          EditTimeLesson.id: (context) => EditTimeLesson(),
          NewLessonCalender.id: (context) => NewLessonCalender(),
          UserStudentProfile.id: (context) => UserStudentProfile(),
          EditTeacher.id: (context) => EditTeacher(),
          ForgotPassword.id: (context) => ForgotPassword(),
          ResetPassword.id: (context) => ResetPassword(),
          EditStudent.id: (context) => EditStudent(),
          VerificationCode.id: (context) => VerificationCode(),
          ChatScreen.id: (context) => ChatScreen(),
          LiveLessonScreen.id: (context) => LiveLessonScreen(),
          CountDownLive.id: (context) => CountDownLive(),
          TutorsScreen.id: (context) => TutorsScreen(),
          ArticleScreen.id: (context) => ArticleScreen(),
          ArticlesListScreen.id: (context) => ArticlesListScreen(),
          ChatbotScreen.id: (context) => ChatbotScreen(),
          StripeSubscriptionScreen.id: (context) => StripeSubscriptionScreen(),
          QuizHomeScreen.id: (context) => QuizHomeScreen(),
          NotYetLoginScreen.id: (context) => NotYetLoginScreen(),
          StripeSubscriptionNotLogin.id: (context) =>
              StripeSubscriptionNotLogin(),
          UpdatePassword.id: (context) => UpdatePassword(),
          LoginWebsite.id: (context) => LoginWebsite(),
          GetStartedLogin.id: (context) => GetStartedLogin(),
          VideoPlayerScreen.id: (context) => VideoPlayerScreen(),
        },
        navigatorObservers: [
          FirebaseAnalyticsObserver(analytics: analytics),
        ],
      ),
    );
  }
}
