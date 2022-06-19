import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:news_app/app/providers.dart';
import 'package:news_app/utils/constants.dart';
import 'package:news_app/utils/snackbars.dart';
import 'package:news_app/widgets/empty_widget.dart';

class SavedArticles extends ConsumerWidget {
  const SavedArticles({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final savedArticlesViewModel = ref.watch(savedArticlesProvider);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    }, 
                    icon: const Icon(Icons.arrow_back)
                  ),
                  const Flexible(
                    child: Text(
                      'Saved Articles',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                      ),
                    ),
                  ),
                ],
              ),
              savedArticlesViewModel.savedArticlesNotEmpty
              ? Flexible(
                child: ListView.builder(
                  itemCount: savedArticlesViewModel.totalArticles,
                  itemBuilder: ((context, index) {
                    final article = savedArticlesViewModel.savedArticles[index];
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
                      child: ListTile(
                        leading: article.imageUrl != uploadImageError 
                        ? ClipRRect(
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
                    );
                  })
                )
              )
              : const EmptyWidget(text: 'No articles saved...',)
            ],
          ),
        ),
      ),
    );
  }
}
