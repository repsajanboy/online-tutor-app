import 'package:flutter/material.dart';
import 'package:justlearn/services/auth/update_password_provider.dart';
import 'package:justlearn/services/bottomnav_provider.dart';
import 'package:justlearn/ui/views/screens/menu_screen.dart';
import 'package:provider/provider.dart';

class UpdatePassword extends StatefulWidget {
  static const String id = "update_pass";
  @override
  _UpdatePasswordState createState() => _UpdatePasswordState();
}

class _UpdatePasswordState extends State<UpdatePassword> {
  final nPassword = TextEditingController();
  final cPassword = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var regId = "";
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;
    if (arguments != null) {
      regId = arguments['regId'];
      print(arguments['regId']);
    }
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Text(
                  'Account Created.',
                  style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 30.0),
              Align(
                alignment: Alignment.topCenter,
                child: Text(
                  'Please update your password.',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 30.0),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    Consumer<UpdatePassProvider>(
                      builder: (context, updatePass, child) => TextField(
                        controller: nPassword,
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'WorkSans',
                            fontWeight: FontWeight.bold),
                        obscureText: true,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(20),
                          filled: true,
                          fillColor: Colors.grey[200],
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 1.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 1.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                          ),
                          hintText: 'New password',
                          errorText: updatePass.npassValid
                              ? "Please enter password"
                              : null,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Consumer<UpdatePassProvider>(
                      builder: (context, updatePass, child) => TextField(
                        controller: cPassword,
                        onChanged: (value) {
                          updatePass.setCPassValid(false);
                          if (nPassword.text == value) {
                            updatePass.setSamePassword(true);
                          } else {
                            updatePass.setSamePassword(false);
                          }
                        },
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'WorkSans',
                            fontWeight: FontWeight.bold),
                        obscureText: true,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(20),
                          filled: true,
                          fillColor: Colors.grey[200],
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 1.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 1.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                          ),
                          hintText: 'Confirm password',
                          errorText: updatePass.cpassValid
                              ? "Please enter password"
                              : updatePass.isSamePassword
                                  ? null
                                  : "Password don't match",
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Consumer<UpdatePassProvider>(
                        builder: (context, updatePass, child) =>
                            updatePass.isLoading
                                ? Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : Material(
                                    color: Color(0xFF3061cc),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(30.0),
                                    ),
                                    elevation: 5.0,
                                    child: MaterialButton(
                                      minWidth: 200.0,
                                      onPressed: () async {
                                        if (nPassword.text.isEmpty) {
                                          updatePass.setNPassValid(true);
                                        } else {
                                          updatePass.setNPassValid(false);
                                        }
                                        if (cPassword.text.isEmpty) {
                                          updatePass.setCPassValid(true);
                                        } else {
                                          updatePass.setCPassValid(false);
                                        }
                                        if (cPassword.text.isNotEmpty &&
                                            nPassword.text.isNotEmpty &&
                                            cPassword.text == nPassword.text) {
                                          updatePass.setIsLoading(true);
                                          //print(regId);
                                        }
                                        if (updatePass.isLoading) {
                                          final response =
                                              await updatePass.updatePassword(
                                                  regId,
                                                  nPassword.text,
                                                  cPassword.text);
                                          if (response) {
                                            updatePass.setIsLoading(false);
                                            final botnavState = Provider.of<
                                                    BottomNavigationBarProvider>(
                                                context,
                                                listen: false);
                                            botnavState.currentIndex = 2;
                                            Navigator.pushNamed(
                                                context, MenuScreen.id);
                                          }
                                        }
                                      },
                                      child: Text(
                                        'Save',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontFamily: 'WorkSans',
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
