import 'package:flutter/material.dart';
import 'package:weatherapp/app/routes/searchpage/searchpage.dart';
import 'package:weatherapp/app/screens/favourites/weather_card.dart';

class Favourites extends StatelessWidget {
  const Favourites({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          children: [
            GestureDetector(
                onTap: () {
                  Navigator.of(context, rootNavigator: false).push(
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const SearchBar()));
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3),
                  child: ListTile(
                    tileColor: Theme.of(context).brightness == Brightness.light
                        ? Colors.grey[100]
                        : Colors.white10,
                    trailing: Icon(Icons.search),
                    title: Text(
                      'Search',
                      style: TextStyle(
                          color: Theme.of(context).textTheme.caption!.color),
                    ),
                  ),
                )),
            const Divider(),
            Expanded(
                child: ListView.builder(
                    itemCount: 30,
                    itemBuilder: (BuildContext context, int i) => WeatherCard(
                          cityname: 'Hongkong',
                          humidity: i,
                          temp: i,
                          pressure: i,
                          windSpeed: i,
                          visibility: i,
                        )))
          ],
        ),
      )),
    );
  }
}
