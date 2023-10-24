import 'package:news/models/news_channels_headlines_models.dart';
import 'package:news/repository/news_repository.dart';

class NewsViewModel{
  final _rep = NewsRepository();

  Future<NewsChannelsHeadlinesModels> fetchNewsChannelHeadlinesApi() async{
    final response = await _rep.fetchNewsChannelHeadlines();
    return response;
  }
}