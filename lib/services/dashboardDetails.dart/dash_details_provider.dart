import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:justlearn/business_logic/models/auth/params_model.dart';
import 'package:justlearn/business_logic/models/dashDetails/dashboard_details_model.dart';
import 'package:justlearn/business_logic/models/dashDetails/stripe_subscription_model.dart';
import 'package:justlearn/business_logic/models/utils/networking.dart';
import 'package:justlearn/services/shared_preference.dart';
import 'package:http/http.dart' as http;

class DashDetailsProvider with ChangeNotifier {
  DashboardDetailsClass dashDetails = DashboardDetailsClass();
  ParamsResponse loadParams = ParamsResponse();
  StripeSubscription stripes = StripeSubscription();
  bool _dashFetch = false;
  bool isStripeSubs = false;

  bool get dashFetch => _dashFetch;

  get loadParamsAsync => _loadParams();

  _loadParams() async {
    // _dashFetch = true;
    // notifyListeners();
    try {
      ParamsResponse params =
          ParamsResponse.fromJson(await SharedPref().read("params"));
      loadParams = params;
      // notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> loadDashDetails() async {
    // _dashFetch = true;
    // notifyListeners();
    await _loadParams();
    await _checkIfStripe();
    print(loadParams.id);
    var dashUrl = NetworkHelper.baseUrl +
        "api/dashboard-details?userregistrationid=${loadParams.id}&usertype=${loadParams.type}&timezoneinfo=${loadParams.timezoneinfo}&orderid=0";
    print(dashUrl);
    final response = await http.get(dashUrl);
    if (response.statusCode == 200) {
      final result = DashboardDetails.fromJson(json.decode(response.body));
      dashDetails = result.dashboardDetails;
      // _dashFetch = false;
      notifyListeners();
    }
  }

  // get loadDashDetails => _loadDashDetails();

  _checkIfStripe() async {
    var url = NetworkHelper.baseUrl +
        "api/user-stripe-details?userregistrationid=${loadParams.id}";
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final result = StripeSubscription.fromJson(json.decode(response.body));
      stripes = result;
      isStripeSubs = result.success;
      notifyListeners();
    } else {
      print(response.statusCode);
    }
  }

  get checkIfStripe => _checkIfStripe();

}
