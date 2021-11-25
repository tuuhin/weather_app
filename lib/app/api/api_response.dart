import 'package:flutter/material.dart';

class ApiResponse extends StatelessWidget {
  final String imageSrc;
  final void Function()? onPressed;
  final void Function()? tryAgain;
  final String? helper;
  final String? secondary;
  final String? buttonText;
  final bool? helperAbsent;
  const ApiResponse({
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
      padding: const EdgeInsets.all(20.0),
      child: SizedBox(
        height: 250,
        child: Column(
          children: [
            Image.asset(imageSrc, scale: 6),
            const SizedBox(height: 10),
            ListTile(
                title: Text(helper ?? '',
                    style: Theme.of(context).textTheme.bodyText1),
                subtitle: Text(secondary ?? '')),
            !(helperAbsent == true)
                ? Column(
                    children: [
                      ElevatedButton(
                          onPressed: onPressed, child: Text(buttonText ?? '')),
                      ElevatedButton(
                          onPressed: tryAgain, child: const Text('Try again ')),
                    ],
                  )
                : const SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
