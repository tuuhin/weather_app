import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/app/customnavigator.dart';
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
  Widget build(BuildContext context) {
    final List<Widget> _screens = [
      BlocProvider(
        create: (context) => DataproviderCubit(widget.model),
        child: const Home(),
      ),
      const Favourites(),
      const Settings()
    ];

    return Scaffold(
      body: TabBarView(
        controller: _controller,
        children: _screens,
      ),
      bottomNavigationBar: CustomNavigatationBar(controller: _controller),
    );
  }
}
