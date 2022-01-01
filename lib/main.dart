import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weatherapp/app/app_builder.dart';
import 'package:weatherapp/domain/services/cubit/AppCubit/app_cubit.dart';
import 'package:weatherapp/domain/services/cubit/FavouritesCubit/favourites_cubit.dart';
import 'package:weatherapp/domain/services/cubit/SearchCubit/search_cubit.dart';
import 'package:weatherapp/data/local/localstorage.dart';
import 'package:weatherapp/domain/services/cubit/TimeFormatCubit/timeformat_cubit.dart';
import 'package:weatherapp/domain/services/theme/changetheme_cubit.dart';
import 'package:weatherapp/domain/services/theme/palette.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: '.env');
  await LocalStorage.init();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<TimeFormatCubit>(
        create: (context) => TimeFormatCubit(),
      ),
      BlocProvider<ChangeThemeCubit>(
        create: (context) => ChangeThemeCubit(),
      ),
      BlocProvider<SearchCubit>(
        create: (context) => SearchCubit(),
      ),
      BlocProvider<FavouritesCubit>(create: (context) => FavouritesCubit()),
      BlocProvider<AppCubit>(
        create: (context) => AppCubit(),
      ),
    ], child: const _Core());
  }
}

class _Core extends StatelessWidget {
  const _Core({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ChangeThemeCubit _themecubit =
        BlocProvider.of<ChangeThemeCubit>(context, listen: true);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather App',
      theme: _themecubit.dark ? Palette.dark : Palette.light,
      home: const AppBuilder(),
    );
  }
}
