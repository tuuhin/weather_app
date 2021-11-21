import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/domain/services/theme/changetheme_cubit.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ChangeThemeCubit _themecubit = BlocProvider.of(context, listen: true);
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            const Text('settings'),
            SwitchListTile(
                title: const Text('Toggle Theme'),
                value: _themecubit.dark,
                onChanged: (t) {
                  _themecubit.toggletheme();
                }),
            ListTile(
              title: Text('Unit'),
              trailing: ToggleButtons(
                selectedColor: Colors.cyan,
                children: [Text('standard'), Text('metric'), Text('hellow')],
                isSelected: [false, false, true],
                onPressed: (i) {},
              ),
            )
          ],
        ),
      ),
    );
  }
}
