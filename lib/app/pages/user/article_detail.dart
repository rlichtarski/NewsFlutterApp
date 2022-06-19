import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/models/article.dart';
import 'package:news_app/widgets/user_top_bar.dart';

class ArticleDetail extends ConsumerWidget {
  const ArticleDetail({Key? key, required this.article}) : super(key: key);

  final Article article;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            children: [
              UserTopBar(
                leadingIconButton: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                bookmarkIconButton: IconButton(
                  icon: const Icon(Icons.bookmark_border),
                  onPressed: () {
                    //save the article to favorites
                  }, 
                ),
              ),
              const SizedBox(height: 15,),
              Hero(
                tag: '${article.imageUrl}',
                child: AspectRatio(
                  aspectRatio: 3 / 2,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30.0),
                    child: CachedNetworkImage(
                      imageUrl: article.imageUrl!,
                      key: UniqueKey(),
                      fit: BoxFit.fitWidth,
                      placeholder: (context, url) => Container(color: Colors.black12,),
                      errorWidget: (context, url, error) => const SizedBox(
                        child: Icon(
                          Icons.broken_image,
                          size: 100,
                          color: Colors.black38,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15,),
              Text(
                article.title,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 26
                ),  
              ),
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    article.category,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 149, 149, 158),
                      fontSize: 16.0
                    ),
                  ),
                  Text(
                    article.timestamp,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 149, 149, 158),
                      fontWeight: FontWeight.w300,
                      fontSize: 16.0
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30,),
              Text(
                article.description,
                style: const TextStyle(
                  fontSize: 18.0
                ),
              ),
            ]
          ),
        ),
      ),
    );
  }
}
