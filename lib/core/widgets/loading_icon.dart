import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingIcon extends StatelessWidget {
  final Color? color;
  const LoadingIcon({Key? key, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 25.0,
      height: 25.0,
      child: SpinKitDualRing(
        color: color ?? Colors.white,
        lineWidth: 2.0,
      ),
    );
  }
}
