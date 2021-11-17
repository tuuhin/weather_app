import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        return const CircularProgressIndicator();
      } else if (state is BadRequest) {
        return const Text('Bad request');
      } else if (state is Socket) {
        return const Text('Internert adbsent');
      } else {
        return const Text('hellow');
      }
    });
  }
}
