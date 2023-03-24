import 'package:flutter/material.dart';

class FavoritesView extends StatefulWidget {
  const FavoritesView({
    Key? key,
  }) : super(key: key);

  @override
  State<FavoritesView> createState() => _FavoritesViewState();
}

class _FavoritesViewState extends State<FavoritesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: const Center(child: Text('Favorites')),
    );
  }
}
