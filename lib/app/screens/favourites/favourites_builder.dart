import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/app/responses/responses.dart';
import 'package:weatherapp/app/screens/favourites/no_users_fav_exists.dart';
import 'package:weatherapp/app/screens/favourites/weather_card.dart';
import 'package:weatherapp/app/screens/favourites/weather_card_shimmer.dart';
import 'package:weatherapp/domain/services/cubit/FavouritesCubit/favourites_cubit.dart';

class FavouritesBuilder extends StatelessWidget {
  const FavouritesBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FavouritesCubit _fav =
        BlocProvider.of<FavouritesCubit>(context, listen: true);
    return BlocBuilder<FavouritesCubit, FavouritesState>(
      builder: (context, state) {
        if (state is Loading) {
          _fav.loadData();
          return ListView.builder(
              itemCount: 4,
              itemBuilder: (context, i) => const WeatherShimmer());
        } else if (state is InternetAbsent) {
          return Responses(
            imageSrc: 'assets/api/network.png',
            helper: 'No internet',
            secondary:
                'Internet connection is found. Turn on the internet and try again',
            buttonText: 'Open Settings',
            onPressed: () {
              AppSettings.openDataRoamingSettings();
            },
            tryAgain: () {
              _fav.emit(Loading());
            },
          );
        } else if (state is BadRequest) {
          return Responses(
            imageSrc: 'assets/api/bad-req.png',
            helper: 'Failed ',
            secondary: state.badReq,
            helperAbsent: true,
          );
        } else if (state is NoFavourites) {
          return const NoUserFavorites();
        } else if (state is Unknown) {
          return Responses(
            imageSrc: 'assets/api/unknown.png',
            helper: 'Error',
            secondary:
                'There is some ${state.error} .Its adviced to use the app after some period of time',
            helperAbsent: true,
          );
        } else if (state is Success) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
                itemCount: state.favouritesInfo!.length,
                itemBuilder: (BuildContext context, int i) {
                  return WeatherCard(
                      cityname: state.favouritesInfo![i].cityname,
                      humidity: state.favouritesInfo![i].humidity,
                      temp: state.favouritesInfo![i].temp,
                      pressure: state.favouritesInfo![i].pressure,
                      windSpeed: state.favouritesInfo![i].windSpeed,
                      visibility: state.favouritesInfo![i].visibility);
                }),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
