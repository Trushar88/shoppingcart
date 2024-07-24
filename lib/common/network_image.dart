import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shoppingcart/app/constant/assets_const.dart';
import 'package:shoppingcart/app/constant/color_const.dart';

//Custom AppBar widget
class AppNetworkImage extends StatelessWidget {
  final double? height;
  final double? width;
  final String imageUrl;
  final double? noImageTextSize;
  final bool isBorderShow;
  final Color backGroundColor;
  final Color? noImageTextColor;
  final BoxFit? boxFit;
  final double? radius;
  final Color? imageColor;
  final bool isShowColor;
  final bool isFromProfile;
  final bool isFromSlider;

  const AppNetworkImage({super.key, this.height, this.width, required this.imageUrl, this.noImageTextSize, this.isBorderShow = false, required this.backGroundColor, this.noImageTextColor, this.boxFit, this.radius, this.imageColor, this.isShowColor = false, this.isFromProfile = false, this.isFromSlider = false});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
        height: height,
        width: width,
        errorWidget: (context, url, error) {
          return Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
                color: backGroundColor,
                borderRadius: BorderRadius.circular(radius ?? 0),
                border: Border.all(
                  color: isBorderShow ? APPCOLOR.LIGHTGREY : Colors.transparent,
                  width: 1,
                )),
            child: Center(
                child: Image.asset(
              AppAssets.placeHolder,
              height: height != null ? (height! * 0.4) : null,
              color: imageColor,
            )),
          );
        },
        placeholder: (context, url) {
          return Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
                color: backGroundColor,
                borderRadius: BorderRadius.circular(radius ?? 0),
                border: Border.all(
                  color: isBorderShow ? APPCOLOR.LIGHTGREY : Colors.transparent,
                  width: 1,
                )),
            child: const Center(
              child: CupertinoActivityIndicator(),
            ),
          );
        },
        imageBuilder: (context, cIMage) {
          return Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
                color: backGroundColor,
                borderRadius: isFromSlider
                    ? BorderRadius.only(
                        topLeft: Radius.circular(radius!),
                        topRight: Radius.circular(radius!),
                      )
                    : isFromProfile
                        ? BorderRadius.only(
                            bottomLeft: Radius.circular(radius!),
                            bottomRight: Radius.circular(radius!),
                          )
                        : BorderRadius.circular(radius ?? 0),
                border: Border.all(color: isBorderShow ? APPCOLOR.LIGHTGREY : Colors.transparent, width: 1),
                image: DecorationImage(
                  fit: boxFit ?? BoxFit.contain,
                  colorFilter: isShowColor ? ColorFilter.mode(imageColor ?? APPCOLOR.PRIMARYCOLOR, BlendMode.srcIn) : null,
                  image: cIMage,
                )),
          );
        },
        imageUrl: imageUrl);
  }
}
