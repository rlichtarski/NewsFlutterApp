import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:news_app/app/providers.dart';
import 'package:news_app/models/article.dart';
import 'package:news_app/services/loading_notifier.dart';
import 'package:news_app/utils/snackbars.dart';
import 'package:news_app/widgets/input_field.dart';

class AdminEditArticlePage extends ConsumerStatefulWidget {
  const AdminEditArticlePage({Key? key, required this.article}) : super(key: key);
  
  final Article article;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AdminEditArticlePageState();
}

class _AdminEditArticlePageState extends ConsumerState<AdminEditArticlePage> {

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    setTextControllers(widget.article);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Edit the Article'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            CustomInputField(
              inputController: titleController, 
              hintText: "Article's title", 
              labelText: "Article's title"
            ),
            const SizedBox(height: 15),
            CustomInputField(
              inputController: descriptionController, 
              hintText: "Article's description", 
              labelText: "Article's description"
            ),
            const SizedBox(height: 15),
            Consumer(
              builder: (context, ref, child) {
                final image = ref.watch(pickImageProvider);
                return image == null 
                  ? CachedNetworkImage(
                    imageUrl: widget.article.imageUrl!,
                    key: UniqueKey(),
                    height: 300,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(color: Colors.black12,),
                    errorWidget: (context, url, error) => const SizedBox(
                      child: Icon(
                        Icons.broken_image,
                        size: 100,
                        color: Colors.black38,
                      ),
                    ),
                  ) 
                  : Image.file(
                    File(image.path),
                    height: 300,
                  );
              },
            ),
            const SizedBox(height: 15),
            GestureDetector(
              child: const Text(
                'Pick an image',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  fontSize: 20
                ),
              ),
              onTap: () async {
                final image = await ImagePicker().pickImage(source: ImageSource.gallery);
                if(image != null) {
                  ref.watch(pickImageProvider.state).state = image; 
                }
              },
            ),
            const Spacer(),
            Consumer(
              builder: (context, ref, child) {
                final loadingNotifier = ref.watch(isLoadingProvider);
                return loadingNotifier.loading 
                  ? const Padding(
                    padding: EdgeInsets.all(6.0),
                    child: CircularProgressIndicator(),
                  )
                  : ElevatedButton(
                    onPressed: () { 
                      ref.read(isLoadingProvider).isLoading(true);
                      _editArticle(); 
                    }, 
                    child: const Text('Edit the article')
                  );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _editArticle() async {
    final firestoreDB = ref.read(databaseProvider);
    final imagePicker = ref.read(pickImageProvider);
    final storage = ref.read(storageProvider);

    if(firestoreDB == null || storage == null) return;

    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd.MM.yyyy').format(now);

    if(imagePicker != null) {
      final url = await storage.uploadImage(imagePicker.path);

      await firestoreDB.editArticle(
        Article(
          title: titleController.text, 
          description: descriptionController.text, 
          imageUrl: url,
          timestamp: formattedDate,
          id: widget.article.id
        )
      );
    } else {
      await firestoreDB.editArticle(
        Article(
          title: titleController.text, 
          description: descriptionController.text, 
          timestamp: formattedDate,
          id: widget.article.id
        )
      );
    }
    openIconSnackBar(
      context, 
      'Edited the article', 
      const Icon(
        Icons.check,
        color: Colors.white,
      )
    );

    Navigator.pop(context);
  }
  
  void setTextControllers(Article? article) {
    if(article != null) {
      titleController.text = article.title;
      descriptionController.text = article.description;
      
    }
  }

}

