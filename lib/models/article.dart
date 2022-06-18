class Article {

  final String title;
  final String description;
  final String category;
  final String? imageUrl;
  final String timestamp;
  final String? id;

  Article({
    this.id,
    required this.title, 
    required this.description, 
    required this.category,
    this.imageUrl,
    required this.timestamp
  });

  Map<String, dynamic> toMap(String docId) => {
    'id': docId,
    'title': title,
    'description': description,
    'category': category,
    'imageUrl': imageUrl,
    'timestamp': timestamp,
  };

  Map<String, dynamic> toMapNoImage(String docId) => {
    'id': docId,
    'title': title,
    'description': description,
    'category': category,
    'timestamp': timestamp,
  };

  factory Article.fromMap(Map<String, dynamic> map) => 
    Article(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      category: map['category'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      timestamp: map['timestamp'] ?? '',
    );

}
