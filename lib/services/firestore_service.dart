
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:news_app/models/article.dart';
import 'package:news_app/utils/constants.dart';

class FirestoreService {

  final String uid;
  FirestoreService({required this.uid});

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addArticle(Article article) async {
    final docId = firestore
      .collection(articlesCol)
      .doc()
      .id;

    await firestore
      .collection(articlesCol)
      .doc(docId)
      .set(article.toMap(docId));
  }

  Future<void> editArticle(Article article) async {
    await firestore
      .collection(articlesCol)
      .doc(article.id)
      .update(article.toMap(article.id!));
  }

  Stream<List<Article>> getArticles() => firestore
    .collection(articlesCol)
    .snapshots()
    .map((snapshot) => snapshot.docs.map((doc) {
      final docData = doc.data();
      return Article.fromMap(docData);
    }).toList());

  Future<void> deleteArticle(String id) async => await firestore
    .collection(articlesCol)
    .doc(id)
    .delete();

}

