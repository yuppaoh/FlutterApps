class NewsArticle {
  final String? title;
  final String? author;
  final String? description;
  final String? urlToImage;
  final String? url;
  final String? publishedAt;
  final String? content;

  NewsArticle({
      this.title,
      this.author,
      this.description,
      this.urlToImage,
      this.url,
      this.publishedAt,
      this.content
  });

  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    return NewsArticle(
      title: json["title"],
      author: json["author"],
      description: json["description"],
      url: json["url"],
      urlToImage: json["urlToImage"],
      publishedAt: json["publishedAt"],
      content: json["content"],
    );
  }
}