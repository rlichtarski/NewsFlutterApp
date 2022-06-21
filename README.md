# NewsFlutterApp
A news app made with Flutter, [Riverpod](https://riverpod.dev/) and [Firebase](https://firebase.flutter.dev/) (Authentication, Cloud Firestore, Cloud Storage). The app is divided into two parts - admin side and user side. The admin is able to add, edit, delete articles and user is able to read and add the article to favorites. 

## The app is made with:
- [Riverpod](https://pub.dev/packages/flutter_riverpod) - for state management
- [firebase_auth](https://pub.dev/packages/firebase_auth) - for authentication
- [cloud_firestore](https://pub.dev/packages/cloud_firestore) - for creating, reading, updating and deleting articles and favorite articles
- [firebase_storage](https://pub.dev/packages/firebase_storage) - for saving article's images
- [image_picker](https://pub.dev/packages/image_picker) - for picking an image for an article from a mobile device's image library
- [flutter_slidable](https://pub.dev/packages/flutter_slidable) - for slidable list item with directional slide actions
- [lottie](https://pub.dev/packages/lottie) - for animations
- [cached_network_image](https://pub.dev/packages/cached_network_image) - for showing an image and keeping it in the cache directory

# Preview of the app:
## User side: 
![](https://github.com/rradzzio/NewsFlutterApp/blob/main/articles_user.png)
![](https://github.com/rradzzio/NewsFlutterApp/blob/main/btc_article.png)
![](https://github.com/rradzzio/NewsFlutterApp/blob/main/saved_articles.png)
![](https://github.com/rradzzio/NewsFlutterApp/blob/main/delete_saved_article.png)
![](https://github.com/rradzzio/NewsFlutterApp/blob/main/saved_articles_empty.png)
## Admin side:
![](https://github.com/rradzzio/NewsFlutterApp/blob/main/admin_home.png)
![](https://github.com/rradzzio/NewsFlutterApp/blob/main/admin_delete_article.png)
![](https://github.com/rradzzio/NewsFlutterApp/blob/main/admin_add_article.png)
![](https://github.com/rradzzio/NewsFlutterApp/blob/main/admin_edit_article.png)
