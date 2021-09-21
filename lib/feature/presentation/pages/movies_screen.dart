import 'package:film_catalog_app/feature/presentation/widgets/custom_search_delegate.dart';
import 'package:film_catalog_app/feature/presentation/widgets/movies_list.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Каталог фильмов'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () => showSearch(context: context, delegate: CustomSearchDelegate()),
          ),
        ],
      ),
      body: MoviesList(),
    );
  }
}
