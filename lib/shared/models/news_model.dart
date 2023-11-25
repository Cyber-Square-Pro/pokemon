class News {
  String id;
  double newsId;
  String author;
  String title;
  String content;
  DateTime date;
  int v; // assuming __v is an integer

  News({
    required this.id,
    required this.newsId,
    required this.author,
    required this.title,
    required this.content,
    required this.date,
    required this.v,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      id: json['_id'],
      newsId: json['newsId'],
      author: json['author'],
      title: json['title'],
      content: json['content'],
      date: DateTime.parse(json['date']),
      v: json['__v'],
    );
  }
}
