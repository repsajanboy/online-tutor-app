import 'dart:io';

import 'package:flutter/material.dart';
import 'package:justlearn/business_logic/models/auth/params_model.dart';
import 'package:justlearn/business_logic/models/country_list_model.dart';
import 'package:justlearn/business_logic/models/timezone_list_model.dart';
import 'package:justlearn/business_logic/models/utils/networking.dart';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:justlearn/services/timezone_provider.dart';
import 'package:justlearn/services/user_profile/user_edit_profile_provider.dart';
import 'package:justlearn/services/user_profile/user_profile_provider.dart';
import 'package:provider/provider.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class EditTeacher extends StatefulWidget {
  static const String id = 'edit_teacher_profile';
  final ParamsResponse params;
  final Countries countries;
  final Timezone timezones;

  const EditTeacher({Key key, this.params, this.countries, this.timezones})
      : super(key: key);
  @override
  _EditTeacherState createState() => _EditTeacherState();
}

class _EditTeacherState extends State<EditTeacher> {
  final firstname = TextEditingController();
  final lastname = TextEditingController();
  final email = TextEditingController();
  final phonenumber = TextEditingController();
  final age = TextEditingController();
  final gender = TextEditingController();
  final address = TextEditingController();
  final city = TextEditingController();
  final timezone = TextEditingController();
  String teacherTimezone;
  String teacherGMT;
  String teacherLivesIncountry;
  String teacherFromCountry;

  //Timezone
  List<DropdownMenuItem<Timezone>> _dropdownMenuItems;
  Timezone _selectedTimezone;

  //LivesInCountry
  List<Countries> _livesInCountry = countriesl;
  List<DropdownMenuItem<Countries>> _dropdownLivesInCountry;
  Countries _selectedlivesInCountry;

  //FromCountry
  List<Countries> _fromCountry = countriesl;
  List<DropdownMenuItem<Countries>> _dropdownFromCountry;
  Countries _selectedFromCountry;

  //Upload Photo
  final picker = ImagePicker();
  File file;
  String status = '';
  String base64Image;
  File tmpFile;
  bool isPhotoChange = false;

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

  List<DropdownMenuItem<Countries>> buildDropdownLivesInCountry(
      List liveInCountries) {
    List<DropdownMenuItem<Countries>> items = List();
    for (Countries livesInCountry in liveInCountries) {
      items.add(
        DropdownMenuItem(
          value: livesInCountry,
          child: Text(livesInCountry.name),
        ),
      );
    }
    return items;
  }

  onChangeDropdownLivesInCountry(Countries selectedlivesInCountry) {
    setState(() {
      _selectedlivesInCountry = selectedlivesInCountry;
      print(_selectedlivesInCountry.name);
    });
  }

  List<DropdownMenuItem<Countries>> buildDropdownFromCountry(
      List fromCountries) {
    List<DropdownMenuItem<Countries>> items = List();
    for (Countries fromCountry in fromCountries) {
      items.add(
        DropdownMenuItem(
          value: fromCountry,
          child: Text(fromCountry.name),
        ),
      );
    }
    return items;
  }

  onChangeDropdownFromCountry(Countries selectedfromCountry) {
    setState(() {
      _selectedFromCountry = selectedfromCountry;
      print(_selectedFromCountry);
    });
  }

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
    final teacherProvider =
        Provider.of<EditProfileProvider>(context, listen: false);
    if (file != null) {
      return Image.file(file, fit: BoxFit.fill);
    } else {
      return "${teacherProvider.teacher.profileImage}".isEmpty
          ? Image.network(
              'https://www.cdnjustlearn.com/image/intet-billede.jpg',
              fit: BoxFit.cover,
            )
          : Image.network(
              '${NetworkHelper.imgUrl}${teacherProvider.teacher.profileImage}',
              fit: BoxFit.cover);
    }
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

  void main() {
  tz.initializeTimeZones();
  var locations = tz.timeZoneDatabase.locations;
  print(locations.length); // => 429
  print(locations.keys.first); // => "Africa/Abidjan"
  print(locations.keys.last); // => "US/Pacific"
}


