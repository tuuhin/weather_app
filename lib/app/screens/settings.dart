import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weatherapp/data/local/store_fav.dart';
import 'package:weatherapp/domain/services/cubit/AppCubit/app_cubit.dart';
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

    AppCubit _app = BlocProvider.of<AppCubit>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: Theme.of(context).textTheme.headline6!.copyWith(
              fontFamily: GoogleFonts.workSans().fontFamily,
              fontWeight: FontWeight.w400),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: ListView(
        physics: const NeverScrollableScrollPhysics(),
        children: [
          const Divider(),
          ListTile(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: const Text('Load the current city'),
                  action: SnackBarAction(
                      label: 'Load',
                      onPressed: () async {
                        await _app.setAsPreferedLocation();
                      }),
                ));
              },
              title: const Text('Location'),
              subtitle: Text(
                  'Set the current location as the prefered location',
                  style: Theme.of(context).textTheme.caption!.copyWith(
                      fontSize: 14,
                      fontFamily: GoogleFonts.robotoCondensed().fontFamily)),
              leading: const Icon(Icons.location_city)),
          SwitchListTile(
              secondary: Icon(_themecubit.dark ? Icons.dark_mode : Icons.light),
              title: const Text('Toggle Theme'),
              subtitle: Text(
                  _themecubit.dark
                      ? 'Change to light mode'
                      : 'Change to dark mode',
                  style: Theme.of(context).textTheme.caption!.copyWith(
                      fontSize: 14,
                      fontFamily: GoogleFonts.robotoCondensed().fontFamily)),
              value: _themecubit.dark,
              onChanged: (t) {
                _themecubit.toggletheme();
              }),
          ListTile(
              leading: const Icon(Icons.favorite),
              title: const Text('Clear Favourites'),
              subtitle: Text('Tap to clear all the favourites',
                  style: Theme.of(context).textTheme.caption!.copyWith(
                      fontSize: 14,
                      fontFamily: GoogleFonts.robotoCondensed().fontFamily)),
              onTap: () {
                StoreFavourites.clearFavourites();
                _fav.loadData();
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Favourites Cleared'),
                  duration: Duration(seconds: 1),
                ));
              }),
          SwitchListTile(
              secondary: const Icon(Icons.schedule),
              title: const Text('24:00 Clock'),
              value: _timeFormat.is24Mode,
              subtitle: Text('Set the prefered time format',
                  style: Theme.of(context).textTheme.caption!.copyWith(
                      fontSize: 14,
                      fontFamily: GoogleFonts.robotoCondensed().fontFamily)),
              onChanged: (t) {
                _timeFormat.toggleMode();
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
            subtitle: Text(
                'OpenWeather aggregates and process thousands of data from thousands of weather stations and satellites to bring you the accurate data from any locatiity',
                style: Theme.of(context).textTheme.caption!.copyWith(
                    fontSize: 14,
                    fontFamily: GoogleFonts.robotoCondensed().fontFamily)),
          ),
        ],
      ),
    );
  }
}
