// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dictionary/constant/custom_color.dart';
import 'package:flutter/material.dart';

class TitleBody extends StatelessWidget {
  final String? title;
  final String? body;
  const TitleBody({
    Key? key,
    this.title,
    this.body,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: title,
            style: const TextStyle(
              color: CustomColor.lineColor,
            ),
          ),
          TextSpan(
            text: body,
            style: const TextStyle(
              color: CustomColor.textLightGrey,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }
}
