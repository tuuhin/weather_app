import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class WeatherShimmer extends StatelessWidget {
  const WeatherShimmer({
    Key? key,
  }) : super(key: key);
// Color(0xffcfd8dc)
// Color(0xff90a4ae)
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
        child: ListTile(
          title: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Shimmer.fromColors(
                  baseColor: Theme.of(context).brightness == Brightness.light
                      ? const Color(0xffeeeeee)
                      : const Color(0xff616161),
                  highlightColor:
                      Theme.of(context).brightness == Brightness.light
                          ? const Color(0xfffafafa)
                          : const Color(0xff757575),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    color: Colors.white,
                    height: 20,
                  ),
                ),
              ),
            ],
          ),
          subtitle: Container(
            height: 65,
            decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.grey[100]
                    : Colors.white10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 6,
                  height: double.infinity,
                  decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.orange
                          : Colors.blue,
                      boxShadow: [
                        BoxShadow(
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? Colors.orange
                                  : Colors.blue,
                          blurRadius: 5,
                        )
                      ]),
                ),
                Shimmer.fromColors(
                  baseColor: Theme.of(context).brightness == Brightness.light
                      ? const Color(0xffeeeeee)
                      : const Color(0xff616161),
                  highlightColor:
                      Theme.of(context).brightness == Brightness.light
                          ? const Color(0xfffafafa)
                          : const Color(0xff757575),
                  child: Container(
                    color: Colors.grey,
                    width: MediaQuery.of(context).size.width * 0.82,
                    height: 65,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
