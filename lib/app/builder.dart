import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weatherapp/app/api/api_response.dart';
import 'package:weatherapp/app/app.dart';
import 'package:weatherapp/data/utlis.dart';
import 'package:weatherapp/domain/services/cubit/AppCubit/app_cubit.dart';

class AppBuilder extends StatelessWidget {
  const AppBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppCubit _app = BlocProvider.of<AppCubit>(context, listen: true);
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        print(state);
        if (state is AppLoading) {
          Utils.getPos()
              .then((Position pos) =>
                  _app.getWeatherBulk(pos.latitude, pos.longitude))
              .onError((error, stackTrace) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('$error'),
            ));
          });
          print('hellow');
          // ;
          // _app.getWeatherBulk(23, 45);
          return const Scaffold(
              body: Center(
                  child: CircularProgressIndicator(
            semanticsLabel: 'Loading',
          )));
        } else if (state is AppSuccess) {
          return const App();
        } else if (state is ApiError) {
          return Scaffold(
              appBar: AppBar(
                title: const Text('Request Failed'),
                centerTitle: true,
              ),
              body: Column(
                children: [
                  ApiResponse(
                    helperAbsent: true,
                    imageSrc: 'assets/api/unknown.png',
                    secondary: '${state.error} ',
                  ),
                ],
              ));
        } else if (state is AppInternetAbsent) {
          return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: const Text('Internet Absent'),
              ),
              body: Center(
                  child: ApiResponse(
                onPressed: () async {
                  Position _pos = await Utils.getPos();
                  _app.getWeatherBulk(_pos.latitude, _pos.longitude);
                },
                imageSrc: 'assets/api/network.png',
                helper: 'Internet absent',
                secondary:
                    'Failed to connect to the host .The internet is supplied please turn on to continue',
                buttonText: 'Try Again',
              )));
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
