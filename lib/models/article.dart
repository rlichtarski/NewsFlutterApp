class Article {

  final String title;
  final String description;
  final String imageUrl;

  Article({required this.title, required this.description, required this.imageUrl});

  Map<String, dynamic> toMap() => {
    'title': title,
    'description': description,
    'imageUrl': imageUrl,
  };

  factory Article.fromMap(Map<String, dynamic> map) => 
    Article(
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
    );

}
