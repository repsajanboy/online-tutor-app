import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/html_parser.dart';
import 'package:flutter_html/style.dart';
import 'package:intl/intl.dart';
import 'package:justlearn/business_logic/models/articles/article_model.dart';
import 'package:provider/provider.dart';
import 'package:justlearn/services/articles/articles_provider.dart';
import 'package:justlearn/business_logic/models/utils/networking.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shape_of_view/shape_of_view.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ArticleScreen extends StatefulWidget {
  static const String id = "article";
  final Result singleArticle;

  const ArticleScreen({Key key, this.singleArticle}) : super(key: key);

  @override
  _ArticleState createState() => _ArticleState();
}

class _ArticleState extends State<ArticleScreen> {
  //ScrollController _controller = new ScrollController();
  var baseUrl = NetworkHelper.baseUrl.toString();

  _shareInFacebook() async {
    final RenderBox box = context.findRenderObject();
    await Share.share(
        '$baseUrl' + '${widget.singleArticle.articleUrl}',
        subject: '${widget.singleArticle.headLine}',
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }

  @override
  void initState() {
    super.initState();

    Provider.of<ArticlesProvider>(context, listen: false).getAllArticles();
       
  }


  @override
  Widget build(BuildContext context) {
    final htmlData = """
    ${widget.singleArticle.contentText}
    """;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Consumer<ArticlesProvider>(
            builder: (context, artiProvider, child) => Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.arrow_back),
                      tooltip: "Leave",
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Text(
                        'back',
                        style: TextStyle(fontSize: 18.0),
                      ),
                    )
                  ],
                ),
                ShapeOfView(
                  clipBehavior: Clip.hardEdge,
                  elevation: 4,
                  height: 200,
                  shape: DiagonalShape(
                      position: DiagonalPosition.Bottom,
                      direction: DiagonalDirection.Left,
                      angle: DiagonalAngle.deg(angle: 3)),
                  child: CachedNetworkImage(
                  imageUrl: '${widget.singleArticle.imagePath}' +
                        '${widget.singleArticle.image}',
                  progressIndicatorBuilder: (context, url, downloadProgress) => 
                          CircularProgressIndicator(value: downloadProgress.progress),
                  errorWidget: (context, url, error) => Image.asset('assets/img/article.jpg'),
              ), 
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 5.0, right: 10),
                  child:
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    RaisedButton(
                        color: Color(0xFF3061cc),
                        child: Text(
                          'Share',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: 'WorkSans',
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(5.0)),
                        onPressed: () {
                          _shareInFacebook();
                        }),
                  ]),
                ),
                Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    child: Text(
                      '${widget.singleArticle.headLine}',
                      style: TextStyle(
                        fontSize: 32,
                        color: Color(0xFF3061cc),
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10, top: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 10),
                            child: Image.asset(
                              'assets/img/logo/icon.png',
                              width: 32,
                              height: 32,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Justlearn',
                                style: TextStyle(
                                  color: Colors.grey[800],
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                '${DateFormat.yMd().format(widget.singleArticle.createDate.toLocal())}',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 14,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      Text(
                        '${widget.singleArticle.readByTime}',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  child: Html(
                    data: htmlData,
                    //Optional parameters:
                    style: {
                      "html": Style(
                        backgroundColor: Colors.white,
                        //              color: Colors.white,
                      ),
                      //            "h1": Style(
                      //              textAlign: TextAlign.center,
                      //            ),
                      "p": Style(
                        color: Colors.black87,
                        fontSize: FontSize.xLarge,
                      ),
                      "h3": Style(
                          color: Colors.black, fontSize: FontSize.xxLarge),
                      "a": Style(
                        fontSize: FontSize.xLarge,
                        color: Colors.black87,
                      ),
                      "h2": Style(
                        color: Colors.black,
                        fontSize: FontSize.xxLarge,
                      ),
                    },
                    customRender: {
                      "flutter":
                          (RenderContext context, Widget child, attributes, _) {
                        return FlutterLogo(
                          style: (attributes['horizontal'] != null)
                              ? FlutterLogoStyle.horizontal
                              : FlutterLogoStyle.markOnly,
                          textColor: context.style.color,
                          size: context.style.fontSize.size * 5,
                        );
                      },
                    },
                    onLinkTap: (url) async {

                      //Tangalin mo sa link yung ../../ tapos send mo sa singleArticle(url);
                      //itry mo munang idebug to.
                      var link = url.toString();
                      var removedExcessChar = link.replaceAll('../../blog', '');

                      final subs = link.substring(0, 6);

                      // final list = artiProvider.allArticles;
                      // final l = list.where(
                      //     (element) => element.articleUrl.startsWith('/'));
                      // print(list.contains(removedExcessChar ==
                      //     '${artiProvider.singleArti.articleUrl}'));

                      if (subs == '../../') {
                         final aticleState =
                            Provider.of<ArticlesProvider>(context, listen: false);
                        Result articleS = aticleState.allArticles
                            .where((element) => element.articleUrl == removedExcessChar)
                            .first;
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ArticleScreen(
                              singleArticle: articleS,
                            ),
                          ),
                        );
                        print('subs');
                      } else {
                        launch('$url');
                      }

                      print(removedExcessChar);

                      print("$url");
                    },
                    onImageTap: (src) {
                      print(src);
                    },
                    onImageError: (exception, stackTrace) {
                      print(exception);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}