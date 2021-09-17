import 'package:flutter/material.dart';
import 'package:justlearn/business_logic/models/articles/article_model.dart';
import 'package:justlearn/ui/views/screens/articles/article_screen.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:justlearn/services/articles/articles_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ArticlesListScreen extends StatefulWidget {
  static const String id = "article_list_screen";
  @override
  _ArticlesScreenState createState() => _ArticlesScreenState();
}

class _ArticlesScreenState extends State<ArticlesListScreen> {
  ScrollController _controller = new ScrollController();
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) => _afterLayout(context));
    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        final articleState =
            Provider.of<ArticlesProvider>(context, listen: false);
        articleState.getArticleList(articleState.page);
      }
    });
  }

  _afterLayout(BuildContext context) async {
    final articleState = Provider.of<ArticlesProvider>(context, listen: false);
    articleState.getArticleList(articleState.page);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("Articles List Build");
    final articleData = Provider.of<ArticlesProvider>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: ListView(
          controller: _controller,
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.arrow_back),
                  tooltip: "Leave",
                ),
              ],
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                child: Text(
                  'Blog',
                  style: TextStyle(
                    color: Colors.black,
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'WorkSans',
                    fontSize: 45,
                  ),
                ),
              ),
            ),
            articleData.isFetching
                ? Center(child: CircularProgressIndicator())
                : Consumer<ArticlesProvider>(
                    builder: (context, list, child) => ListView.builder(
                      primary: false,
                      shrinkWrap: true,
                      itemCount: list.result.length + 1,
                      itemBuilder: (context, index) {
                        if (index == list.result.length) {
                          return _buildProgressIndicator();
                        } else {
                          Result articleRes = list.result[index];
                          return _articleList(articleRes);
                        }
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressIndicator() {
    final tutorState = Provider.of<ArticlesProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Opacity(
          opacity: tutorState.isFetching ? 1.0 : 0.0,
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  Widget _articleList(Result articleL) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 5.0,
      color: Colors.white,
      shadowColor: Colors.grey[400],
      margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
      child: InkWell(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '${articleL.headLine}',
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'WorkSans',
                  fontSize: 30,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Text(
              '${DateFormat.yMd().format(articleL.createDate.toLocal())}',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
            Container(
              margin: const EdgeInsets.all(15.0),
              child: CachedNetworkImage(
                imageUrl: '${articleL.imagePath}' + '${articleL.image}',
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    CircularProgressIndicator(value: downloadProgress.progress),
                errorWidget: (context, url, error) =>
                    Image.asset('assets/img/article.jpg'),
              ),
            )
          ],
        ),
        onTap: () async {
          // final articleState = Provider.of<ArticlesProvider>(context, listen: false);
          // await articleState.singleArticle(articleL.articleUrl);
          // print(articleL.articleUrl);
          // Navigator.pushNamed(context, ArticleScreen.id);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ArticleScreen(
                singleArticle: articleL,
              ),
            ),
          );
        },
      ),
    );
  }
}
