import 'package:flutter/material.dart';
import 'package:shoppingcart/app/Base/base_class.dart';
import 'package:shoppingcart/app/constant/color_const.dart';
import 'package:shoppingcart/app/global.dart';
import 'package:shoppingcart/common/empty_widget.dart';
import 'package:shoppingcart/common/network_image.dart';

import '../../app/constant/string_const.dart';

class FavScreen extends StatefulWidget with BaseClass {
  FavScreen({
    super.key,
  });

  @override
  State<FavScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<FavScreen> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    final screenH = screenSize.height;
    final screenW = screenSize.width;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(AppString.product),
        ),
        body: favProductsList.isNotEmpty
            ? GridView.builder(
                itemCount: favProductsList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10),
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(border: Border.all(color: APPCOLOR.GREYCOLOR), borderRadius: BorderRadius.circular(15)),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Expanded(
                                child: AppNetworkImage(
                                  imageUrl: favProductsList[index].image ?? "",
                                  backGroundColor: APPCOLOR.GREYBG,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                favProductsList[index].title ?? "",
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(color: APPCOLOR.BlACKCOLOR, fontSize: 14, fontWeight: FontWeight.w600),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                                child: ElevatedButton(
                                    onPressed: () {},
                                    style: ButtonStyle(
                                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(0),
                                      )),
                                      backgroundColor: WidgetStatePropertyAll(APPCOLOR.GREEN),
                                    ),
                                    child: const Center(
                                      child: Text(
                                        "Add to cart",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    )),
                              )
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                          right: 10,
                          top: 10,
                          child: Icon(
                            Icons.favorite,
                            color: APPCOLOR.RED,
                          )),
                    ],
                  );
                })
            : EmptyWidget(message: "No Data Available"));
  }

  @override
  void initState() {
    super.initState();
  }
}
