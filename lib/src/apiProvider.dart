import 'dart:convert';

import 'package:anappnewsportal/models/otherNewsModels.dart';
import 'package:anappnewsportal/models/topNewsModels.dart';
import 'package:anappnewsportal/src/appStrings.dart';
import 'package:http/http.dart' as http;
abstract class ArticlesProvider{
  Future<List<Articles>>getArticles();
}
class ArticlesImplementation implements ArticlesProvider{
  @override
  Future<List<Articles>> getArticles() async {

    var response = await http.get(AppStrings.articleSportsUS);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      List<Articles> articles = News.fromJson(data).articles;
      return articles;
    } else {
      throw Exception();
    }

  }
}

abstract class ArticlesTechProvider{
  Future<List<ArticlesTech>>getArticles();
}
class ArticlesTechImplementation implements ArticlesTechProvider{
  @override
  Future<List<ArticlesTech>> getArticles() async {

    var response = await http.get(AppStrings.articleTechUS);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      List<ArticlesTech> articles = NewsTech.fromJson(data).articles;
      return articles;
    } else {
      throw Exception();
    }

  }

}



