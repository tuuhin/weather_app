import 'package:flutter/material.dart';
import 'package:weatherapp/app/screens/screens.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

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
    final List<Widget> _screens = [
      const Home(),
      const Favourites(),
      const Settings()
    ];
    final List<String> _labels = ['Home', 'Favourites'];
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
          },
          selectedItemColor: Colors.black45,
          unselectedItemColor: Colors.black45,
          items: _icons
              .map((e) => BottomNavigationBarItem(icon: Icon(e), label: 'hi'))
              .toList()),
    );
  }
}
