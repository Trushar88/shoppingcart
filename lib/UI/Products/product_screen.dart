import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shoppingcart/Models/product_model.dart';
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
  List<ProductModel> _productsList = [];

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    final screenH = screenSize.height;
    final screenW = screenSize.width;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(AppString.product),
          actions: const [
            Badge(
              largeSize: 15,
              smallSize: 15,
              label: Text("1"),
              child: Icon(Icons.favorite),
            ),
            Badge(
                largeSize: 15,
                smallSize: 15,
                label: Text("1"),
                child: Icon(
                  Icons.shopping_bag,
                )),
          ],
        ),
        body: _productsList.isNotEmpty
            ? GridView.builder(
                itemCount: _productsList.length,
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
                                  imageUrl: _productsList[index].image ?? "",
                                  backGroundColor: APPCOLOR.GREYBG,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                _productsList[index].title ?? "",
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
                          child: InkWell(
                            onTap: () {
                              clickFavButton(index);
                            },
                            child: Icon(
                              _productsList[index].isFavorite ? Icons.favorite : Icons.favorite_border,
                              color: APPCOLOR.RED,
                            ),
                          )),
                    ],
                  );
                })
            : EmptyWidget(message: "No Data Available"));
  }

  @override
  void initState() {
    getProdcut();
    super.initState();
  }

  clickFavButton(index) {
    if (_productsList[index].isFavorite) {
      favProductsList.removeWhere((e) => e.id == _productsList[index].id);
    } else {
      favProductsList.add(_productsList[index]);
    }
    _productsList[index].isFavorite = !_productsList[index].isFavorite;
    setState(() {});
  }

  Future getProdcut() async {
    try {
      if (await NetworkController().checkNetworkOnce()) {
        widget.showLoader(context);
        BaseResponse res = await ProductRepo().getProducts();
        widget.hideLoader(context);
        if (res.success) {
          _productsList = res.data;
          setState(() {});
        } else {
          widget.showSnackBar(context, message: "Something went wrong");
        }
      } else {
        widget.showSnackBar(context, message: "Network is not available");
      }
      log("");
    } catch (err) {
      widget.errorLog("productScreen", "getProdcut", err.toString());
    }
  }
}
