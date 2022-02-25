import 'package:flutter/material.dart';

class SlideControlls extends StatelessWidget {
  const SlideControlls({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kToolbarHeight * 2,
      child: Column(
        children: [
          Slider(value: .5, onChanged: (onChanged) {}),
        ],
      ),
    );
  }
}
