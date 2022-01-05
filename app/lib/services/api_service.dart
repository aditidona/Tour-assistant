import 'dart:convert';
import '../model/article_model.dart';
import 'package:http/http.dart';

class ApiService {
  Uri endpointUrl = Uri.parse(
      "https://newsapi.org/v2/top-headlines?country=in&category=health&apiKey=c5de6fd554ce498f97482c28bb883633");

  Future<List<Article>> getArticle() async {
    Response res = await get(endpointUrl);
    if (res.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(res.body);
      List<dynamic> body = json['articles'];
      List<Article> articles =
          body.map((dynamic item) => Article.fromJson(item)).toList();

      return articles;
    } else {
      throw ("Can't get the Articles");
    }
  }
}
