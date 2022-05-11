
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:news_app/models/article.dart';

class FirestoreService {

  final String uid;
  FirestoreService({required this.uid});

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addArticle(Article article) async => await firestore
    .collection('articles')
    .add(article.toMap())
    .then((value) => print(value))
    .catchError((onError) => print('Error $onError'));


}

