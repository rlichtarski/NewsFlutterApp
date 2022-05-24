class Article {

  final String title;
  final String description;
  final String imageUrl;
  final String timestamp;
  final String? id;

  Article({
    this.id,
    required this.title, 
    required this.description, 
    required this.imageUrl,
    required this.timestamp
  });

  Map<String, dynamic> toMap(String docId) => {
    'id': docId,
    'title': title,
    'description': description,
    'imageUrl': imageUrl,
    'timestamp': timestamp,
  };

  factory Article.fromMap(Map<String, dynamic> map) => 
    Article(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      timestamp: map['timestamp'] ?? '',
    );

}
