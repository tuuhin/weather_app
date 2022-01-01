import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/data/local/store_fav.dart';
import 'package:weatherapp/domain/services/cubit/FavouritesCubit/favourites_cubit.dart';
import 'package:weatherapp/domain/services/cubit/TimeFormatCubit/timeformat_cubit.dart';
import 'package:weatherapp/domain/services/theme/changetheme_cubit.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ChangeThemeCubit _themecubit =
        BlocProvider.of<ChangeThemeCubit>(context, listen: true);
    FavouritesCubit _fav = BlocProvider.of<FavouritesCubit>(context);

    TimeFormatCubit _timeFormat =
        BlocProvider.of<TimeFormatCubit>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        title: Text('Settings', style: Theme.of(context).textTheme.headline6),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: ListView(
        physics: const NeverScrollableScrollPhysics(),
        children: [
          const Divider(),
          SwitchListTile(
              secondary: const Icon(Icons.schedule),
              title: const Text('24:00 Clock'),
              value: _timeFormat.is24Mode,
              onChanged: (t) {
                _timeFormat.toggleMode();
              }),
          SwitchListTile(
              secondary: Icon(_themecubit.dark ? Icons.dark_mode : Icons.light),
              title: const Text('Toggle Theme'),
              value: _themecubit.dark,
              onChanged: (t) {
                _themecubit.toggletheme();
              }),
          ListTile(
              leading: const Icon(Icons.favorite, color: Colors.pinkAccent),
              title: const Text('Clear Favourites'),
              subtitle: const Text('Tap to clear favourites'),
              onTap: () {
                StoreFavourites.clearFavourites();
                _fav.loadData();
              }),
          ListTile(
            leading: const Icon(Icons.info),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Data'),
                Text('openweathermap.org',
                    style: Theme.of(context).textTheme.caption)
              ],
            ),
            subtitle: const Text(
                'OpenWeather aggregates and process thousands of data from thousands of weather stations and satellites to bring you the accurate data from any locatiity'),
          ),
        ],
      ),
    );
  }
}
