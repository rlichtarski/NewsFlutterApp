
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:news_app/models/article.dart';
import 'package:news_app/models/user_data.dart';
import 'package:news_app/utils/constants.dart';

class FirestoreService {

  final String uid;
  FirestoreService({required this.uid});

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addUser(UserData user) async {
    await firestore.collection('users').doc(user.uid).set(user.toMap());
  }

  Future<UserData?> getUser(String uid) async {
    final doc = await firestore.collection('users').doc(uid).get();
    return doc.exists ? UserData.fromMap(doc.data()!) : null;
  }

  Future<void> addArticle(Article article) async {
    final docId = firestore
      .collection(articlesCol)
      .doc()
      .id;

    article.imageUrl == null ?
      await firestore
        .collection(articlesCol)
        .doc(docId)
        .set(article.toMapNoImage(docId))
      : await firestore
        .collection(articlesCol)
        .doc(docId)
        .set(article.toMap(docId));
  }

  Future<void> editArticle(Article article) async {
    article.imageUrl == null 
      ? await firestore
        .collection(articlesCol)
        .doc(article.id)
        .update(article.toMapNoImage(article.id!))
      : await firestore
        .collection(articlesCol)
        .doc(article.id)
        .update(article.toMap(article.id!));
  }

  Future<void> saveFavoriteArticle(Article article) async => await firestore
    .collection('users')
    .doc(uid)
    .collection('saved_articles')
    .doc(article.id)
    .set(
      article.toMap(article.id!)
    );

  Future<void> removeFavoriteArticle(Article article) async => await firestore
    .collection('users')
    .doc(uid)
    .collection('saved_articles')
    .doc(article.id)
    .delete();

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

