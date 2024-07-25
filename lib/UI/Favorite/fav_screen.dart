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
          title: const Text(AppString.favourite),
        ),
        body: (productsList.isNotEmpty && productsList.where((e) => e.isFavorite == true).isNotEmpty)
            ? Padding(
                padding: const EdgeInsets.all(15),
                child: GridView.builder(
                    itemCount: productsList.where((e) => e.isFavorite == true).length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10, childAspectRatio: 1 / 1.5),
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(border: Border.all(color: APPCOLOR.GREYCOLOR), borderRadius: BorderRadius.circular(15)),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: AppNetworkImage(
                                        imageUrl: productsList.where((e) => e.isFavorite == true).toList()[index].image ?? "",
                                        backGroundColor: APPCOLOR.GREYBG,
                                        // height: 100,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "\$ ${productsList.where((e) => e.isFavorite == true).toList()[index].price}",
                                      style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 18),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                productsList.where((e) => e.isFavorite == true).toList()[index].title ?? "",
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(color: Colors.blue, fontSize: 14, fontWeight: FontWeight.w600),
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(left: 0, right: 0, top: 5, bottom: 5),
                                  child: Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          removeFav(index);
                                        },
                                        child: Icon(
                                          Icons.favorite,
                                          color: APPCOLOR.RED,
                                          size: 30,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      SizedBox(
                                          width: 70,
                                          child: Text(
                                            AppString.savedLater,
                                            style: TextStyle(color: APPCOLOR.RED, fontSize: 12),
                                          ))
                                    ],
                                  )),
                              Padding(
                                  padding: const EdgeInsets.only(left: 0, right: 0, top: 5, bottom: 5),
                                  child: ElevatedButton(
                                      onPressed: () {
                                        if (productsList.where((e) => e.isFavorite == true).toList()[index].isCart) {
                                          return;
                                        }
                                        addCartButton(index);
                                      },
                                      style: ButtonStyle(
                                        shape: WidgetStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(0),
                                        )),
                                        backgroundColor: WidgetStatePropertyAll(APPCOLOR.GREEN),
                                      ),
                                      child: Center(
                                        child: Text(
                                          productsList.where((e) => e.isFavorite == true).toList()[index].isCart ? AppString.viewCart : AppString.addCart,
                                          style: const TextStyle(color: Colors.white),
                                        ),
                                      ))),
                            ],
                          ),
                        ),
                      );
                    }),
              )
            : EmptyWidget(message: AppString.noData));
  }

  @override
  void initState() {
    super.initState();
  }

  removeFav(index) {
    productsList.where((e) => e.isFavorite == true).toList()[index].isFavorite = false;
    setState(() {});
  }

  addCartButton(index) {
    productsList.where((e) => e.isFavorite == true).toList()[index].isCart = true;
    productsList.where((e) => e.isFavorite == true).toList()[index].addedQty++;
    setState(() {});
  }
}
