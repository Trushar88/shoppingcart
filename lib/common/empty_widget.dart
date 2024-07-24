// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shoppingcart/app/constant/assets_const.dart';

//Common Button Widget
class EmptyWidget extends StatelessWidget {
  final String message;
  final String? subTitle;
  bool isImage = false;
  final String? imagePath;

  EmptyWidget({super.key, required this.message, this.subTitle, this.isImage = false, this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Lottie.asset(
          AppAssets.noDataFound,
          height: 200,
          fit: BoxFit.contain,
          width: MediaQuery.sizeOf(context).width,
          animate: true,
          onLoaded: (composition) {},
        ),
        const SizedBox(
          height: 20,
        ),
        Text(message, style: const TextStyle(fontSize: 18)),
        subTitle == null ? const SizedBox() : Text(subTitle ?? "", textAlign: TextAlign.center, style: const TextStyle(fontSize: 12))
      ],
    ));
  }
}
