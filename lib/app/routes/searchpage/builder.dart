import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/app/api/api_response.dart';
import 'package:weatherapp/app/api/spinner.dart';
import 'package:weatherapp/app/routes/searchpage/searchpage.dart';
import 'package:weatherapp/domain/services/cubit/SearchCubit/search_cubit.dart';

class SearchBuilder extends StatelessWidget {
  const SearchBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(builder: (context, state) {
      if (state is Normal) {
        return const Expanded(child: Recents());
      } else if (state is Loading) {
        return const Spinner();
      } else if (state is BadRequest) {
        return const ApiResponse(
            imageSrc: 'assets/api/bad-req.png',
            helper: 'Bad Request',
            secondary:
                'The result is not returning a 200 statuscode thus there is a problem in the response of the api',
            buttonText: 'Try Again');
      } else if (state is InternetAbsent) {
        return const ApiResponse(
          helperAbsent: true,
          imageSrc: 'assets/api/network.png',
          helper: 'Internet Error',
          secondary:
              'The device is not connected to internet.Connect to a internet provider and then press on retry',
        );
      } else if (state is Unknown) {
        return const ApiResponse(
            imageSrc: 'assets/api/unknown.png',
            helper: 'Unknown Error',
            secondary:
                'Due to some unknown problem the application is not working fine.Try after some time',
            buttonText: 'Retry');
      } else {
        return const SizedBox.shrink();
      }
    });
  }
}
