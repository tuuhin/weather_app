import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/domain/services/theme/changetheme_cubit.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ChangeThemeCubit _themecubit = BlocProvider.of(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TextButton(
                onPressed: () {
                  _themecubit.toggletheme();
                },
                child: Text('change theme')),
          ],
        ),
      ),
    );
  }
}
