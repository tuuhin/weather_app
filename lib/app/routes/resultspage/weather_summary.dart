import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weatherapp/app/routes/resultspage/results.dart';
import 'package:weatherapp/data/local/store_location.dart';
import 'package:weatherapp/domain/models/models.dart';
import 'package:weatherapp/domain/services/cubit/AppCubit/app_cubit.dart';
import 'package:weatherapp/domain/services/cubit/SearchCubit/search_cubit.dart';

class WeatherSummary extends StatelessWidget {
  final SummaryModel? summaryModel;
  const WeatherSummary({Key? key, this.summaryModel}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    AppCubit _app = BlocProvider.of<AppCubit>(context, listen: true);
    SearchCubit _searchcubit = BlocProvider.of<SearchCubit>(context);
    return WillPopScope(
      onWillPop: () async {
        _searchcubit.showRecents();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            '${summaryModel!.cityName}',
            style: Theme.of(context).textTheme.headline6!.copyWith(
                fontFamily: GoogleFonts.workSans().fontFamily,
                fontWeight: FontWeight.w400),
          ),
          elevation: 0,
          actions: [FavouriteAppBar(cityname: summaryModel!.cityName)],
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Text('latt: ${summaryModel!.lat}',
              //         style: Theme.of(context).textTheme.caption),
              //     const VerticalDivider(),
              //     Text('long: ${summaryModel!.lon}',
              //         style: Theme.of(context).textTheme.caption),
              //   ],
              // ),
              summaryModel!.weatherId != null
                  ? Image.asset(
                      'assets/icon/${summaryModel!.weatherId}.png',
                    )
                  : const SizedBox.shrink(),
              Chip(
                label: Text('${summaryModel!.weatherMain}',
                    style: Theme.of(context).textTheme.subtitle1),
              ),
              Text('${summaryModel!.description}',
                  style: Theme.of(context).textTheme.subtitle2),
              Text('${summaryModel!.temp} ' '\u00b0C',
                  style: Theme.of(context).textTheme.headline3),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Chip(
                      avatar: const Icon(Icons.air),
                      label: Text('${summaryModel!.windSpeed} m/s')),
                  Chip(
                      avatar: const Icon(Icons.opacity_outlined),
                      label: Text('${summaryModel!.humidity} %')),
                  Chip(
                      avatar: const Icon(Icons.mode_standby_rounded),
                      label: Text('${summaryModel!.pressure} atm'))
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Column(
                  children: [
                    ListTile(
                        contentPadding: EdgeInsets.zero,
                        dense: true,
                        trailing: Text('${summaryModel!.maxTemp}' '\u00b0C'),
                        title: const Text('Max temperature'),
                        leading: const Icon(Icons.thermostat)),
                    ListTile(
                        contentPadding: EdgeInsets.zero,
                        dense: true,
                        trailing: Text('${summaryModel!.minTemp} ' '\u00b0C'),
                        title: const Text('Min temperature'),
                        leading: const Icon(Icons.thermostat)),
                    ListTile(
                        contentPadding: EdgeInsets.zero,
                        dense: true,
                        trailing: Text('${summaryModel!.clouds} %'),
                        title: const Text('Cloud cover'),
                        leading: const Icon(Icons.cloud)),
                    ListTile(
                        contentPadding: EdgeInsets.zero,
                        dense: true,
                        trailing: Text('${summaryModel!.visibility} m'),
                        title: const Text('Visibility'),
                        leading: const Icon(Icons.visibility)),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          elevation: 0,
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              onPressed: () async {
                await StoreLocation.setUserPreferedLocation(
                    summaryModel!.lat, summaryModel!.lon);
                Navigator.of(context).pop();
                _app.emit(AppLoading());
              },
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text('Set as Prefered City',
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                        color: Colors.white,
                        fontFamily: GoogleFonts.robotoCondensed().fontFamily,
                        fontWeight: FontWeight.w400)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
