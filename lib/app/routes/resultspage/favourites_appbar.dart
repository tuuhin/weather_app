import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/data/local/localstorage.dart';
import 'package:weatherapp/data/local/store_fav.dart';
import 'package:weatherapp/domain/services/cubit/FavouritesCubit/favourites_cubit.dart';

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
              content:
                  Text(updateFav ? 'Favourite Added' : 'Favourite Removed')));
          setState(() {});
        },
        icon: Icon(StoreFavourites.isFavourite(widget.cityname)
            ? Icons.favorite
            : Icons.favorite_outline));
  }
}
