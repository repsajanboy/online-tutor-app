import 'dart:io';

import 'package:flutter/material.dart';
import 'package:justlearn/business_logic/models/timezone_list_model.dart';

import 'dart:convert';

import 'package:justlearn/business_logic/models/utils/networking.dart';
import 'package:image_picker/image_picker.dart';
import 'package:justlearn/services/timezone_provider.dart';
import 'package:justlearn/services/user_profile/user_edit_profile_provider.dart';
import 'package:justlearn/services/user_profile/user_profile_provider.dart';
import 'package:provider/provider.dart';

class EditStudent extends StatefulWidget {
  static const String id = "edit_student_profile";
  final Timezone timezones;

  const EditStudent({Key key, this.timezones}) : super(key: key);
  @override
  _EditStudentState createState() => _EditStudentState();
}

class _EditStudentState extends State<EditStudent>
    with TickerProviderStateMixin {
  TabController _controller;

  final firstname = TextEditingController();
  final lastname = TextEditingController();
  final email = TextEditingController();
  List<DropdownMenuItem<Timezone>> _dropdownMenuItems;
  Timezone _selectedTimezone;
  Timezone timezone;
  String studentTimezone;
  String studentGMT;
  File file;
  String status = '';
  String base64Image;
  File tmpFile;
  bool isPhotoChange = false;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        file = File(pickedFile.path);
        tmpFile = file;
        base64Image = base64Encode(file.readAsBytesSync());
        isPhotoChange = true;
      } else {
        print('No image selected.');
      }
    });
    print(base64Image);
  }

  Widget showImage() {
    final studentProvider =
        Provider.of<EditProfileProvider>(context, listen: false);
    if (file != null) {
      return Image.file(file, fit: BoxFit.fill);
    } else {
      return "${studentProvider.student.profileImage}".isEmpty
          ? Image.network(
              'https://www.cdnjustlearn.com/image/intet-billede.jpg',
              fit: BoxFit.cover,
            )
          : Image.network(
              '${NetworkHelper.imgUrl}${studentProvider.student.profileImage}',
              fit: BoxFit.cover);
    }
  }

  List<DropdownMenuItem<Timezone>> buildDropdownMenuItems(List timezones) {
    List<DropdownMenuItem<Timezone>> items = List();
    for (Timezone timezone in timezones) {
      items.add(
        DropdownMenuItem(
          value: timezone,
          child: Text(timezone.name + " GTM" + "(" + timezone.timezone + ")"),
        ),
      );
    }
    return items;
  }

  onChangeDropdownItem(Timezone selectedTimezone) {
    setState(() {
      _selectedTimezone = selectedTimezone;
      print(_selectedTimezone.name);
    });
  }

  //alert dialog
  showAlertDialog(BuildContext context) {
    Widget continueButton = FlatButton(
      child: Text("Ok"),
      onPressed: () async {
        int count = 0;
        final editState =
            Provider.of<EditProfileProvider>(context, listen: false);
        await editState.loadParamsAsync;
        await editState.checkUser();
        editState.setIsLoading(false);
        Navigator.of(context).popUntil((_) => count++ >= 2);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Succesfully updated"),
      content: Text("Your profile is now updated"),
      actions: [
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<void> _showUpdateFailed(String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(child: Text('Oops')),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            Center(
              child: FlatButton(
                child: Text('Ok'),
                onPressed: () {
                  final studentProvider =
                      Provider.of<EditProfileProvider>(context, listen: false);
                  studentProvider.setIsLoading(false);
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    final studentProvider =
        Provider.of<EditProfileProvider>(context, listen: false);
    final tzoneProvider = Provider.of<TimezoneProvider>(context, listen: false);
    _dropdownMenuItems = buildDropdownMenuItems(tzoneProvider.timezoneList);
    int index0 = _dropdownMenuItems.indexWhere((timezone) => timezone.value.name
        .contains('${studentProvider.student.timezoneInfo}'));
    _selectedTimezone = _dropdownMenuItems[index0].value;
    _controller = new TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Consumer<EditProfileProvider>(
        builder: (context, studentProvider, child) => Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              child: Row(
                children: <Widget>[
                  Container(
                    height: 180,
                    width: 150,
                    decoration: BoxDecoration(
                        color: Colors.grey[350],
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(10))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(child: showImage()),
                        FlatButton(
                          color: Colors.blue[300],
                          onPressed: () async {
                            print('Got Click!');
                            getImage();
                          },
                          child: Text(
                            'Upload a photo',
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    width: 150,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${studentProvider.student.firstName}',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: "WorkSans"),
                        ),
                        Text(
                          '${studentProvider.student.lastName}',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: "WorkSans"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
                padding: const EdgeInsets.fromLTRB(15, 25, 15, 15),
                child: TabBar(controller: _controller, tabs: [
                  Tab(
                    child: Column(
                      children: <Widget>[
                        Icon(Icons.settings, color: Color(0xFF3061cc)),
                        Text(
                          "General",
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 15,
                              fontFamily: "WorkSans"),
                        ),
                      ],
                    ),
                  ),
                  Tab(
                    child: Column(
                      children: <Widget>[
                        Icon(Icons.subscriptions, color: Color(0xFF3061cc)),
                        Text(
                          "Subscription",
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 15,
                              fontFamily: "WorkSans"),
                        ),
                      ],
                    ),
                  ),
                ])),
            Expanded(
              child: TabBarView(controller: _controller, children: [
                SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            margin: EdgeInsets.all(15),
                            color: Colors.white,
                            shadowColor: Colors.grey[300],
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 20, 20, 0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Text(
                                          'First Name',
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontFamily: 'WorkSans'),
                                        ),
                                      ),
                                      TextField(
                                        controller: firstname,
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontFamily: 'WorkSans',
                                            fontWeight: FontWeight.bold),
                                        obscureText: false,
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
                                            borderSide: BorderSide(
                                                color: Colors.white,
                                                width: 1.0),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15.0)),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.white,
                                                width: 1.0),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15.0)),
                                          ),
                                          hintText:
                                              '${studentProvider.student.firstName}',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 10, 20, 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Text(
                                          'Last Name',
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontFamily: 'WorkSans'),
                                        ),
                                      ),
                                      TextField(
                                        controller: lastname,
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontFamily: 'WorkSans',
                                            fontWeight: FontWeight.bold),
                                        obscureText: false,
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
                                            borderSide: BorderSide(
                                                color: Colors.white,
                                                width: 1.0),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15.0)),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.white,
                                                width: 1.0),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15.0)),
                                          ),
                                          hintText:
                                              '${studentProvider.student.lastName}',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      bottom: 20.0, left: 20.0, right: 20.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Text(
                                          'Email',
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontFamily: 'WorkSans'),
                                        ),
                                      ),
                                      TextField(
                                        controller: email,
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontFamily: 'WorkSans',
                                            fontWeight: FontWeight.bold),
                                        obscureText: false,
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
                                            borderSide: BorderSide(
                                                color: Colors.white,
                                                width: 1.0),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15.0)),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.white,
                                                width: 1.0),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15.0)),
                                          ),
                                          hintText:
                                              '${studentProvider.student.email}',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                      bottom: 20.0, left: 20.0, right: 20.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Text(
                                          'Time Zone',
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontFamily: 'WorkSans'),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: Colors.grey[200],
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15.0)),
                                        ),
                                        child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: DropdownButton(
                                              isExpanded: true,
                                              value: _selectedTimezone,
                                              items: _dropdownMenuItems,
                                              onChanged: onChangeDropdownItem,
                                            )),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )),
                        Container(
                          margin: EdgeInsets.only(left: 15, right: 15),
                          child: studentProvider.isUpdating
                              ? Center(child: CircularProgressIndicator())
                              : RaisedButton(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      side: BorderSide(color: Colors.white)),
                                  onPressed: () async {
                                    print("Save got click");
                                    setState(() {
                                      firstname.text.isEmpty
                                          ? firstname.text =
                                              "${studentProvider.student.firstName}"
                                          : firstname.text = firstname.text;
                                      lastname.text.isEmpty
                                          ? lastname.text =
                                              "${studentProvider.student.lastName}"
                                          : lastname.text = lastname.text;
                                      email.text.isEmpty
                                          ? email.text =
                                              "${studentProvider.student.email}"
                                          : email.text = email.text;
                                      _selectedTimezone.name.isEmpty
                                          ? studentTimezone =
                                              "${studentProvider.student.timezoneInfo}"
                                          : studentTimezone =
                                              _selectedTimezone.name;
                                      _selectedTimezone.timezone.isEmpty
                                          ? studentGMT =
                                              "${studentProvider.student.timezoneInfoGmt}"
                                          : studentGMT =
                                              _selectedTimezone.timezone;
                                    });
                                    studentProvider.setIsLoading(true);
                                    //make condition here
                                    if (isPhotoChange) {
                                      bool isUploaded = await studentProvider
                                          .upload(base64Image);
                                      if (isUploaded) {
                                        print("uploaded");
                                      }
                                    }
                                    //_updateStudent();
                                    bool response =
                                        await studentProvider.updateStudent(
                                            studentProvider
                                                .student.registrationId,
                                            firstname.text,
                                            lastname.text,
                                            email.text,
                                            studentTimezone,
                                            studentGMT);
                                    if (response) {
                                      final userState =
                                          Provider.of<UserProvider>(context,
                                              listen: false);
                                      await userState.loadParamsAsync;
                                      await userState.checkUser();
                                      await userState.checkLogin();
                                      showAlertDialog(context);
                                    } else {
                                      _showUpdateFailed(
                                          studentProvider.errorMessage);
                                    }
                                    //Navigator.pop(context);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Text('Save',
                                        style: TextStyle(
                                            color: Color(0xFF3061cc),
                                            fontSize: 18,
                                            fontFamily: 'WorkSans',
                                            fontWeight: FontWeight.bold)),
                                  )),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 30.0),
                            child: FlatButton(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(bottom: 30, top: 30),
                                child: Text(
                                  'Back',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: 'WorkSans',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                  textAlign: TextAlign.end,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ]),
                ),
                Center(
                  child: Text('Subscription'),
                )
              ]),
            )
          ],
        ),
      ),
    ));
  }
}