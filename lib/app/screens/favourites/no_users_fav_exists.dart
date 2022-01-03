import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NoUserFavorites extends StatelessWidget {
  const NoUserFavorites({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: ListView(
        children: [
          Container(
            alignment: Alignment.center,
            child: Image.asset(
              'assets/api/heart.png',
              scale: 3,
            ),
          ),
          ListTile(
            title: const Text('No Favourites'),
            subtitle: Text('Seem\'s you haven\'t added any of your favourites',
                style: Theme.of(context).textTheme.caption!.copyWith(
                    fontSize: 14,
                    fontFamily: GoogleFonts.robotoCondensed().fontFamily)),
          )
        ],
      ),
    );
  }
}
