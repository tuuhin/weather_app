import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/app/routes/request.dart';
import 'package:weatherapp/app/routes/searchpage/searchpage.dart';
import 'package:weatherapp/app/routes/spinner.dart';
import 'package:weatherapp/domain/services/cubit/SearchCubit/search_cubit.dart';

class SearchBuilder extends StatelessWidget {
  const SearchBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(builder: (context, state) {
      print(state);

      if (state is Normal) {
        return const Expanded(child: Recents());
      } else if (state is Loading) {
        return const Spinner();
      } else if (state is BadRequest) {
        return const Requests(
            imageSrc: 'assets/requests/bad-req.png',
            helper: 'Bad Request',
            secondary:
                'The result is not returning a 200 statuscode thus there is a problem in the response of the api',
            buttonText: 'Try Again');
      } else if (state is Socket) {
        return const Requests(
            imageSrc: 'assets/requests/network.png',
            helper: 'Internet Error',
            secondary:
                'The device is not connected to internet.Connect to a internet provider and then press on retry',
            buttonText: 'Retry');
      } else if (state is UnknownError) {
        return const Requests(
            imageSrc: 'assets/requests/unknown.png',
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
