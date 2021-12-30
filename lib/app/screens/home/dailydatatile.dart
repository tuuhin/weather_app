import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class DailyDataTile extends StatelessWidget {
  final String? day;
  final num? maxTemp;
  final num? minTemp;
  final String? weatherIcon;

  const DailyDataTile(
      {Key? key, this.day, this.maxTemp, this.minTemp, this.weatherIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(day ?? 'error', style: Theme.of(context).textTheme.subtitle2),
          weatherIcon != null
              ? CachedNetworkImage(
                  width: 50,
                  height: 50,
                  errorWidget: (context, url, _) => const Icon(Icons.error),
                  placeholder: (context, str) =>
                      const SizedBox.square(dimension: 20),
                  imageUrl:
                      'http://openweathermap.org/img/wn/$weatherIcon@2x.png')
              : const SizedBox.square(dimension: 20),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  '${maxTemp ?? 0}' '\u00b0C',
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ),
              Text(
                '${minTemp ?? 0}' '\u00b0C',
                style: Theme.of(context).textTheme.caption,
              ),
            ],
          )
        ],
      ),
    );
  }
}
