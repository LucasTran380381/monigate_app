import 'package:flutter/material.dart';

import '../themes/color.dart';

class MyHeader extends StatelessWidget {
  final String? title;

  const MyHeader({
    Key? key,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      height: MediaQuery.of(context).size.height * 0.1,
      width: double.infinity,
      decoration: const BoxDecoration(
          color: AppColor.primaryColor,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(24),
              bottomRight: Radius.circular(24))),
      child: Text('$title',
          style: Theme.of(context)
              .textTheme
              .headline4!
              .merge(const TextStyle(color: Colors.white))),
    );
  }
}
