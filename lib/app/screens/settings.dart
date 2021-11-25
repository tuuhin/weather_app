import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/data/local/localstorage.dart';
import 'package:weatherapp/domain/services/cubit/FavouritesCubit/favourites_cubit.dart';
import 'package:weatherapp/domain/services/theme/changetheme_cubit.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ChangeThemeCubit _themecubit =
        BlocProvider.of<ChangeThemeCubit>(context, listen: true);
    FavouritesCubit _fav = BlocProvider.of<FavouritesCubit>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Settings', style: Theme.of(context).textTheme.headline6),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: ListView(
        children: [
          const Divider(),
          SwitchListTile(
              secondary: const Icon(Icons.light),
              title: const Text('Toggle Theme'),
              value: _themecubit.dark,
              onChanged: (t) {
                _themecubit.toggletheme();
              }),
          ListTile(
              leading: const Icon(Icons.favorite_border),
              title: const Text('Clear Favourites'),
              subtitle: const Text('Tap to clear favourites'),
              onTap: () {
                LocalStorage.clearFavorites();
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
                'OpenWeather aggregates and process thousands of data from the tens and thousands of weather stations, on-ground raders and satellites to bring you the accurate and actionable weather data from any locatiity'),
          ),
        ],
      ),
    );
  }
}
