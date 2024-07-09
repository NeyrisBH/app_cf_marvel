import 'package:app_cf_marvel/res/theme/light_color.dart';
import 'package:app_cf_marvel/widgets/comics_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: LightColor.lightGrey,
      body: Padding(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 1),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Comics',
                  style: TextStyle(
                      color: LightColor.black,
                      fontSize: 28,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 500,
                  child: ComicsWidget(),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Series',
                  style: TextStyle(
                      color: LightColor.black,
                      fontSize: 28,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 500,
                  child: ComicsWidget(),
                ),
              ],
            ),
          )),
    );
  }
}
