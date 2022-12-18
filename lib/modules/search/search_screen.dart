import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text(
          'Search Screen',
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ),
    );
  }
}
