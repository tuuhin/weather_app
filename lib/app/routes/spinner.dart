import 'package:flutter/material.dart';

class Spinner extends StatelessWidget {
  const Spinner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          const CircularProgressIndicator(semanticsLabel: 'Loading...'),
          const SizedBox(height: 10),
          Text('Loading', style: Theme.of(context).textTheme.bodyText1)
        ],
      ),
    );
  }
}
