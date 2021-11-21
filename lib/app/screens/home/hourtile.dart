import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class HourTile extends StatelessWidget {
  final String? iconCode;
  final num? temp;
  final DateTime? time;
  const HourTile({Key? key, this.iconCode, this.temp, this.time})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('$time'),
      ],
    );
  }
}
