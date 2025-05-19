class NewsItem {
  final String id;
  final String title;
  final DateTime publishedAt;
  final String imageUrl;

  const NewsItem({
    required this.id,
    required this.title,
    required this.publishedAt,
    required this.imageUrl,
  });
}