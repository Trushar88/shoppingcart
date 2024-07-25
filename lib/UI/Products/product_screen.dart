import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shoppingcart/UI/Cart/cart_screen.dart';
import 'package:shoppingcart/UI/Favorite/fav_screen.dart';
import 'package:shoppingcart/UI/Products/product_repository.dart';
import 'package:shoppingcart/app/Base/base_class.dart';
import 'package:shoppingcart/app/Network/base_response.dart';
import 'package:shoppingcart/app/Services/network_service.dart';
import 'package:shoppingcart/app/constant/color_const.dart';
import 'package:shoppingcart/app/global.dart';
import 'package:shoppingcart/common/empty_widget.dart';
import 'package:shoppingcart/common/network_image.dart';

import '../../app/constant/string_const.dart';

class ProductScreen extends StatefulWidget with BaseClass {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    final screenH = screenSize.height;
    final screenW = screenSize.width;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(AppString.product),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => FavScreen())).then((value) {
                    setState(() {});
                  });
                },
                child: Badge(
                  largeSize: 15,
                  smallSize: 15,
                  isLabelVisible: productsList.isNotEmpty
                      ? productsList.where((e) => e.isFavorite == true).isNotEmpty
                          ? true
                          : false
                      : false,
                  label: productsList.isNotEmpty
                      ? productsList.where((e) => e.isFavorite == true).isNotEmpty
                          ? Text(productsList.where((e) => e.isFavorite == true).length.toString())
                          : null
                      : null,
                  child: const Icon(Icons.favorite),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => CartScreen())).then((value) {
                    setState(() {});
                  });
                },
                child: Badge(
                    largeSize: 15,
                    smallSize: 15,
                    isLabelVisible: productsList.isNotEmpty
                        ? productsList.where((e) => e.isCart == true).isNotEmpty
                            ? true
                            : false
                        : false,
                    label: productsList.isNotEmpty
                        ? productsList.where((e) => e.isCart == true).isNotEmpty
                            ? Text(productsList.where((e) => e.isCart == true).length.toString())
                            : null
                        : null,
                    child: const Icon(
                      Icons.shopping_bag,
                    )),
              ),
            ),
          ],
        ),
        body: productsList.isNotEmpty
            ? GridView.builder(
                itemCount: productsList.length,
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
                                    imageUrl: productsList[index].image ?? "",
                                    backGroundColor: APPCOLOR.GREYBG,
                                    // height: 100,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "\$ ${productsList[index].price}",
                                  style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            productsList[index].title ?? "",
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
                                      clickFavButton(index);
                                    },
                                    child: Icon(
                                      productsList[index].isFavorite ? Icons.favorite : Icons.favorite_border,
                                      color: productsList[index].isFavorite ? APPCOLOR.RED : APPCOLOR.GREYCOLOR,
                                      size: 30,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  SizedBox(
                                      width: 70,
                                      child: Text(
                                        productsList[index].isFavorite ? AppString.savedLater : AppString.saveLater,
                                        style: TextStyle(color: productsList[index].isFavorite ? APPCOLOR.RED : APPCOLOR.GREYCOLOR, fontSize: 12),
                                      ))
                                ],
                              )),
                          Padding(
                            padding: const EdgeInsets.only(left: 0, right: 0, top: 5, bottom: 5),
                            child: ElevatedButton(
                                onPressed: () {
                                  if (productsList[index].isCart) {
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
                                    productsList[index].isCart ? AppString.viewCart : AppString.addCart,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                )),
                          )
                        ],
                      ),
                    ),
                  );
                })
            : EmptyWidget(message: AppString.noData));
  }

  @override
  void initState() {
    getProdcut();
    super.initState();
  }

  clickFavButton(index) {
    productsList[index].isFavorite = !productsList[index].isFavorite;
    setState(() {});
  }

  addCartButton(index) {
    productsList[index].isCart = true;
    productsList[index].addedQty++;
    setState(() {});
  }

  Future getProdcut() async {
    try {
      if (await NetworkController().checkNetworkOnce()) {
        widget.showLoader(context);
        BaseResponse res = await ProductRepo().getProducts();
        widget.hideLoader(context);
        if (res.success) {
          productsList = res.data;
          setState(() {});
        } else {
          widget.showSnackBar(context, message: AppString.somthingwentwrong);
        }
      } else {
        widget.showSnackBar(context, message: AppString.networkError);
      }
      log("");
    } catch (err) {
      widget.errorLog("productScreen", "getProdcut", err.toString());
    }
  }
}
