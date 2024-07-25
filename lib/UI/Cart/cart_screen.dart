import 'package:flutter/material.dart';
import 'package:shoppingcart/app/Base/base_class.dart';
import 'package:shoppingcart/app/constant/color_const.dart';
import 'package:shoppingcart/app/global.dart';
import 'package:shoppingcart/common/empty_widget.dart';
import 'package:shoppingcart/common/network_image.dart';

import '../../app/constant/string_const.dart';

class CartScreen extends StatefulWidget with BaseClass {
  CartScreen({
    super.key,
  });

  @override
  State<CartScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    final screenH = screenSize.height;
    final screenW = screenSize.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(AppString.cart),
      ),
      body: (productsList.isNotEmpty && productsList.where((e) => e.isCart == true).isNotEmpty)
          ? Padding(
              padding: const EdgeInsets.all(15),
              child: GridView.builder(
                  itemCount: productsList.where((e) => e.isCart == true).length,
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
                                      imageUrl: productsList.where((e) => e.isCart == true).toList()[index].image ?? "",
                                      backGroundColor: APPCOLOR.GREYBG,
                                      // height: 100,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "\$ ${productsList.where((e) => e.isCart == true).toList()[index].price}",
                                    style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 18),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              productsList.where((e) => e.isCart == true).toList()[index].title ?? "",
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
                                        removeCart(index);
                                      },
                                      child: Icon(
                                        Icons.close,
                                        color: APPCOLOR.RED,
                                        size: 30,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    SizedBox(
                                        child: Text(
                                      AppString.removeCart,
                                      style: TextStyle(color: APPCOLOR.RED, fontSize: 12),
                                    ))
                                  ],
                                )),
                            SizedBox(
                              height: 50,
                              width: screenW,
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      minQty(index);
                                    },
                                    child: Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(color: APPCOLOR.GREEN),
                                        child: const Center(
                                          child: Text(
                                            "-",
                                            style: TextStyle(color: Colors.white, fontSize: 30),
                                          ),
                                        )),
                                  ),
                                  const Spacer(),
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(border: Border.all(color: APPCOLOR.GREYCOLOR)),
                                    child: Center(
                                      child: Text(productsList.where((e) => e.isCart == true).toList()[index].addedQty.toString()),
                                    ),
                                  ),
                                  const Spacer(),
                                  InkWell(
                                    onTap: () {
                                      plusQty(index);
                                    },
                                    child: Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(color: APPCOLOR.GREEN),
                                        child: const Center(
                                          child: Text(
                                            "+",
                                            style: TextStyle(color: Colors.white, fontSize: 30),
                                          ),
                                        )),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            )
          : EmptyWidget(message: AppString.noData),
      bottomSheet: Container(
        decoration: BoxDecoration(color: APPCOLOR.RED.withOpacity(0.1)),
        height: 100,
        child: Center(
            child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${totalItem()} items in Cart",
                style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Text(
                "\$ ${totalPrice()}",
                style: TextStyle(color: APPCOLOR.GREEN, fontSize: 18, fontWeight: FontWeight.w600),
              )
            ],
          ),
        )),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  int totalItem() {
    List<int> tempList = productsList.where((e) => e.isCart == true).map((e) => e.addedQty).toList();
    int total = tempList.reduce((value, element) {
      return value + element;
    });
    return total;
  }

  double totalPrice() {
    List<double?> tempList = productsList.where((e) => e.isCart == true).map((e) => (double.tryParse(e.price!)! * e.addedQty)).toList();
    double? total = tempList.reduce((value, element) {
      return value! + element!;
    });
    return total ?? 0.0;
  }

  plusQty(index) {
    productsList.where((e) => e.isCart == true).toList()[index].addedQty++;
    setState(() {});
  }

  removeCart(index) {
    productsList.where((e) => e.isCart == true).toList()[index].addedQty = 0;
    productsList.where((e) => e.isCart == true).toList()[index].isCart = false;
    setState(() {});
  }

  minQty(index) {
    if (productsList.where((e) => e.isCart == true).toList()[index].addedQty == 1) {
      productsList.where((e) => e.isCart == true).toList()[index].addedQty = 0;
      productsList.where((e) => e.isCart == true).toList()[index].isCart = false;
    } else {
      productsList.where((e) => e.isCart == true).toList()[index].addedQty--;
    }
    setState(() {});
  }
}
