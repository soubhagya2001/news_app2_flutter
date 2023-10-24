import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:news/models/news_channels_headlines_models.dart';
class NewsRepository{

  Future<NewsChannelsHeadlinesModels> fetchNewsChannelHeadlines() async{
    String url = "https://newsapi.org/v2/top-headlines?country=us&apiKey=beca375642134c3d90c5b53860b32a92";

    final response = await http.get(Uri.parse(url));
    if(kDebugMode){
      print(response);
    }

    if(response.statusCode == 200){
      final body = jsonDecode(response.body);
        return NewsChannelsHeadlinesModels.fromJson(body);
    }

    throw Exception("error");
  }
}