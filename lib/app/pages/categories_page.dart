import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/app/providers.dart';

class CategoriesPage extends ConsumerWidget {
  const CategoriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
              FutureBuilder(
                future: ref.read(databaseProvider)!.getCategories(),
                builder: (context, AsyncSnapshot<List<String>> snapshot) {
                  if(snapshot.hasError || !snapshot.hasData) {
                    return const Center(child: Text('An error has occurred'),);
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
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          final category = snapshot.data![index];
                          print(category);
                          return Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  //navigate to Sport articles
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
            ],
          ),
        ),
      ),
    );
  }

}
