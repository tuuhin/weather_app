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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: ListTile(
          dense: true,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          onTap: () {
            _searchcubit.showLoading();
            Navigator.of(context, rootNavigator: false).push(MaterialPageRoute(
                builder: (BuildContext context) => const SearchBar()));
          },
          tileColor: Theme.of(context).brightness == Brightness.light
              ? null
              : Colors.white10,
          trailing: const Icon(Icons.search),
          title: Text(
            'Search',
            style: TextStyle(color: Theme.of(context).textTheme.caption!.color),
          ),
        ),
      ),
      body: const SafeArea(
        child: FavouritesBuilder(),
      ),
    );
  }
}
