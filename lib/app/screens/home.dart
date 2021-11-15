import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('home'),
      ),
      body: ListView.builder(
          itemCount: 100,
          itemBuilder: (BuildContext context, int i) {
            return ListTile(
              leading: Text('$i'),
            );
          }),
    );
  }
}
