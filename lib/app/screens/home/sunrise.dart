import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/domain/services/cubit/DataProvider/dataprovider_cubit.dart';

class Sunrise extends StatelessWidget {
  final String? sunrise;
  final String? sunset;
  const Sunrise({Key? key, this.sunrise, this.sunset}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DataproviderCubit _data = BlocProvider.of<DataproviderCubit>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          SizedBox(
            height: 80,
            child: Stack(
              children: [
                SizedBox(
                  height: 80,
                  width: double.infinity,
                  child: CustomPaint(
                      foregroundPainter: ArcPainter(
                          Theme.of(context).brightness == Brightness.light
                              ? Colors.orange
                              : Colors.blue)),
                ),
                Positioned(
                    right: 15,
                    bottom: 10,
                    child: Image.asset(
                      'assets/icon/01n.png',
                      scale: 20,
                    )),
                Positioned(
                    left: 15,
                    bottom: 10,
                    child: Image.asset(
                      'assets/icon/01d.png',
                      scale: 20,
                    )),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Text('Sunrise : ${sunrise ?? 0}',
                style: Theme.of(context).textTheme.bodyText1),
            Text('Sunset : ${sunset ?? 0}',
                style: Theme.of(context).textTheme.bodyText1)
          ])
        ],
      ),
    );
  }
}

class ArcPainter extends CustomPainter {
  final Color color;

  ArcPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    final Path arc = Path();
    arc.moveTo(size.width * 0.06, size.height * 0.8);
    arc.arcToPoint(Offset(size.width * 0.94, size.height * 0.8),
        radius: const Radius.circular(300));
    canvas.drawPath(arc, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
