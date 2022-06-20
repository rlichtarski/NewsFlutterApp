import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:news_app/app/pages/user/article_detail.dart';
import 'package:news_app/app/providers.dart';
import 'package:news_app/models/article.dart';
import 'package:news_app/utils/constants.dart';
import 'package:news_app/utils/snackbars.dart';

class SavedArticleListTile extends ConsumerWidget {
  const SavedArticleListTile({Key? key, required this.article}) : super(key: key);  
  final Article article;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Slidable(
      key: const Key('0'),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              ref.read(savedArticlesProvider).removeArticle(article);
              ref.read(databaseProvider)!.removeFavoriteArticle(article);
              openIconSnackBar(
                context, 
                'Deleted from saved', 
                const Icon(
                  Icons.check,
                  color: Colors.white,
                ),
              );
            },
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          )
        ],
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => ArticleDetail(article: article))
          );
        },
        child: ListTile(
          leading: article.imageUrl != uploadImageError 
          ? Hero(
            tag: '${article.imageUrl}',
            child: ClipRRect(
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
              borderRadius: BorderRadius.circular(8),
              ),
          ) 
          : const Text('No image found!'),
          title: Text(
            article.title,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(article.category),
              Text(article.timestamp),
            ],
          ),
        ),
      ),
    );
  }
}