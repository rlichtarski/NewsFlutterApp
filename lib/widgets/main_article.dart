import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/widgets/display_articles.dart';

class MainArticle extends StatelessWidget {
  const MainArticle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        color: const Color.fromARGB(75, 255, 255, 255),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(30.0),
            child: CachedNetworkImage(
              imageUrl: 'https://i.imgur.com/5LY1mTO.jpeg',
              key: UniqueKey(),
              fit: BoxFit.cover,
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
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Articles title is here and now!',
                  maxLines: 2,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 20.0
                  ),
                ),
                const SizedBox(height: 8,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const[
                    Text(
                      'Technology',
                      style: TextStyle(
                        color: Color.fromARGB(255, 149, 149, 158),
                        fontSize: 14.0
                      ),
                    ),
                    Text(
                      '29.06.2022',
                      style: TextStyle(
                        color: Color.fromARGB(255, 149, 149, 158),
                        fontWeight: FontWeight.w300,
                        fontSize: 14.0
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

//design inspired from https://dribbble.com/shots/14905782/attachments/6619453?mode=media
