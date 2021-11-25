import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/domain/services/cubit/DataProvider/dataprovider_cubit.dart';

class BasicWeatherData extends StatelessWidget {
  const BasicWeatherData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DataproviderCubit _data = BlocProvider.of<DataproviderCubit>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Chip(
          avatar: const Icon(Icons.air),
          label: Text('${_data.model!.windSpeed ?? 0} m/s'),
        ),
        Chip(
          avatar: const Icon(Icons.invert_colors_outlined),
          label: Text('${_data.model!.humidity ?? 0} %'),
        ),
        Chip(
          avatar: const Icon(Icons.speed),
          label: Text('${_data.model!.pressure ?? 0} hPa'),
        )
      ],
    );
  }
}
