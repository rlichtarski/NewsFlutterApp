import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/app/pages/user/category_articles.dart';
import 'package:news_app/app/providers.dart';
import 'package:news_app/widgets/empty_widget.dart';

class CategoriesPage extends ConsumerWidget {
  const CategoriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
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
                        'Categories',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: FutureBuilder(
                    future: ref.read(databaseProvider)!.getCategories(),
                    builder: (context, AsyncSnapshot<List<String>> snapshot) {
                      if(snapshot.hasError || !snapshot.hasData) {
                        return const EmptyWidget(text: 'No categories found');
                      }
                      switch(snapshot.connectionState) {
                        case ConnectionState.active: {
                          return const Center(child: Text('Connection active'));
                        }
                        case ConnectionState.waiting: {
                          return const Center(child: CircularProgressIndicator());
                        }
                        case ConnectionState.done: {
                          return ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            //make the ListView.builder not scrollable so the SingleChildScrollView can scroll
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              final category = snapshot.data![index];
                              return Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) => CategoryArticles(category: category,))
                                      );
                                    },
                                    child: ListTile(
                                      title: Text(
                                        category,
                                        style: const TextStyle(
                                          fontSize: 20
                                        ),
                                      ),
                                    ),
                                  ),
                                  if(snapshot.data!.last != category) const Divider(
                                    height: 1,
                                    thickness: 1.2,
                                  ),
                                ],
                              );
                            }
                          );
                        }
                        case ConnectionState.none: {
                          return const Center(child: CircularProgressIndicator());
                        }
                      }
                    }
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
