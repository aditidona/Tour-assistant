import 'package:flutter/gestures.dart';
import '../model/article_model.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticlePage extends StatelessWidget {
  final Article article;

  ArticlePage({required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(article.title as String),
        backgroundColor: Colors.blueGrey[300],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200.0,
              width: double.infinity,
              decoration: BoxDecoration(
                //let's add the height
                image: DecorationImage(
                    image: NetworkImage(article.urlToImage as String),
                    fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            Container(
              padding: EdgeInsets.all(6.0),
              decoration: BoxDecoration(
                color: Colors.blueGrey,
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Text(
                article.source.name as String,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            Text(
              article.description as String,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              "For More Information Clicke below Link",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
            RichText(
              text: TextSpan(
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.blue[300],
                  ),
                  text: "${article.url}",
                  recognizer: TapGestureRecognizer()
                    ..onTap = () async {
                      var url = article.url;
                      if (await canLaunch(url.toString())) {
                        await launch(url.toString(),
                            forceWebView: true, enableJavaScript: true);
                      } else {
                        throw 'Could not launch $url';
                      }
                    }),
            ),
          ],
        ),
      ),
    );
  }
}
