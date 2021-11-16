import 'package:flutter/material.dart';
import 'package:weatherapp/data/local/localstorage.dart';

class FavouriteAppBar extends StatefulWidget {
  final String? cityname;
  const FavouriteAppBar({Key? key, this.cityname}) : super(key: key);

  @override
  State<FavouriteAppBar> createState() => _FavouriteAppBarState();
}

class _FavouriteAppBarState extends State<FavouriteAppBar> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox.shrink(),
        IconButton(
            onPressed: () async {
              bool favourite = await LocalStorage.newFavourite(widget.cityname);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  duration: const Duration(seconds: 1),
                  content: Text(favourite
                      ? 'Added to favourites'
                      : 'removed from favourites')));
              setState(() {});
            },
            icon: Icon(LocalStorage.isFav(widget.cityname ?? '')
                ? Icons.favorite
                : Icons.favorite_outline))
      ],
    );
  }
}
