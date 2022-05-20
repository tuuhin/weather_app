import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/app/routes/resultspage/results.dart';
import 'package:weatherapp/app/routes/searchpage/searchpage.dart';
import 'package:weatherapp/data/local/store_recents.dart';
import 'package:weatherapp/domain/services/cubit/SearchCubit/search_cubit.dart';

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
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: TextField(
            autofocus: true,
            controller: _search,
            keyboardType: TextInputType.url,
            decoration: InputDecoration(
              filled: true,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none),
              hintText: 'Search',
              hintStyle: Theme.of(context).textTheme.caption,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 2, vertical: 3),
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
                    // _searchcubit.pop();
                    Navigator.of(context).pop();
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Theme.of(context).textTheme.bodyText1!.color,
                  )),
            ),
          ),
        ),
        body: SafeArea(
          child: BlocListener<SearchCubit, SearchState>(
            listener: (context, state) {
              if (state is GoodRequest) {
                // LocalStorage.recent(state.data!.cityName);
                StoreRecents.addRecents(state.data!.cityName);
                FocusScope.of(context).requestFocus(FocusNode());

                _search.text = '';
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) =>
                        WeatherSummary(summaryModel: state.data)));
              } else {
                _search.text = '';
              }
            },
            child: const SearchBuilder(),
          ),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              _searchcubit.getCity(_search.text);
            },
            child: const Icon(Icons.search)));
  }
}
