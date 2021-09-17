import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:justlearn/business_logic/models/products/products_model.dart';
import 'package:justlearn/business_logic/models/utils/credit_card_masked.dart';
import 'package:justlearn/business_logic/models/utils/expiry_card_masked.dart';
import 'package:justlearn/services/bottomnav_provider.dart';
import 'package:justlearn/services/dashboardDetails.dart/dash_details_provider.dart';
import 'package:justlearn/services/stripe_subscription/stripe_subscription_services.dart';
import 'package:justlearn/ui/views/screens/menu_screen.dart';
import 'package:provider/provider.dart';

class StripeSubscriptionScreen extends StatefulWidget {
  static const String id = "stripe_subscription";
  final Products products;
  const StripeSubscriptionScreen({
    Key key,
    this.products,
  }) : super(key: key);
  @override
  _StripeSubscriptionScreenState createState() =>
      _StripeSubscriptionScreenState();
}

class _StripeSubscriptionScreenState extends State<StripeSubscriptionScreen> {
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  int _currentIndex = 1;
  Products selectedPackage;
  bool isLoading = false;
  bool isCredNumberValid = false;
  bool isExpireValid = false;
  bool isCVCValid = false;
  final credNumber = TextEditingController();
  final expire = TextEditingController();
  final cvc = TextEditingController();
  @override
  initState() {
    super.initState();
    selectedPackage = productsB[1];
    StripeService.init();
  }

  void showInfoFlushbar(
    BuildContext context,
    String message,
  ) {
    Flushbar(
      // title: title,
      message: message,
      icon: Icon(
        Icons.info_outline,
        size: 28,
        color: Color(0xFF3061cc),
      ),
      leftBarIndicatorColor: Color(0xFF3061cc),
      duration: Duration(seconds: 5),
    )..show(context);
  }

