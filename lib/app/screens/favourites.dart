import 'package:flutter/material.dart';
import 'package:weatherapp/app/favourites/search.dart';

class Favourites extends StatelessWidget {
  const Favourites({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          TextButton(
              onPressed: () {
                Navigator.of(context, rootNavigator: false).push(
                    MaterialPageRoute(
                        builder: (BuildContext context) => const SearchBar()));
              },
              child: Text('press me'))
        ],
      )),
    );
  }
}
