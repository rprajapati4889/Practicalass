class ArticleModel {
  late final String status;
  late final int totalResults;
  late final List<Articles> articles;

  ArticleModel({
    required this.status,
    required this.totalResults,
    required this.articles,
  });

  ArticleModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    totalResults = json['totalResults'];
    articles =
        List.from(json['articles']).map((e) => Articles.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['totalResults'] = totalResults;
    _data['articles'] = articles.map((e) => e.toJson()).toList();
    return _data;
  }

  ArticleModel.withError(String errorValue) {
    status = errorValue;
    totalResults = 0;
    articles = [];
  }
}

class Articles {
  late final Source source;
  late final String? author;
  late final String? title;
  late final String description;
  late final String url;
  late final String? urlToImage;
  late final String publishedAt;
  late final String content;

  Articles({
    required this.source,
    this.author,
    this.title,
    required this.description,
    required this.url,
    this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  Articles.fromJson(Map<String, dynamic> json) {
    source = Source.fromJson(json['source']);
    author = json['author'];
    title = json['title'];
    description = json['description'];
    url = json['url'];
    urlToImage = json['url'];
    publishedAt = json['urlToImage'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['source'] = source.toJson();
    _data['author'] = author;
    _data['title'] = title;
    _data['description'] = description;
    _data['url'] = url;
    _data['urlToImage'] = urlToImage;
    _data['publishedAt'] = publishedAt;
    _data['content'] = content;
    return _data;
  }
}

class Source {
  late final String? id;
  late final String name;

  Source({
    this.id,
    required this.name,
  });

  Source.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    return _data;
  }
}