  Widget build(BuildContext context) {
    print('stripe subs build');
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '',
          style: TextStyle(color: Colors.black),
        ),
        leading: BackButton(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        brightness: Brightness.light,
        //automaticallyImplyLeading: false,
      ),
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: [
              SizedBox(
                height: 10.0,
              ),
              Container(
                margin: EdgeInsets.only(bottom: 8),
                padding: EdgeInsets.only(
                    top: 10.0, bottom: 10.0, right: 15.0, left: 15.0),
                // decoration: BoxDecoration(
                //   borderRadius: BorderRadius.circular(5.0),
                //   border: Border.all(
                //     color: Colors.grey,
                //     width: 1,
                //   ),
                // ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          '7 Days Free Trial.',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'WorkSans',
                            fontSize: 22.0,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Card Number',
                          style: TextStyle(fontSize: 18.0),
                        ),
                        Row(
                          children: [
                            SvgPicture.string(
                                '<svg width="24px" height="8px" version="1.1" viewBox="0 0 24 8" xmlns="http://www.w3.org/2000/svg"><defs><linearGradient id="d" x1="30.34" x2="539.08" y1="90.79" y2="87.44" gradientTransform="scale(.04428 .045714)" gradientUnits="userSpaceOnUse"><stop stop-color="#262860" offset="0"></stop><stop stop-color="#3D429B" offset="1"></stop></linearGradient><linearGradient id="c" x1="30.33" x2="539.07" y1="89.51" y2="86.17" gradientTransform="scale(.04428 .045714)" gradientUnits="userSpaceOnUse"><stop stop-color="#262860" offset="0"></stop><stop stop-color="#3D429B" offset="1"></stop></linearGradient><linearGradient id="b" x1="30.32" x2="539.06" y1="87.98" y2="84.63" gradientTransform="scale(.04428 .045714)" gradientUnits="userSpaceOnUse"><stop stop-color="#262860" offset="0"></stop><stop stop-color="#3D429B" offset="1"></stop></linearGradient><linearGradient id="a" x1="30.32" x2="539.07" y1="89.13" y2="85.79" gradientTransform="scale(.04428 .045714)" gradientUnits="userSpaceOnUse"><stop stop-color="#262860" offset="0"></stop><stop stop-color="#3D429B" offset="1"></stop></linearGradient></defs><g><path d="m23.996 7.875h-1.8047c-0.066406-0.32812-0.13672-0.64844-0.19531-0.96875-0.023438-0.13672-0.0625-0.1875-0.20703-0.18359-0.72656 0.007813-1.4492 0.007813-2.1758 0-0.10938 0-0.15234 0.035156-0.1875 0.14062-0.097656 0.30469-0.20703 0.61328-0.32031 0.91406-0.015625 0.042968-0.0625 0.10156-0.097657 0.10156-0.65234 0.003906-1.3086 0.003906-1.9766 0.003906 0.12109-0.30469 0.23828-0.59375 0.35156-0.88672 0.84375-2.0742 1.6875-4.1484 2.5273-6.2188 0.18359-0.45312 0.45703-0.64062 0.92969-0.64062h1.582c0.054687 0.25391 0.10547 0.50391 0.15625 0.75391 0.41797 2.0469 0.83203 4.0977 1.2461 6.1484 0.050781 0.26172 0.11328 0.51953 0.17188 0.78125zm-2.3633-2.75l-0.57422-2.832-0.023438-0.003907-0.99609 2.8359z" fill="url(#d)"></path><path d="m16.125 0c0.23828 0.046875 0.48047 0.082031 0.71484 0.14062 0.21875 0.050781 0.42969 0.12109 0.65625 0.1875-0.11328 0.55859-0.22656 1.1016-0.33594 1.6328-0.30469-0.089844-0.59375-0.19531-0.88672-0.26172-0.40625-0.09375-0.82031-0.12891-1.2266-0.011719-0.17188 0.050781-0.32812 0.13672-0.46484 0.25391-0.21875 0.19531-0.22656 0.48047-0.011719 0.68359 0.15234 0.14062 0.31641 0.26172 0.49609 0.36719 0.39453 0.24609 0.80859 0.45703 1.1953 0.72266 0.44922 0.30859 0.78125 0.73047 0.85156 1.3047 0.12109 1.0156-0.24219 1.8164-1.0664 2.3789-0.51953 0.35547-1.1094 0.51562-1.7227 0.57422-0.84375 0.082032-1.6992-0.015625-2.5078-0.29297-0.054687-0.019532-0.10938-0.042969-0.16016-0.066407-0.019531-0.007812-0.039062-0.019531-0.054688-0.03125 0.11328-0.55859 0.23047-1.1172 0.34766-1.6914 0.14062 0.0625 0.26953 0.125 0.40625 0.17969 0.63672 0.26563 1.2969 0.38672 1.9805 0.25781 0.17969-0.039063 0.35547-0.11328 0.50781-0.22266 0.32812-0.22656 0.35938-0.64844 0.0625-0.91406-0.19922-0.17578-0.43359-0.30469-0.65625-0.44531-0.35156-0.21484-0.71875-0.40234-1.0508-0.64844-0.42188-0.3125-0.72656-0.73047-0.78516-1.2891-0.089843-0.83203 0.21094-1.5078 0.83203-2.0352 0.53906-0.45703 1.1797-0.66016 1.8594-0.74609 0.039062-0.0078126 0.078125-0.015625 0.11328-0.027344z" fill="url(#c)"></path><path d="m9.1016 0.14453c-0.10156 0.25-0.19531 0.49219-0.29297 0.73047-0.92969 2.293-1.8594 4.582-2.7852 6.8711-0.046876 0.10938-0.097657 0.13672-0.20703 0.13672-0.58594-0.003906-1.1719-0.003906-1.7617 0-0.12109 0-0.16406-0.042968-0.19141-0.15625-0.49609-2-1.0039-4-1.4961-6.0039-0.089844-0.36719-0.27344-0.61719-0.60938-0.77344-0.54297-0.23828-1.1094-0.42578-1.6836-0.55859l-0.074219-0.019531c0.0039062-0.23438 0.0039062-0.23438 0.21875-0.23438h3.0781c0.48828 0 0.83984 0.29297 0.92969 0.78906 0.26172 1.4102 0.51953 2.8242 0.77734 4.2305 0.011719 0.0625 0.023438 0.125 0.039063 0.21094 0.027343-0.050782 0.046875-0.082032 0.058593-0.11328 0.63672-1.6641 1.2734-3.332 1.9102-4.9961 0.035156-0.09375 0.078125-0.125 0.17188-0.12109 0.59375 0.003906 1.1914 0 1.7852 0 0.039062 0 0.078125 0.003906 0.13281 0.007812z" fill="url(#b)"></path><path d="m8.3242 7.8828c0.53516-2.5898 1.0703-5.1602 1.6016-7.7383h1.9492c-0.082031 0.39453-0.16016 0.77734-0.24219 1.1641-0.44141 2.1289-0.87891 4.2578-1.3203 6.3828-0.027344 0.14844-0.078125 0.19531-0.22656 0.19531-0.53125-0.011719-1.0664-0.003907-1.6016-0.003907z" fill="url(#a)"></path></g></svg>'),
                            SizedBox(width: 8.0),
                            SvgPicture.string(
                                '<svg width="25px" height="16px" version="1.1" viewBox="0 0 25 16" xmlns="http://www.w3.org/2000/svg"><g><path d="m8.8359 1.9219h7.2812v12.242h-7.2812z" fill="#FF5F00"></path><path d="m9.5859 8.043c-0.003907-2.3867 1.0625-4.6445 2.8906-6.1172-3.1016-2.5078-7.5547-2.1445-10.23 0.83594-2.6758 2.9844-2.6758 7.582 0 10.562 2.6758 2.9844 7.1289 3.3477 10.23 0.83984-1.8281-1.4766-2.8945-3.7305-2.8906-6.1211z" fill="#EB001A"></path><path d="m23.988 12.867v-0.25h0.10547v-0.054688h-0.25v0.054688h0.10547v0.25zm0.48828 0v-0.30469h-0.078124l-0.085938 0.21875-0.089844-0.21875h-0.074218v0.30469h0.054687v-0.23047l0.082031 0.19922h0.054688l0.082031-0.19922v0.23047z" fill="#F69D1A"></path><path d="m24.711 8.043c0 2.9805-1.6523 5.6992-4.2578 7-2.6055 1.3047-5.7031 0.96094-7.9766-0.87891 3.2773-2.6562 3.8438-7.543 1.2695-10.922-0.37109-0.48828-0.79688-0.92578-1.2695-1.3086 2.2734-1.8438 5.3711-2.1836 7.9766-0.88281s4.2578 4.0195 4.2578 7z" fill="#F69D1A"></path></g></svg>'),
                            SizedBox(width: 8.0),
                            SvgPicture.string(
                                '<svg width="25px" height="16px" version="1.1" viewBox="0 0 25 16" xmlns="http://www.w3.org/2000/svg"><g><path d="m9.1836 1.668h6.8047v12.309h-6.8047z" fill="#7578B9"></path><path d="m9.6133 7.8281c-0.003906-2.4062 1.0938-4.6758 2.9766-6.1602-3.1914-2.5234-7.7734-2.1562-10.527 0.84375s-2.7539 7.625 0 10.621c2.7539 3 7.3359 3.3672 10.527 0.84375-1.8828-1.4766-2.9805-3.7461-2.9766-6.1484z" fill="#E51A23"></path><path d="m24.434 12.676v-0.25391h0.10156-0.26172 0.10156v0.25391zm0.5 0v-0.30859h-0.082032l-0.089843 0.21484-0.089844-0.21484h-0.082031v0.30859h0.058594v-0.23047l0.089843 0.19531h0.058594l0.078125-0.19531v0.23047z" fill="#221F20"></path><path d="m25.172 7.8281c0 2.9961-1.6992 5.7266-4.375 7.0352-2.6797 1.3125-5.8672 0.96484-8.207-0.88672 1.875-1.4844 2.9688-3.7539 2.9688-6.1523 0-2.4023-1.0938-4.668-2.9688-6.1562 2.3438-1.8516 5.5312-2.1953 8.2109-0.88281 2.6797 1.3086 4.375 4.0469 4.3711 7.043z" fill="#00ABE7"></path></g></svg>'),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 10.0),
                    TextField(
                      controller: credNumber,
                      onChanged: (value) {
                        print(value);
                        //loginProvider.checkValidEmail(value);
                      },
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        MaskedTextInputFormatter(
                            mask: '1234 1234 1234 1234', separator: ' '),
                        FilteringTextInputFormatter.allow(RegExp(r"[0-9]+|\s"))
                      ],
                      decoration: InputDecoration(
                        hintText: '1234 1234 1234 1234',
                        errorText:
                            isCredNumberValid ? "This field is required" : null,
                        suffixIcon: Icon(Icons.lock),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: TextField(
                            controller: expire,
                            onChanged: (value) {
                              print(value);
                              //loginProvider.checkValidEmail(value);
                            },
                            inputFormatters: [
                              MaskedTextExpiryInputFormatter(
                                  mask: '00/00', separator: '/'),
                              FilteringTextInputFormatter.allow(
                                  RegExp(r"[0-9]+|\/"))
                            ],
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: 'MM/YY',
                              errorText: isExpireValid
                                  ? "This field is required"
                                  : null,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 10.0),
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Expanded(
                          child: TextField(
                            controller: cvc,
                            onChanged: (value) {
                              print(value);
                              //loginProvider.checkValidEmail(value);
                            },
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            obscureText: true,
                            maxLength: 3,
                            decoration: InputDecoration(
                              hintText: 'CVC',
                              errorText:
                                  isCVCValid ? "This field is required" : null,
                              counterText: '',
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 10.0),
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.all(10.0),
                      margin: EdgeInsets.symmetric(vertical: 10.0),
                      decoration: BoxDecoration(color: Colors.grey[200]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${selectedPackage.lesson} Lessons',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0),
                              ),
                              Text(
                                '\$${selectedPackage.price}/month',
                                style: TextStyle(fontSize: 18.0),
                              )
                            ],
                          ),
                          FlatButton(
                            onPressed: () async {
                              print('change click');
                              int reponse = await _showProductsDialog();
                              setState(() {
                                selectedPackage = productsB[reponse];
                              });
                            },
                            child: Text(
                              'Change',
                              style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF3061cc)),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
                      child: isLoading
                          ? CircularProgressIndicator()
                          : FlatButton(
                              color: Color(0xFF3061cc),
                              onPressed: () async {
                                setState(() {
                                  credNumber.text.isEmpty
                                      ? isCredNumberValid = true
                                      : isCredNumberValid = false;
                                  expire.text.isEmpty
                                      ? isExpireValid = true
                                      : isExpireValid = false;
                                  cvc.text.isEmpty
                                      ? isCVCValid = true
                                      : isCVCValid = false;
                                });
                                if (credNumber.text.isNotEmpty &&
                                    expire.text.isNotEmpty &&
                                    cvc.text.isNotEmpty) {
                                  setState(() {
                                    isLoading = true;
                                  });
                                }
                                if (isLoading) {
                                  var numberCred =
                                      credNumber.text.replaceAll(' ', '');
                                  var expiry = expire.text.split('/');
                                  var expMonth = expiry[0];
                                  var expYear = expiry[1];
                                  print(numberCred);
                                  print(expMonth);
                                  print(expYear);

                                  final dashProvider =
                                      Provider.of<DashDetailsProvider>(context,
                                          listen: false);
                                  var type = dashProvider.loadParams.type;
                                  var regId = dashProvider.loadParams.id;
                                  try {
                                    var response =
                                        await StripeService.payWithNewCard(
                                      false,
                                      selectedPackage.lesson,
                                      selectedPackage.price,
                                      selectedPackage.plan,
                                      type,
                                      regId,
                                      numberCred,
                                      int.parse(expMonth),
                                      int.parse(expYear),
                                      cvc.text,
                                    );
                                    if (response['success'] == true) {
                                      analytics.logEvent(
                                        name: 'buy_lesson',
                                        parameters: {
                                          'plan': selectedPackage.lesson,
                                          'price': selectedPackage.price,
                                        },
                                      );
                                      //await dashProvider.loadParamsAsync;
                                      await dashProvider.loadDashDetails();
                                      setState(() {
                                        isLoading = false;
                                      });
                                      final botnavState = Provider.of<
                                              BottomNavigationBarProvider>(
                                          context,
                                          listen: false);
                                      botnavState.currentIndex = 1;
                                      Navigator.pushNamed(
                                          context, MenuScreen.id);
                                      //Navigator.pushNamed(context, routeName)
                                    } else {
                                      setState(() {
                                        isLoading = false;
                                      });
                                      showInfoFlushbar(
                                        context,
                                        "${response['message']}",
                                      );
                                      //print("cancel");
                                    }
                                  } catch (err) {
                                    print(err.toString());
                                  }
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Start Membership",
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<int> _showProductsDialog() async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context, _currentIndex);
              },
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'x',
                  style: TextStyle(color: Colors.grey[400], fontSize: 22.0),
                ),
              ),
            ),
          ),
          content: StatefulBuilder(
            builder: (BuildContext context, setState) {
              void _handleRadioValueChange1(int value) async {
                setState(() {
                  _currentIndex = value;
                });
              }

              return Container(
                height: 150,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  itemCount: productsB.length,
                  itemBuilder: (BuildContext context, int index) {
                    Products pack = productsB[index];
                    selectedPackage = productsB[_currentIndex];
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: [
                            Radio(
                              value: index,
                              groupValue: _currentIndex,
                              onChanged: _handleRadioValueChange1,
                            ),
                            Container(
                              child: Text(
                                '${pack.lesson} Lessons',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontFamily: 'WorkSans',
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          '\$${pack.price}/mo',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontFamily: 'WorkSans',
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    );
                  },
                ),
              );
            },
          ),
          actions: [
            FlatButton(
              color: Color(0xFF3061cc),
              textColor: Colors.white,
              child: Text(
                'Start Plan',
                style: TextStyle(fontSize: 18.0),
              ),
              onPressed: () async {
                Navigator.pop(context, _currentIndex);
              },
            ),
          ],
        );
      },
    );
  }
}
