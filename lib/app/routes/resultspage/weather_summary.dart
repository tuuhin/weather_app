import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/app/routes/resultspage/results.dart';
import 'package:weatherapp/domain/models/models.dart';
import 'package:weatherapp/domain/services/cubit/SearchCubit/search_cubit.dart';

class WeatherSummary extends StatelessWidget {
  final SummaryModel? summaryModel;
  const WeatherSummary({Key? key, this.summaryModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SearchCubit _searchcubit = BlocProvider.of<SearchCubit>(context);
    print(summaryModel!.description);
    return WillPopScope(
      onWillPop: () async {
        _searchcubit.showLoading();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('${summaryModel!.cityName}',
              style: Theme.of(context).textTheme.headline5),
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
                  ? Image.asset('assets/icon/${summaryModel!.weatherId}.png',
                      scale: 2.5)
                  : const SizedBox.shrink(),
              Chip(
                  label: Text('${summaryModel!.weatherMain}',
                      style: Theme.of(context).textTheme.headline6)),
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
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Add to home',
                style: Theme.of(context).textTheme.subtitle2),
          ),
        ),
      ),
    );
  }
}
