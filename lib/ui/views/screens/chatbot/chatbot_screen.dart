import 'package:flutter_dialogflow/dialogflow_v2.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:justlearn/services/user_profile/user_profile_provider.dart';
import 'package:provider/provider.dart';
import 'package:justlearn/business_logic/models/utils/networking.dart';
import 'package:justlearn/business_logic/models/users/users_student_model.dart';
import 'package:justlearn/business_logic/models/users/users_model.dart';

class ChatbotScreen extends StatefulWidget {
  static const String id = "chatbot_screen";

  const ChatbotScreen() : super();
  @override
  _ChatbotScreenState createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  int generatenewRandom(currentRandom) {
    int num = _random.nextInt(12);
    _counter = num;
    return (num == currentRandom) ? generatenewRandom(currentRandom) : num;
  }

  void response(query, counter) async {
    AuthGoogle authGoogle =
        await AuthGoogle(fileJson: "android/app/Justlearn.chatbot.json")
            .build();
    Dialogflow dialogflow =
        Dialogflow(authGoogle: authGoogle, language: Language.english);
    AIResponse aiResponse = await dialogflow.detectIntent(query);
    if (aiResponse.queryResult.action == "get.word") {
      query = aiResponse.getMessage();
      String apiUrl = "https://api.dictionaryapi.dev/api/v2/entries/en/$query";
      var getDef = await http.get(apiUrl);
      if (getDef.statusCode == 404) {
        query = "reprompt: question";
        response(query, counter);
      } else if (getDef.statusCode == 429) {
        query = "api limited code 429";
        response(query, counter);
      } else {
        var wordDef = convert.jsonDecode(getDef.body);
        var word = wordDef[0]["word"];
        var define = wordDef[0]["meanings"][0]["definitions"][0]["definition"];
        query = "word definition: $word - $define";
        response(query, counter);
      }
    } else {
      setState(() {
        messages.insert(0, {
          "data": 0,
          "message":
              aiResponse.getListMessage()[0]["text"]["text"][0].toString()
        });
      });
      if (aiResponse.queryResult.action == "input.unknown" ||
          aiResponse.queryResult.action == "smalltalk.confirmation.yes" ||
          aiResponse.queryResult.action == "smalltalk.confirmation.no") {
        counter = generatenewRandom(counter);
        query = "unknown $counter";
        response(query, counter);
      }
    }
  }

  ScrollController _controller = new ScrollController();
  final chatM = TextEditingController();
  final _random = new Random();
  String _name = "";
  int _counter = Random().nextInt(12);
  List<Map> messages = List();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => _afterLayout(context));
    super.initState();
  }

  _afterLayout(BuildContext context) async {
    final userState = Provider.of<UserProvider>(context, listen: false);
    await userState.loadParamsAsync;
    var url = NetworkHelper.baseUrl +
        "api/user-profile?userregistrationid=${userState.loadParams.id}&usertype=${userState.loadParams.type}";
    final responseText = await http.get(url);
    if (responseText.statusCode == 200) {
      if (userState.loadParams.type == "T") {
        final result =
            UsersTeacherProfile.fromJson(convert.jsonDecode(responseText.body));
        _name = result.info.profile.firstName;
      } else {
        final result =
            UsersStudentProfile.fromJson(convert.jsonDecode(responseText.body));
        _name = result.student.firstName;
      }
    }
    response("name $_name", _counter);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('chatbot build');
    //final dashState = Provider.of<DashDetailsProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://www.cdnjustlearn.com/image/justlearn-46x46.png'),
              maxRadius: 20,
            ),
            SizedBox(
              width: 8.0,
            ),
            Text('Justlearn'),
          ],
        ),
        automaticallyImplyLeading: false,
        brightness: Brightness.light,
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                reverse: true,
                addAutomaticKeepAlives: true,
                primary: false,
                shrinkWrap: true,
                itemCount: messages.length,
                itemBuilder: (context, index) => messages[index]["data"] == 0
                    ? Card(
                        elevation: 0,
                        color: Colors.transparent,
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(width: 8.0),
                              Container(
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            color: Colors.black54, width: 1.0),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0)),
                                      ),
                                      padding: EdgeInsets.all(10.0),
                                      margin: EdgeInsets.only(bottom: 5.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            messages[index]["message"]
                                                .toString(),
                                            style: TextStyle(fontSize: 16.0),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    : Card(
                        elevation: 0,
                        color: Colors.transparent,
                        child: Container(
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                margin: EdgeInsets.only(bottom: 5.0),
                                padding: EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      messages[index]["message"].toString(),
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16.0),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
              ),
            ),
            Divider(height: 5.0, color: Colors.black54),
            Container(
              height: MediaQuery.of(context).size.height * .15,
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                children: [
                  // Icon(
                  //   Icons.attach_file_rounded,
                  //   color: Color(0xFF3061cc),
                  //   size: 32.0,
                  // ),
                  SizedBox(width: 15.0),
                  Expanded(
                    child: TextField(
                      controller: chatM,
                      autofocus: true,
                      keyboardType: TextInputType.text,
                      maxLines: null,
                      decoration: InputDecoration(
                        hintText: 'Message',
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 30.0),
                        border: OutlineInputBorder(),
                      ),
                      onTap: () {
                        _controller
                            .jumpTo(_controller.position.maxScrollExtent);
                      },
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  FlatButton(
                    height: 45.0,
                    color: Color(0xFF3061cc),
                    textColor: Colors.white,
                    child: Text(
                      'Send',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    onPressed: () async {
                      setState(() {
                        messages.insert(0, {"data": 1, "message": chatM.text});
                      });
                      response(chatM.text, _counter);
                      chatM.clear();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
