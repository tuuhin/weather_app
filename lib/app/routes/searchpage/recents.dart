import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weatherapp/app/routes/searchpage/searchpage.dart';
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
          ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                'Recents',
                style: Theme.of(context).textTheme.headline6!.copyWith(
                    fontFamily: GoogleFonts.workSans().fontFamily,
                    fontWeight: FontWeight.w400),
              ),
              trailing: IconButton(
                  onPressed: () {
                    StoreFavourites.clearFavourites();
                    setState(() {});
                  },
                  icon: const Icon(Icons.delete_forever))),
          (_recents == null || _recents.isEmpty)
              ? Center(
                  child: Text('No recents search',
                      style: Theme.of(context).textTheme.caption!.copyWith(
                          fontSize: 14,
                          fontFamily:
                              GoogleFonts.robotoCondensed().fontFamily)),
                )
              : Expanded(
                  child: ListView.builder(
                      itemCount: _recents.length,
                      itemBuilder: (context, i) => ListTile(
                            dense: true,
                            title: Text(
                              _recents[i],
                              style: const TextStyle(fontSize: 14),
                            ),
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
