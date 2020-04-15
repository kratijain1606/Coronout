import 'dart:convert';
import 'package:gocorona/Models/newsmodel.dart';
import 'package:http/http.dart';
import 'package:gocorona/consts.dart';

final String link = "http://newsapi.org/v2/top-headlines?country=in&category=health&apiKey="+apiKey;

class News{
  Future <List<ArtContent>> getNews() async {
    List<ArtContent> articles = [];
    try{
      Response response = await get(link);
      List data = jsonDecode(jsonEncode(jsonDecode(response.body)["articles"]));
      for(int i=0;i<data.length;i++){
        ArtContent _art = new ArtContent(
          title: data[i]["title"],
          content: data[i]["content"],
          newsimage: data[i]["urlToImage"],
          newsUrl: data[i]["url"]
        );
        articles.add(_art);
      }
    } catch(e) {
      print(e);
    }
    return articles;
  }
}