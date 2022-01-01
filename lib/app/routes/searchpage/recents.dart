import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/app/routes/searchpage/searchpage.dart';
import 'package:weatherapp/data/local/localstorage.dart';
import 'package:weatherapp/data/local/store_fav.dart';
import 'package:weatherapp/data/local/store_recents.dart';
import 'package:weatherapp/domain/services/cubit/SearchCubit/search_cubit.dart';

class Recents extends StatefulWidget {
  const Recents({Key? key}) : super(key: key);

  @override
  State<Recents> createState() => _RecentsState();
}

class _RecentsState extends State<Recents> {
  @override
  Widget build(BuildContext context) {
    final SearchCubit _searchcubit = BlocProvider.of<SearchCubit>(context);
    final List<String>? _recents = StoreRecents.getRecents();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CurrentLocation(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Recents', style: Theme.of(context).textTheme.headline6),
              IconButton(
                  onPressed: () {
                    StoreFavourites.clearFavourites();
                    setState(() {});
                  },
                  icon: const Icon(Icons.delete_forever))
            ],
          ),
          (_recents == null || _recents.isEmpty)
              ? const Center(child: Text('No recents search'))
              : Expanded(
                  child: ListView.builder(
                      itemCount: _recents.length,
                      itemBuilder: (context, i) => ListTile(
                            minVerticalPadding: 0,
                            title: Text(_recents[i]),
                            onTap: () {
                              _searchcubit.getCity(_recents[i]);
                            },
                          )),
                )
        ],
      ),
    );
  }
}
