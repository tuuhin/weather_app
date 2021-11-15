import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/app/routes/searchpage/searchpage.dart';
import 'package:weatherapp/services/cubit/SearchCubit/search_cubit.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  late TextEditingController _search;
  @override
  void initState() {
    super.initState();
    _search = TextEditingController();
  }

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SearchCubit _searchcubit = BlocProvider.of<SearchCubit>(context);
    return WillPopScope(
      onWillPop: () async {
        _searchcubit.pop();
        return true;
      },
      child: Scaffold(
          body: SafeArea(
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _search,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      filled: true,
                      border: InputBorder.none,
                      hintText: 'Search',
                      suffixIcon: IconButton(
                          onPressed: () {
                            _search.text = '';
                          },
                          icon: Icon(
                            Icons.cancel,
                            color: Theme.of(context).textTheme.bodyText1!.color,
                          )),
                      prefixIcon: IconButton(
                          onPressed: () {
                            _searchcubit.pop();
                            Navigator.of(context).pop();
                          },
                          icon: Icon(
                            Icons.arrow_back,
                            color: Theme.of(context).textTheme.bodyText1!.color,
                          ))),
                ),
              ),
              BlocListener<SearchCubit, SearchState>(
                listener: (context, state) {},
                child: BlocBuilder<SearchCubit, SearchState>(
                    builder: (context, state) {
                  print(state);
                  if (state is Normal) {
                    return const Expanded(child: Recents());
                  }
                  if (state is GoodRequest) {
                    return const WeatherSummary();
                  }

                  return Text('hellow');
                }),
              )
            ]),
          ),
          floatingActionButton: FloatingActionButton(
              onPressed: () {
                _searchcubit.listenToSearch(_search.text);
              },
              child: Icon(Icons.search))),
    );
  }
}
