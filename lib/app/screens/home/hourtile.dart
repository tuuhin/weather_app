import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class HourTile extends StatelessWidget {
  final String? iconCode;
  final num? temp;
  final String? time;
  const HourTile({Key? key, this.iconCode, this.temp, this.time})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text('${time ?? 0}', style: Theme.of(context).textTheme.caption),
          iconCode != null
              ? CachedNetworkImage(
                  width: 50,
                  height: 50,
                  errorWidget: (context, url, _) => const Icon(Icons.error),
                  placeholder: (context, str) =>
                      const SizedBox.square(dimension: 20),
                  imageUrl: 'http://openweathermap.org/img/wn/$iconCode@2x.png')
              : const SizedBox.shrink(),
          Text('${temp ?? 0}' '\u00b0C',
              style: Theme.of(context).textTheme.subtitle2),
        ],
      ),
    );
  }
}
