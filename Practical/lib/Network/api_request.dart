import 'package:dio/dio.dart' ;
import 'package:practical/Models/article.dart';
import 'package:practical/Models/source.dart';
import 'package:retrofit/http.dart';
part 'api_request.g.dart';


@RestApi(baseUrl : "https://www.newsapi.org/")
abstract class ApiRequest{
  factory ApiRequest(Dio dio,{String? baseurl, String?sourceName,  }){
    dio.interceptors
        .add(LogInterceptor(requestBody: false,responseBody: true,responseHeader: true));
    dio.options = BaseOptions(
        receiveTimeout: 30000,
        connectTimeout: 30000,
      queryParameters:{
        'apikey' : "fce5ba7b4bb142d0b8e4316713b1d4e8",
        'q': sourceName??"",
        "pageSize":"10"
      }
    );
    return _ApiRequest(dio, baseUrl: baseurl);
  }
  @GET("/v2/top-headlines/sources")
  Future<SourceModel> getSources();

  @GET("/everything")
  Future<ArticleModel> getArticlesOfSource();
}