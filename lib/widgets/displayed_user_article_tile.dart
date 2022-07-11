import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/app/pages/user/article_detail.dart';
import 'package:news_app/models/article.dart';
import 'package:news_app/utils/constants.dart';

class DisplayedUserArticleListTile extends StatelessWidget {
  const DisplayedUserArticleListTile({Key? key, required this.article}) : super(key: key);

  final Article article;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ArticleDetail(
              article: article,
            ),
          )
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        child: Row(
          children: [
            article.imageUrl != uploadImageError
              ? ClipRRect(
                child: Hero(
                  tag: '${article.imageUrl}',
                  child: CachedNetworkImage(
                    imageUrl: article.imageUrl!,
                    key: UniqueKey(),
                    height: 80,
                    width: 80,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(color: Colors.black12,),
                    errorWidget: (context, url, error) => Container(
                      color: Colors.black12,
                      child: const Icon(
                        Icons.broken_image,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                borderRadius: BorderRadius.circular(20),
                )
              : const Text('No image found!'),
            const SizedBox(width: 15,),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    article.title,
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        article.category,
                        style: const TextStyle(
                          color: Color.fromARGB(255, 149, 149, 158),
                          fontSize: 14.0
                        ),
                      ),
                      Text(
                        article.timestamp,
                        style: const TextStyle(
                          color: Color.fromARGB(255, 149, 149, 158),
                          fontWeight: FontWeight.w300,
                          fontSize: 14.0
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}