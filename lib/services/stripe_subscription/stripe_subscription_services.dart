import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:justlearn/business_logic/models/users/get_user_id_model.dart';
import 'package:justlearn/business_logic/models/users/users_model.dart';
import 'package:justlearn/business_logic/models/users/users_student_model.dart';
import 'package:justlearn/business_logic/models/utils/networking.dart';
import 'package:stripe_payment/stripe_payment.dart';

class StripeService with ChangeNotifier {
  static String apiBase = 'https://api.stripe.com/v1';
  static String paymentApiUrl = '${StripeService.apiBase}/payment_intents';
  static String createCustomerUrl = '${StripeService.apiBase}/customers';
  static String createSubscriptionUrl =
      '${StripeService.apiBase}/subscriptions';
  //static String secret = 'sk_test_Q3Fg7iQUFUGoFiRLD1vk6JB7'; test
  static String secret = 'sk_live_C3HLwzsK1lVgLLnMXY0lh339';
  static Map<String, String> headers = {
    'Authorization': 'Bearer ${StripeService.secret}',
    'Content-Type': 'application/x-www-form-urlencoded'
  };
  static init() {
    StripePayment.setOptions(
      StripeOptions(
        //publishableKey: "pk_test_eDNz2RwfwLKiR3QxhuxfLYGz", test
        publishableKey: "pk_live_MpwoXA50yy5DkB0CUFCCU9qK",
        //merchantId: "Test",
        //androidPayMode: 'test',
      ),
    );
  }

  static Future<GetUserResponse> checkIfUserExist(String email) async {
    var url = NetworkHelper.baseUrl + 'api/user-regid?email=$email';
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final result = GetUserResponse.fromJson(json.decode(response.body));
      return result;
    } else {
      print('check-user: ' + response.statusCode.toString());
    }
    return null;
  }

  static Future<Map<String, dynamic>> payWithNewCard(
      bool isSubs,
      int lesson,
      int price,
      String plan,
      String type,
      String regId,
      String credNumber,
      int expMonth,
      int expYear,
      String cvc) async {
    Student student = Student();
    Profile teacher = Profile();
    //Info infos = Info();
    try {
      var paymentMethod = await StripeService.createPaymentMethod(
          credNumber, expMonth, expYear, cvc);
      if (paymentMethod['success'] == true) {
        var paymentMethId = paymentMethod['result'];
        if (type == 'T') {
          var url = NetworkHelper.baseUrl +
              "api/user-profile?userregistrationid=$regId&usertype=$type";
          final response = await http.get(url);
          if (response.statusCode == 200) {
            final result =
                UsersTeacherProfile.fromJson(json.decode(response.body));
            teacher = result.info.profile;
            //infos = result.info;
          }
          if (isSubs) {
            var payment = await StripeService.makeSubscription(
                regId,
                teacher.firstName,
                teacher.email,
                paymentMethId,
                plan,
                lesson,
                price);
            print(payment['result']);
            print(payment['success']);
            print(payment['message']);
            return payment;
          } else {
            var payment = await StripeService.makeSubscriptionTrial(
                regId,
                teacher.firstName,
                teacher.email,
                paymentMethId,
                plan,
                lesson,
                price);
            print(payment['result']);
            print(payment['success']);
            print(payment['message']);
            return payment;
          }
        } else {
          var url = NetworkHelper.baseUrl +
              "api/user-profile?userregistrationid=$regId&usertype=$type";
          final response = await http.get(url);
          if (response.statusCode == 200) {
            final result =
                UsersStudentProfile.fromJson(json.decode(response.body));
            student = result.student;
          }
          if (isSubs) {
            var payment = await StripeService.makeSubscription(
                regId,
                student.firstName,
                student.email,
                paymentMethId,
                plan,
                lesson,
                price);
            print(payment['result']);
            print(payment['success']);
            print(payment['message']);
            return payment;
          } else {
            var payment = await StripeService.makeSubscriptionTrial(
                regId,
                student.firstName,
                student.email,
                paymentMethId,
                plan,
                lesson,
                price);
            print(payment['result']);
            print(payment['success']);
            print(payment['message']);
            return payment;
          }
        }
      } else {
        return paymentMethod;
      }
    } on PlatformException catch (err) {
      print(err);
      print("cancelled");
      Map<String, dynamic> payment = {'success': false};
      print(payment['success']);
      return payment;
    } catch (err) {
      print(err);
    }
    return null;
  }

  static Future<Map<String, dynamic>> createPaymentMethod(
      String number, int expMonth, int expYear, String cvc) async {
    var url = NetworkHelper.baseUrl + 'api/stripe-payment-method';
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(
        {
          "Number": "$number",
          "ExpMonth": expMonth,
          "ExpYear": expYear,
          "Cvc": "$cvc"
        },
      ),
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      print(response.statusCode);
    }
    return null;
  }

  static Future<Map<String, dynamic>> makeSubscriptionTrial(
      String regId,
      String fullName,
      String email,
      String paymentMethodId,
      String plan,
      int planLessons,
      int planPrice) async {
    int reggId = int.parse(regId);
    try {
      print(reggId.toString() +
          ' ' +
          fullName +
          ' ' +
          email +
          ' ' +
          paymentMethodId +
          ' ' +
          plan +
          ' ' +
          planLessons.toString() +
          ' ' +
          planPrice.toString());
      var url = NetworkHelper.baseUrl + 'api/stripe-payment-trial';
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(
          {
            "RegistrationId": reggId,
            "FullName": "$fullName",
            "Email": "$email",
            "PaymentMethodId": "$paymentMethodId",
            "Plan": "$plan",
            "Planlessons": planLessons,
            "PlanPrice": planPrice
          },
        ),
      );
      if (response.statusCode == 200) {
        print('status');
        return jsonDecode(response.body);
      } else {
        print(response.statusCode);
      }
    } catch (err) {
      print('err subs: ${err.toString()}');
    }
    return null;
  }

  static Future<Map<String, dynamic>> makeSubscription(
      String regId,
      String fullName,
      String email,
      String paymentMethodId,
      String plan,
      int planLessons,
      int planPrice) async {
    int reggId = int.parse(regId);
    try {
      print(reggId.toString() +
          ' ' +
          fullName +
          ' ' +
          email +
          ' ' +
          paymentMethodId +
          ' ' +
          plan +
          ' ' +
          planLessons.toString() +
          ' ' +
          planPrice.toString());
      var url = NetworkHelper.baseUrl + 'api/stripe-payment';
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(
          {
            "RegistrationId": reggId,
            "FullName": "$fullName",
            "Email": "$email",
            "PaymentMethodId": "$paymentMethodId",
            "Plan": "$plan",
            "Planlessons": planLessons,
            "PlanPrice": planPrice
          },
        ),
      );
      if (response.statusCode == 200) {
        print('status');
        return jsonDecode(response.body);
      } else {
        print(response.statusCode);
      }
    } catch (err) {
      print('err subs: ${err.toString()}');
    }
    return null;
  }
}
