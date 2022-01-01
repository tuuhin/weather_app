import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/app/responses/responses.dart';
import 'package:weatherapp/app/responses/spinner.dart';
import 'package:weatherapp/app/routes/searchpage/searchpage.dart';
import 'package:weatherapp/domain/services/cubit/SearchCubit/search_cubit.dart';

class SearchBuilder extends StatelessWidget {
  const SearchBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(builder: (context, state) {
      if (state is Normal) {
        return const Recents();
      } else if (state is Loading) {
        return const Spinner();
      } else if (state is BadRequest) {
        return Responses(
            helperAbsent: true,
            imageSrc: 'assets/api/bad-req.png',
            helper: 'Bad Request ${state.errorCode ?? ''}',
            secondary: state.error,
            buttonText: 'Try Again');
      } else if (state is InternetAbsent) {
        return const Responses(
          helperAbsent: true,
          imageSrc: 'assets/api/network.png',
          helper: 'Internet Error',
          secondary:
              'The device is not connected to internet.Connect to a internet provider and then press on retry',
        );
      } else if (state is Unknown) {
        return Responses(
            helperAbsent: true,
            imageSrc: 'assets/api/unknown.png',
            helper: 'Error',
            secondary:
                'Due to ${state.error} problem the application is not working fine.Try after some time',
            buttonText: 'Retry');
      } else {
        return const SizedBox.shrink();
      }
    });
  }
}
