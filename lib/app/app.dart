import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/app/screens/screens.dart';
import 'package:weatherapp/domain/models/models.dart';
import 'package:weatherapp/domain/services/cubit/DataProvider/dataprovider_cubit.dart';

class App extends StatefulWidget {
  final HomeModel? model;
  const App({this.model, Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<IconData> _icons = [Icons.home, Icons.favorite, Icons.settings];
    final List<MaterialColor> _colors = [Colors.blue, Colors.red, Colors.grey];
    final List<Widget> _screens = [
      BlocProvider(
        create: (context) => DataproviderCubit(widget.model),
        child: const Home(),
      ),
      const Favourites(),
      const Settings()
    ];
    final List<String> _labels = ['Home', 'Favourites', 'Settings'];
    return Scaffold(
      body: TabBarView(
        controller: _controller,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
          onTap: (t) {
            if (t == 0) {
              _controller.animateTo(0);
            }
            if (t == 1) {
              _controller.animateTo(1);
            }
            if (t == 2) {
              _controller.animateTo(2);
            }
            setState(() {});
          },
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          items: _icons
              .asMap()
              .map((key, value) => MapEntry(
                  key,
                  BottomNavigationBarItem(
                    icon: Icon(value),
                    label: _labels[key],
                  )))
              .values
              .toList()),
    );
  }
}
