import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Responses extends StatelessWidget {
  final String imageSrc;
  final void Function()? onPressed;
  final void Function()? tryAgain;
  final String? helper;
  final String? secondary;
  final String? buttonText;
  final bool? helperAbsent;
  const Responses({
    Key? key,
    required this.imageSrc,
    this.helper,
    this.secondary,
    this.onPressed,
    this.buttonText,
    this.helperAbsent,
    this.tryAgain,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(imageSrc, scale: 3),
            Text(helper ?? '', style: Theme.of(context).textTheme.headline5),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(secondary ?? '',
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      fontFamily: GoogleFonts.robotoCondensed().fontFamily)),
            ),
            !(helperAbsent == true)
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                          onPressed: tryAgain, child: const Text('Try again ')),
                      ElevatedButton(
                          onPressed: onPressed,
                          child: Text(buttonText ?? '',
                              style: Theme.of(context).textTheme.subtitle2))
                    ],
                  )
                : const SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
