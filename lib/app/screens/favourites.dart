import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/app/routes/searchpage/searchpage.dart';
import 'package:weatherapp/app/screens/favourites/favourites_builder.dart';
import 'package:weatherapp/domain/services/cubit/FavouritesCubit/favourites_cubit.dart';
import 'package:weatherapp/domain/services/cubit/SearchCubit/search_cubit.dart';

class Favourites extends StatelessWidget {
  const Favourites({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SearchCubit _searchcubit = BlocProvider.of<SearchCubit>(context);
    FavouritesCubit _fav = BlocProvider.of<FavouritesCubit>(context);
    return RefreshIndicator(
      onRefresh: () async {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: const Text('Reload Favourites'),
                  content: const Text('press reload to reload favourites'),
                  actions: [
                    TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Cancel')),
                    ElevatedButton(
                        onPressed: () {
                          _fav.refreshFavs();
                          Navigator.of(context).pop();
                        },
                        child: const Text('Reload'))
                  ],
                ));
        // _fav.refreshFavs();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: ListTile(
            dense: true,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            onTap: () {
              _searchcubit.showRecents();
              Navigator.of(context, rootNavigator: false).push(
                  MaterialPageRoute(
                      builder: (BuildContext context) => const SearchBar()));
            },
            tileColor: Theme.of(context).brightness == Brightness.light
                ? null
                : Colors.white10,
            trailing: const Icon(Icons.search),
            title: Text(
              'Search',
              style:
                  TextStyle(color: Theme.of(context).textTheme.caption!.color),
            ),
          ),
        ),
        body: const SafeArea(
          child: FavouritesBuilder(),
        ),
      ),
    );
  }
}
