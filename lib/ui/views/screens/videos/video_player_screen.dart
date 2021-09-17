import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:justlearn/business_logic/models/auth/params_model.dart';
import 'package:justlearn/business_logic/models/utils/networking.dart';
import 'package:justlearn/business_logic/models/videoslist/videos_list_model.dart';
import 'package:justlearn/services/shared_preference.dart';
import 'package:justlearn/services/videos/videos_screen_provider.dart';
import 'package:provider/provider.dart';
import 'package:vimeoplayer/vimeoplayer.dart';
import 'package:http/http.dart' as http;

class VideoPlayerScreen extends StatefulWidget {
  static const String id = "video_player_screen";

  final VideoCourse videoP;

  const VideoPlayerScreen({Key key, this.videoP}) : super(key: key);
  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  VideoCourse videoP;
  @override
  void initState() {
    videoP = widget.videoP;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MediaQuery.of(context).orientation == Orientation.portrait
          ? AppBar(
              elevation: 0.0,
              title: Text(
                'Watch & Learn',
                style: TextStyle(color: Colors.black, fontFamily: 'WorkSans'),
              ),
              centerTitle: true,
              backgroundColor: Colors.transparent,
              iconTheme: IconThemeData(color: Colors.black),
              brightness: Brightness.light,
            )
          : PreferredSize(
              child: Container(
                color: Colors.transparent,
              ),
              preferredSize: Size(0.0, 0.0),
            ),
      body: Column(
        children: [
          Container(
            child: VimeoPlayer(
              id: '${videoP.courseVideoLink}',
              autoPlay: false,
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    '${videoP.title}',
                    style: TextStyle(
                      fontFamily: 'WorkSans',
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${videoP.registrationName}',
                        style: TextStyle(
                          color: Color(0xFF3061cc),
                        ),
                      ),
                      Text(
                        '🎓 ${videoP.learningScoreDecimal}',
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ],
                  ),
                ),
                Divider(
                  thickness: 2.0,
                  height: 5.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Category: ${videoP.category}',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Description: ${videoP.description}',
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Text(
                        'How will you rate video based on learning?',
                      ),
                      RatingBar.builder(
                        initialRating: 0,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: false,
                        itemCount: 5,
                        itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => Icon(
                          Icons.school,
                          color: Color(0xFF3061cc),
                        ),
                        onRatingUpdate: (rating) async {
                          ParamsResponse params = ParamsResponse.fromJson(
                            await SharedPref().read("params"),
                          );

                          var url = NetworkHelper.baseUrl +
                              "api/save-video-score-all";
                          final ratingResponse = await http.post(
                            url,
                            headers: {
                              'Content-Type': 'application/json; charset=UTF-8',
                            },
                            body: json.encode(
                              {
                                "VideoCourseId": "${videoP.videoCourseId}",
                                "LearningScoreAll":
                                    "${params.id}+${rating.toInt()}"
                              },
                            ),
                          );

                          if (ratingResponse.statusCode == 200) {
                            final ratingResult =
                                json.decode(ratingResponse.body);
                            if (ratingResult['success'] == true) {
                              Flushbar(
                                title: "Rating Sent",
                                message:
                                    "Thank you for rating our videos it will help to improve our lessons.",
                                duration: Duration(seconds: 2),
                              )..show(context);
                            }
                          }
                        },
                      ),
                    ],
                  ),
                ),
                Divider(
                  thickness: 2.0,
                  height: 5.0,
                ),
                SizedBox(
                  height: 5.0,
                ),
                ListView.separated(
                  separatorBuilder: (context, index) {
                    return Divider(
                      thickness: 1.0,
                    );
                  },
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: widget.videoP.videoCourses.length,
                  itemBuilder: (context, index) {
                    VideoCourse singleVid = widget.videoP.videoCourses[index];
                    return _videosList(singleVid);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _videosList(VideoCourse vid) {
    return InkWell(
      onTap: () {
        print("${vid.title}");
        final vidPlaylist = Provider.of<VideosProvider>(context, listen: false);
        VideoCourse fromPlaylist = vidPlaylist.filteredVideos.firstWhere((element) => element.videoCourseId == vid.videoCourseId);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => VideoPlayerScreen(
              videoP: fromPlaylist,
            ),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.only(right: 2.0),
              width: MediaQuery.of(context).size.width * .5,
              child: vid.videoThumbnail != ""
                  ? CachedNetworkImage(
                      imageUrl: 'http://${vid.videoThumbnail}',
                      fit: BoxFit.fill,
                    )
                  : CachedNetworkImage(
                      imageUrl: 'https://www.cdnjustlearn.com/document/file/118202032/vimeodefault_472x266.jpg',
                      fit: BoxFit.fill,
                    ),
            ),
            Expanded(
              child: Text(
                '${vid.title}',
                style: TextStyle(fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
      ),
    );
  }
}
