import 'package:flutter/material.dart';
import 'package:weatherapp/data/local/store_fav.dart';

class FavouriteAppBar extends StatefulWidget {
  final String? cityname;
  const FavouriteAppBar({Key? key, this.cityname}) : super(key: key);

  @override
  State<FavouriteAppBar> createState() => _FavouriteAppBarState();
}

class _FavouriteAppBarState extends State<FavouriteAppBar> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () async {
          bool updateFav =
              await StoreFavourites.updateFavourites(widget.cityname);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              duration: const Duration(seconds: 1),
              content: Text(updateFav
                  ? 'Added ${widget.cityname} to your favourites'
                  : 'Removed ${widget.cityname} from your favourites')));
          setState(() {});
        },
        icon: Icon(Icons.favorite,
            color: StoreFavourites.isFavourite(widget.cityname)
                ? Colors.pinkAccent
                : Colors.white60));
  }
}
