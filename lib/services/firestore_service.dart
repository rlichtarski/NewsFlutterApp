
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

    checkIfArticleImageIsNull(article) 
      ? await firestore
        .collection(articlesCol)
        .doc(docId)
        .set(article.toMapNoImage(docId))
      : await firestore
        .collection(articlesCol)
        .doc(docId)
        .set(article.toMap(docId));

    await addArticleToCategory(article, docId);
  }

  Future<void> editArticle(Article article, String oldCategory) async {
    checkIfArticleImageIsNull(article) 
      ? await firestore
        .collection(articlesCol)
        .doc(article.id)
        .update(article.toMapNoImage(article.id!))
      : await firestore
        .collection(articlesCol)
        .doc(article.id)
        .update(article.toMap(article.id!));

    if(article.category != oldCategory) await editArticleCategory(article, oldCategory);
  }

  Future<void> saveFavoriteArticle(Article article) async => await firestore
    .collection('users')
    .doc(uid)
    .collection('saved_articles')
    .doc(article.id)
    .set(
      article.toMap(article.id!)
    );

  Future<void> addArticleToCategory(Article article, String articleId) async {
    checkIfArticleImageIsNull(article) ?
      await firestore
        .collection('categories')
        .doc(article.category)
        .collection('categoryArticles')
        .doc(articleId)
        .set(
          article.toMapNoImage(articleId)
        )
    : await firestore
      .collection('categories')
      .doc(article.category)
      .collection('categoryArticles')
      .doc(articleId)
      .set(
        article.toMap(articleId)
      );
  }

  Future<void> editArticleCategory(Article article, String oldCategory) async {
      await firestore
        .collection('categories')
        .doc(oldCategory)
        .collection('categoryArticles')
        .doc(article.id)
        .delete();
      
      await addArticleToCategory(article, article.id!);
  }

  Future<void> removeFavoriteArticle(Article article) async => await firestore
    .collection('users')
    .doc(uid)
    .collection('saved_articles')
    .doc(article.id)
    .delete();

  Stream<List<Article>> getFavoriteArticles() => firestore
    .collection('users')
    .doc(uid)
    .collection('saved_articles')
    .snapshots()
    .map((snapshot) => snapshot.docs.map((doc) { 
      final docData = doc.data();
      return Article.fromMap(docData);
    }).toList());

  Stream<List<Article>> getArticlesByCategory(String category) => firestore
    .collection('categories')
    .doc(category)
    .collection('categoryArticles')
    .snapshots()
    .map((snapshot) => snapshot.docs.map((doc) { 
      final docData = doc.data();
      return Article.fromMap(docData);
    }).toList());

  Future<bool> checkIfArticleSaved(String docId) async {
    var collectionRef = firestore
      .collection('users')
      .doc(uid)
      .collection('saved_articles');

    var doc = await collectionRef.doc(docId).get();
    return doc.exists;
  }

  Stream<dynamic> checkIfArticleSavedStream(String docId) {
    return firestore
      .collection('users')
      .doc(uid)
      .collection('saved_articles')
      .doc(docId)
      .snapshots();
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

  Future<void> deleteArticleFromCategories(String id, String category) async => await firestore
    .collection('categories')
    .doc(category)
    .collection('categoryArticles')
    .doc(id)
    .delete();

  bool checkIfArticleImageIsNull(Article article) => article.imageUrl == null; 

}

