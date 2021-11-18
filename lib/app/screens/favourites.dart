import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/app/routes/searchpage/searchpage.dart';
import 'package:weatherapp/app/screens/favourites/favourites_builder.dart';
import 'package:weatherapp/domain/services/cubit/SearchCubit/search_cubit.dart';

class Favourites extends StatelessWidget {
  const Favourites({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SearchCubit _searchcubit = BlocProvider.of<SearchCubit>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3),
        child: SafeArea(
            child: Column(
          children: [
            GestureDetector(
              onTap: () {
                _searchcubit.showLoading();
                Navigator.of(context, rootNavigator: false).push(
                    MaterialPageRoute(
                        builder: (BuildContext context) => const SearchBar()));
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3),
                child: ListTile(
                  tileColor: Theme.of(context).brightness == Brightness.light
                      ? Colors.grey[100]
                      : Colors.white10,
                  trailing: const Icon(Icons.search),
                  title: Text(
                    'Search',
                    style: TextStyle(
                        color: Theme.of(context).textTheme.caption!.color),
                  ),
                ),
              ),
            ),
            const Divider(),
            const FavouritesBuilder(),
          ],
        )),
      ),
    );
  }
}
