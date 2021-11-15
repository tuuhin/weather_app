import 'package:flutter/material.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
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
                    prefixIcon: Icon(
                      Icons.search,
                      color: Theme.of(context).textTheme.bodyText1!.color,
                    ))),
          )
        ]),
      ),
    );
  }
}
