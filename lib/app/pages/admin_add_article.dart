import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/app/providers.dart';
import 'package:news_app/models/article.dart';
import 'package:news_app/widgets/input_field.dart';

class AdminAddProductPage extends ConsumerStatefulWidget {
  const AdminAddProductPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AdminAddProductPageState();
}

class _AdminAddProductPageState extends ConsumerState<AdminAddProductPage> {

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a Product'),
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
            const Spacer(),
            ElevatedButton(
              onPressed: () => _addArticle(), 
              child: const Text('Add the article')
            ),
          ],
        ),
      ),
    );
  }

  void _addArticle() async {
    final firestoreDB = ref.read(databaseProvider);
    if(firestoreDB == null) return;

    await firestoreDB.addArticle(
      Article(
        title: titleController.text, 
        description: descriptionController.text, 
        imageUrl: 'url'
      )
    );

    Navigator.pop(context);
  }

}

