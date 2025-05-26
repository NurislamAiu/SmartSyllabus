class NewsItem {
  final String id;
  final String title;
  final String content;
  final String date;
  final String imageUrl;

  NewsItem({
    required this.id,
    required this.title,
    required this.content,
    required this.date,
    required this.imageUrl,
  });

  factory NewsItem.fromJson(Map<String, dynamic> json) {
    return NewsItem(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      date: json['date'],
      imageUrl: json['imageUrl'] ?? '',
    );
  }
}