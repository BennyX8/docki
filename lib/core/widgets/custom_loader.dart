import 'package:flutter/material.dart';

import 'loading_icon.dart';

class CustomLoader extends StatelessWidget {
  final double? width;
  final double? height;
  final String message;
  final Axis? orientation;

  const CustomLoader({
    Key? key,
    this.width,
    this.height,
    required this.message,
    this.orientation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Material(
        type: MaterialType.transparency,
        child: Container(
          alignment: Alignment.center,
          width: width ?? 200.0,
          height: height ?? 60.0,
          margin: const EdgeInsets.all(25.0),
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            // color: Colors.white,
          ),
          child: orientation == null || orientation == Axis.horizontal
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                        width: 20.0,
                        height: 20.0,
                        child: LoadingIcon(
                          color: Colors.white,
                        )),
                    const SizedBox(width: 10.0),
                    Text(
                      message,
                      // style: GoogleFonts.montserrat(
                      //   color: Colors.grey, //Theme.of(context).primaryColor,
                      //   fontSize: 12.0, decoration: TextDecoration.none,
                      // ),
                    ),
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                        width: 25.0,
                        height: 25.0,
                        child: LoadingIcon(
                          color: Colors.white,
                        )),
                    const SizedBox(height: 10.0),
                    Text(
                      message,
                      // style: GoogleFonts.montserrat(
                      //   color: Colors.grey, //Theme.of(context).primaryColor,
                      //   fontSize: 12.0, decoration: TextDecoration.none,
                      // ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
