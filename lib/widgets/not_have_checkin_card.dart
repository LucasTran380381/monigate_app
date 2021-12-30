import 'package:flutter/material.dart';

import '../util.dart';

class NotHaveCheckinCard extends StatelessWidget {
  const NotHaveCheckinCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Card(
        color: Util.backgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.block_outlined,
                color: Colors.black54,
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                'Chưa có checkin',
                style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
