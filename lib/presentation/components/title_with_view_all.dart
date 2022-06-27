import 'package:flutter/material.dart';
import 'package:folldy_student/utils/constants.dart';

class TitleWithAction extends StatelessWidget {
  const TitleWithAction(
      {Key? key,
      required this.title,
      this.onPressed,
      this.actionText = "View All"})
      : super(key: key);

  final String title;
  final VoidCallback? onPressed;
  final String actionText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: Theme.of(context).textTheme.headline6,
              maxLines: 2,
            ),
          ),
          if (onPressed != null)
            TextButton(onPressed: onPressed, child: Text(actionText)),
        ],
      ),
    );
  }
}
