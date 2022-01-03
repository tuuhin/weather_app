import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weatherapp/app/app.dart';
import 'package:weatherapp/app/responses/response.dart';
import 'package:weatherapp/domain/services/cubit/AppCubit/app_cubit.dart';

class AppBuilder extends StatelessWidget {
  const AppBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppCubit _app = BlocProvider.of<AppCubit>(context, listen: true);
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        if (state is AppGivesSuccess) return App(model: state.model);
        return Scaffold(
          body: Builder(builder: (context) {
            if (state is AppLoading) {
              _app.getLocation();
              return const Spinner();
            } else if (state is ApiMadeBadRequest) {
              return Responses(
                helperAbsent: true,
                imageSrc: 'assets/api/unknown.png',
                secondary: '${state.statusCode} ${state.error}',
              );
            } else if (state is AppInternetAbsent) {
              return Responses(
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
              );
            } else if (state is AppUnknownErrorType) {
              return const Responses(
                helperAbsent: true,
                imageSrc: 'assets/api/unknown.png',
                secondary: 'Unknown error',
              );
            } else {
              return const SizedBox.shrink();
            }
          }),
          bottomNavigationBar: BottomAppBar(
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('WeatherApp',
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                            color: Colors.grey[600],
                            fontFamily: GoogleFonts.trirong().fontFamily,
                          ))
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
