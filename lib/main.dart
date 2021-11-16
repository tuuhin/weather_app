import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weatherapp/app/app.dart';
import 'package:weatherapp/domain/services/cubit/FavouritesCubit/favourites_cubit.dart';
import 'package:weatherapp/domain/services/cubit/SearchCubit/search_cubit.dart';
import 'package:weatherapp/data/local/localstorage.dart';
import 'package:weatherapp/domain/services/theme/changetheme_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: '.env');
  await LocalStorage.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<ChangeThemeCubit>(
        create: (context) => ChangeThemeCubit(),
      ),
      BlocProvider<SearchCubit>(
        create: (context) => SearchCubit(),
      ),
      BlocProvider<FavouritesCubit>(create: (context) => FavouritesCubit())
    ], child: const Core());
  }
}

class Core extends StatelessWidget {
  const Core({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ChangeThemeCubit _themecubit =
        BlocProvider.of<ChangeThemeCubit>(context, listen: true);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather App',
      theme: _themecubit.dark ? ThemeData.dark() : ThemeData.light(),
      home: const App(),
    );
  }
}
