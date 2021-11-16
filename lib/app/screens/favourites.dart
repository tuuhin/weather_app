import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/app/routes/searchpage/searchpage.dart';
import 'package:weatherapp/app/screens/favourites/weather_card.dart';
import 'package:weatherapp/app/screens/favourites/weather_card_shimmer.dart';
import 'package:weatherapp/domain/services/cubit/FavouritesCubit/favourites_cubit.dart';

class Favourites extends StatelessWidget {
  const Favourites({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FavouritesCubit _fav = BlocProvider.of(context, listen: true);
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
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
            Expanded(child: BlocBuilder<FavouritesCubit, FavouritesState>(
              builder: (context, state) {
                print(state);
                if (state is Success) {
                  print(state.favouritesInfo);
                  return ListView.builder(
                      itemCount: state.favouritesInfo!.length,
                      itemBuilder: (BuildContext context, int i) => WeatherCard(
                            cityname: state.favouritesInfo![i].cityname,
                            humidity: i,
                            temp: i,
                            pressure: i,
                            windSpeed: i,
                            visibility: i,
                          ));
                }
                if (state is Loading) {
                  _fav.loadData();
                }
                return ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, i) => WeatherShimmer());
              },
            ))
            // Expanded(
          ],
        ),
      )),
    );
  }
}
