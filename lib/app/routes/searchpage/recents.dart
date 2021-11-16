import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/data/local/localstorage.dart';
import 'package:weatherapp/domain/services/cubit/SearchCubit/search_cubit.dart';

class Recents extends StatelessWidget {
  const Recents({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SearchCubit _searchcubit = BlocProvider.of<SearchCubit>(context);
    final List<String>? _recents = LocalStorage.getRecents();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Recents', style: Theme.of(context).textTheme.headline6),
              IconButton(
                  onPressed: () {
                    LocalStorage.clearHistory();
                  },
                  icon: const Icon(Icons.delete_forever))
            ],
          ),
          (_recents == null || _recents.isEmpty)
              ? const Text('No recents search')
              : Expanded(
                  child: ListView.builder(
                      itemCount: _recents.length,
                      itemBuilder: (context, i) => ListTile(
                            title: Text(_recents[i]),
                            onTap: () {
                              _searchcubit.listenToSearch(_recents[i]);
                            },
                          )),
                )
        ],
      ),
    );
  }
}
