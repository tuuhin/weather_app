import 'package:flutter/material.dart';

class ApiResponse extends StatelessWidget {
  final String imageSrc;
  final void Function()? onPressed;
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
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Image.asset(imageSrc, scale: 5),
          ListTile(title: Text(helper ?? ''), subtitle: Text(secondary ?? '')),
          !(helperAbsent == true)
              ? ElevatedButton(
                  onPressed: onPressed, child: Text(buttonText ?? ''))
              : const SizedBox.shrink()
        ],
      ),
    );
  }
}
