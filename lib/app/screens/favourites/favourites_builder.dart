import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/app/screens/favourites/weather_card.dart';
import 'package:weatherapp/app/screens/favourites/weather_card_shimmer.dart';
import 'package:weatherapp/domain/services/cubit/FavouritesCubit/favourites_cubit.dart';

class FavouritesBuilder extends StatelessWidget {
  const FavouritesBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FavouritesCubit _fav =
        BlocProvider.of<FavouritesCubit>(context, listen: true);
    return Expanded(
      child: BlocBuilder<FavouritesCubit, FavouritesState>(
        builder: (context, state) {
          if (state is Loading) {
            _fav.loadData();
            return ListView.builder(
                itemCount: 4,
                itemBuilder: (context, i) => const WeatherShimmer());
          } else if (state is Socket) {
            return const Text('Internet absent');
          } else if (state is NoFavourites) {
            return const Text('There is no favourites');
          } else if (state is UnknownError) {
            return const Text('unknown error');
          } else if (state is Success) {
            return ListView.builder(
                itemCount: state.favouritesInfo!.length,
                itemBuilder: (BuildContext context, int i) {
                  return WeatherCard(
                      cityname: state.favouritesInfo![i].cityname,
                      humidity: state.favouritesInfo![i].humidity,
                      temp: state.favouritesInfo![i].temp,
                      pressure: state.favouritesInfo![i].pressure,
                      windSpeed: state.favouritesInfo![i].windSpeed,
                      visibility: state.favouritesInfo![i].visibility);
                });
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
