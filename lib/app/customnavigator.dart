import 'package:flutter/material.dart';

class CustomNavigatationBar extends StatefulWidget {
  final TabController controller;
  const CustomNavigatationBar({required this.controller, Key? key})
      : super(key: key);

  @override
  _CustomNavigatationBarState createState() => _CustomNavigatationBarState();
}

class _CustomNavigatationBarState extends State<CustomNavigatationBar> {
  late TabController _controller;
  final List<IconData> _icons = [Icons.home, Icons.favorite, Icons.menu];

  final List<String> _labels = ['Home', 'Favourites', 'Settings'];
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller;

    _controller.addListener(() {
      int _next = _controller.index.round();
      if (_index != _next) {
        setState(() {
          _index = _controller.index;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        onTap: (t) {
          setState(() => _index = t);
          if (t == 0) {
            _controller.animateTo(0);
          }
          if (t == 1) {
            _controller.animateTo(1);
          }
          if (t == 2) {
            _controller.animateTo(2);
          }
        },
        selectedFontSize: 0.0,
        unselectedFontSize: 0.0,
        showUnselectedLabels: false,
        currentIndex: _index,
        showSelectedLabels: false,
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
            .toList());
  }
}
