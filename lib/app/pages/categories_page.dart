import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/widgets/user_top_bar.dart';

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
              GestureDetector(
                onTap: () {
                  //navigate
                },
                child: const ListTile(
                  leading: Icon(Icons.sports_soccer),
                  title: Text('Sport'),
                ),
              ),
              const Divider(
                height: 1,
                thickness: 1.2,
              ),
              const ListTile(
                leading: Icon(Icons.computer),
                title: Text('Technology'),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