  @override
  void initState() {
    final teacherProvider =
        Provider.of<EditProfileProvider>(context, listen: false);
    final tzoneProvider = Provider.of<TimezoneProvider>(context, listen: false);
    _dropdownMenuItems = buildDropdownMenuItems(tzoneProvider.timezoneList);
    int index0 = _dropdownMenuItems.indexWhere((timezone) => timezone.value.name
        .contains('${teacherProvider.teacher.timezoneInfo}'));
    _selectedTimezone = _dropdownMenuItems[index0].value;

    _dropdownLivesInCountry = buildDropdownLivesInCountry(_livesInCountry);
    int index1 = _dropdownLivesInCountry.indexWhere((country) => country
        .value.isoCode
        .contains('${teacherProvider.teacher.countryCode}'));
    _selectedlivesInCountry = _dropdownLivesInCountry[index1].value;

    _dropdownFromCountry = buildDropdownFromCountry(_fromCountry);
    int index2 = _dropdownFromCountry.indexWhere((country) => country
        .value.isoCode
        .contains('${teacherProvider.teacher.countryCodeFrom}'));
    _selectedFromCountry = _dropdownFromCountry[index2].value;
    print(widget.params.id);
    main();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<EditProfileProvider>(
          builder: (context, teacherProvider, child) => SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
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
                                onPressed: () {
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
                                '${teacherProvider.teacher.firstName}',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "WorkSans"),
                              ),
                              Text(
                                '${teacherProvider.teacher.lastName}',
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
                  Container(
                      margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      color: Color(0xFF3061cc),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(Icons.settings, color: Colors.white),
                          Text(
                            'General',
                            style: TextStyle(
                              color: Colors.white60,
                            ),
                          ),
                        ],
                      )),
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
                            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    'First Name',
                                    style: TextStyle(
                                        fontSize: 15, fontFamily: 'WorkSans'),
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
                                          color: Colors.white, width: 1.0),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15.0)),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white, width: 1.0),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15.0)),
                                    ),
                                    hintText:
                                        '${teacherProvider.teacher.firstName}',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    'Last Name',
                                    style: TextStyle(
                                        fontSize: 15, fontFamily: 'WorkSans'),
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
                                          color: Colors.white, width: 1.0),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15.0)),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white, width: 1.0),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15.0)),
                                    ),
                                    hintText:
                                        '${teacherProvider.teacher.lastName}',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    'Email',
                                    style: TextStyle(
                                        fontSize: 15, fontFamily: 'WorkSans'),
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
                                          color: Colors.white, width: 1.0),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15.0)),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white, width: 1.0),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15.0)),
                                    ),
                                    hintText:
                                        '${teacherProvider.teacher.email}',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    'Phone Number',
                                    style: TextStyle(
                                        fontSize: 15, fontFamily: 'WorkSans'),
                                  ),
                                ),
                                TextField(
                                  controller: phonenumber,
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
                                          color: Colors.white, width: 1.0),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15.0)),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white, width: 1.0),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15.0)),
                                    ),
                                    hintText:
                                        '${teacherProvider.teacher.phone}',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 10.0, left: 20.0, right: 20.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Text(
                                          'Age',
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontFamily: 'WorkSans'),
                                        ),
                                      ),
                                      TextField(
                                        controller: age,
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
                                              '${teacherProvider.teacher.age}',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 10.0, left: 20.0, right: 20.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Text(
                                          'Gender',
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontFamily: 'WorkSans'),
                                        ),
                                      ),
                                      TextField(
                                        controller: gender,
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
                                              '${teacherProvider.teacher.gender}',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                bottom: 20.0, left: 20.0, right: 20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    'Lives in',
                                    style: TextStyle(
                                        fontSize: 15, fontFamily: 'WorkSans'),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15.0)),
                                  ),
                                  child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: DropdownButton(
                                        isExpanded: true,
                                        value: _selectedlivesInCountry,
                                        items: _dropdownLivesInCountry,
                                        onChanged:
                                            onChangeDropdownLivesInCountry,
                                      )),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                bottom: 20.0, left: 20.0, right: 20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    'From',
                                    style: TextStyle(
                                        fontSize: 15, fontFamily: 'WorkSans'),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15.0)),
                                  ),
                                  child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: DropdownButton(
                                        isExpanded: true,
                                        value: _selectedFromCountry,
                                        items: _dropdownFromCountry,
                                        onChanged: onChangeDropdownFromCountry,
                                      )),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                bottom: 20.0, left: 20.0, right: 20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    'Address',
                                    style: TextStyle(
                                        fontSize: 15, fontFamily: 'WorkSans'),
                                  ),
                                ),
                                TextField(
                                  controller: address,
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
                                          color: Colors.white, width: 1.0),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15.0)),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white, width: 1.0),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15.0)),
                                    ),
                                    hintText:
                                        '${teacherProvider.teacher.address}',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                bottom: 10.0, left: 20.0, right: 20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    'City',
                                    style: TextStyle(
                                        fontSize: 15, fontFamily: 'WorkSans'),
                                  ),
                                ),
                                TextField(
                                  controller: city,
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
                                          color: Colors.white, width: 1.0),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15.0)),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white, width: 1.0),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15.0)),
                                    ),
                                    hintText: '${teacherProvider.teacher.city}',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                bottom: 20.0, left: 20.0, right: 20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    'Time Zone',
                                    style: TextStyle(
                                        fontSize: 15, fontFamily: 'WorkSans'),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15.0)),
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
                    child: teacherProvider.isUpdating
                        ? Center(child: CircularProgressIndicator())
                        : RaisedButton(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              side: BorderSide(color: Colors.white),
                            ),
                            onPressed: () async {
                              setState(() {
                                firstname.text.isEmpty
                                    ? firstname.text =
                                        "${teacherProvider.teacher.firstName}"
                                    : firstname.text = firstname.text;
                                lastname.text.isEmpty
                                    ? lastname.text =
                                        "${teacherProvider.teacher.lastName}"
                                    : lastname.text = lastname.text;
                                email.text.isEmpty
                                    ? email.text =
                                        "${teacherProvider.teacher.email}"
                                    : email.text = email.text;
                                phonenumber.text.isEmpty
                                    ? phonenumber.text =
                                        "${teacherProvider.teacher.phone}"
                                    : phonenumber.text = phonenumber.text;
                                age.text.isEmpty
                                    ? age.text =
                                        "${teacherProvider.teacher.age}"
                                    : age.text = age.text;
                                gender.text.isEmpty
                                    ? gender.text =
                                        "${teacherProvider.teacher.gender}"
                                    : gender.text = gender.text;
                                address.text.isEmpty
                                    ? address.text =
                                        "${teacherProvider.teacher.address}"
                                    : address.text = address.text;
                                city.text.isEmpty
                                    ? city.text =
                                        "${teacherProvider.teacher.city}"
                                    : city.text = city.text;
                                _selectedlivesInCountry.name.isEmpty
                                    ? teacherLivesIncountry =
                                        "${teacherProvider.teacher.countryCode.toLowerCase()}"
                                    : teacherLivesIncountry =
                                        _selectedlivesInCountry.isoCode
                                            .toLowerCase();

                                _selectedFromCountry.name.isEmpty
                                    ? teacherFromCountry =
                                        "${teacherProvider.teacher.countryCodeFrom.toLowerCase()}"
                                    : teacherFromCountry = _selectedFromCountry
                                        .isoCode
                                        .toLowerCase();
                                _selectedTimezone.name.isEmpty
                                    ? teacherTimezone =
                                        "${teacherProvider.teacher.timezoneInfo}"
                                    : teacherTimezone = _selectedTimezone.name;
                                _selectedTimezone.timezone.isEmpty
                                    ? teacherGMT =
                                        "${teacherProvider.teacher.timezoneInfoGmt}"
                                    : teacherGMT = _selectedTimezone.timezone;
                              });
                              teacherProvider.setIsLoading(true);
                              if (isPhotoChange) {
                                bool response =
                                    await teacherProvider.upload(base64Image);
                                if (response) {
                                  print("uploaded");
                                }
                              }
                              //_updateStudent();
                              bool response =
                                  await teacherProvider.updateTeacher(
                                      teacherProvider.teacher.registrationId,
                                      firstname.text,
                                      lastname.text,
                                      email.text,
                                      phonenumber.text,
                                      age.text,
                                      gender.text,
                                      address.text,
                                      city.text,
                                      teacherLivesIncountry,
                                      teacherFromCountry,
                                      teacherTimezone,
                                      teacherGMT);
                              if (response) {
                                final userState = Provider.of<UserProvider>(
                                    context,
                                    listen: false);
                                await userState.loadParamsAsync;
                                await userState.checkUser();
                                await userState.checkLogin();
                              }
                              showAlertDialog(context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Text(
                                'Save',
                                style: TextStyle(
                                    color: Color(0xFF3061cc),
                                    fontSize: 18,
                                    fontFamily: 'WorkSans',
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                  ),
                  Container(
                    child: Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 30.0),
                        child: FlatButton(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onPressed: () {
                            print('Sign out fot clicked');
                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 30, top: 30),
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
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
