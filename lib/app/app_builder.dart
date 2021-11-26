import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:weatherapp/app/api/api_response.dart';
import 'package:weatherapp/app/app.dart';

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
          _app.getLocation();
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                semanticsLabel: 'Loading',
              ),
            ),
          );
        } else if (state is AppSuccess) {
          return App(model: state.model);
        } else if (state is ApiError) {
          return Scaffold(
              appBar: AppBar(
                title: const Text('Request Failed'),
                centerTitle: true,
              ),
              body: ApiResponse(
                helperAbsent: true,
                imageSrc: 'assets/api/unknown.png',
                secondary: '${state.error} ',
              ));
        } else if (state is AppInternetAbsent) {
          return Scaffold(
              body: Center(
                  child: ApiResponse(
            tryAgain: () {
              _app.emit(AppLoading());
            },
            onPressed: () {
              AppSettings.openDataRoamingSettings();
            },
            imageSrc: 'assets/api/network.png',
            helper: 'Internet absent',
            secondary:
                'Failed to connect to the host .The internet is supplied please turn on to continue',
            buttonText: 'Open settings',
          )));
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
