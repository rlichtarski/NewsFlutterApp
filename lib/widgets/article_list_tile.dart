

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:news_app/models/article.dart';
import 'package:news_app/utils/constants.dart';

class ArticleListTile extends StatelessWidget {
  final Function()? onPressed;
  final Function()? onDelete;
  final Article article;
  const ArticleListTile({
    Key? key,
    required this.article,
    this.onPressed,
    this.onDelete
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        if(onPressed != null) onPressed!();
      },
      child: Container(
        width: screenSize.width,
        height: 100,
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(.05),
              spreadRadius: 0,
              blurRadius: 10,
              offset: const Offset(10, 20)
            ),
          ]
        ),
        child: Row(
          children: [
            article.imageUrl != uploadImageError 
              ? ClipRRect(
                  child: Image.network(
                    article.imageUrl,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ) 
              : const Text('No image found!'),
            const SizedBox(width: 15,),
            Expanded(
              child: Text(
                article.title,
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18
                ),
              ),
            ),
            const SizedBox(width: 10,),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                article.timestamp,
                style: const TextStyle(
                  fontSize: 12
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
