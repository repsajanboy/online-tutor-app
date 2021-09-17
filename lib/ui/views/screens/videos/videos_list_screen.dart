import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:justlearn/business_logic/models/videoslist/videos_list_model.dart';
import 'package:justlearn/services/videos/videos_screen_provider.dart';
import 'package:justlearn/ui/views/screens/videos/video_player_screen.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

class VideosListScreen extends StatefulWidget {
  static const String id = "videos_list_screen";
  @override
  _VideosListScreenState createState() => _VideosListScreenState();
}

class _VideosListScreenState extends State<VideosListScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  void initState() {
    final videosP = Provider.of<VideosProvider>(context, listen: false);
    videosP.getAllVideos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2.8;
    final double itemWidth = size.width / 2;
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: Drawer(
        elevation: 10.0,
        child: SafeArea(
          child: Consumer<VideosProvider>(
            builder: (context, videosP, child) => Container(
              padding: EdgeInsets.only(
                top: 10.0,
                left: 5.0,
                right: 5.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Categories:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      children: [
                        Wrap(
                          spacing: 10.0,
                          runSpacing: 5.0,
                          children: List<Widget>.generate(
                            videosP.approvedCategories.length,
                            (int index) {
                              return ActionChip(
                                elevation: 6.0,
                                padding: EdgeInsets.all(2.0),
                                label: Text(
                                  '${videosP.approvedCategories[index]}',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                onPressed: () async {
                                  print(videosP.approvedCategories[index]);
                                  await videosP.filterVideo(
                                      videosP.approvedCategories[index]);
                                  Navigator.of(context).pop();
                                },
                                backgroundColor: Color(0xFF3061cc),
                                shape: StadiumBorder(
                                  side: BorderSide(
                                    width: 1,
                                    color: Colors.blueAccent,
                                  ),
                                ),
                              );
                            },
                          ),
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
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 10.0,
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 10.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Just Share Educational Videos with Friends',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontFamily: 'WorkSans',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () =>
                          _scaffoldKey.currentState.openEndDrawer(),
                      icon: Icon(
                        Icons.filter_list,
                        color: Color(0xFF3061cc),
                        size: 30.0,
                      ),
                    )
                  ],
                ),
              ),
              Divider(
                height: 10.0,
                thickness: 3.0,
              ),
              Consumer<VideosProvider>(
                builder: (context, videosP, child) => videosP.isLoading
                    ? Container(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : Expanded(
                        child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 2.0,
                            mainAxisSpacing: 4.0,
                            childAspectRatio: (itemWidth / itemHeight),
                          ),
                          itemCount: videosP.filteredVideos.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            VideoCourse singleVid =
                                videosP.filteredVideos[index];

                            return _videosList(singleVid);
                          },
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _videosList(VideoCourse vids) {
    return Card(
      margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
      elevation: 10.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 100.0,
            width: double.infinity,
            child: vids.videoThumbnail != ""
                ? CachedNetworkImage(
                    placeholder: (context, url) => CircularProgressIndicator(),
                    imageUrl: 'http://${vids.videoThumbnail}',
                    fit: BoxFit.fill)
                : CachedNetworkImage(
                    placeholder: (context, url) => CircularProgressIndicator(),
                    imageUrl:
                        'https://www.cdnjustlearn.com/document/file/118202032/vimeodefault_472x266.jpg',
                    fit: BoxFit.fill),
          ),
          Divider(
            height: 3.0,
            thickness: 1.0,
            color: Colors.black54,
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              '${vids.title}',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.black,
                //fontSize: 16.0,
                fontFamily: 'WorkSans',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Text(
                  '${vids.category}',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 12.0,
                    fontFamily: 'WorkSans',
                  ),
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Text(
                      '🎓',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Text(
                      '${vids.learningScoreDecimal}',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 12.0,
                        fontFamily: 'WorkSans',
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: FlatButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VideoPlayerScreen(
                      videoP: vids,
                    ),
                  ),
                );
              },
              minWidth: double.infinity,
              textColor: Color(0xFF3061cc),
              child: Text('Just Watch'),
              shape: RoundedRectangleBorder(
                side: BorderSide(
                    color: Color(0xFF3061cc),
                    width: 1,
                    style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
