// ignore_for_file: file_names

import 'package:dio/dio.dart';
import 'package:shoppingcart/Models/product_model.dart';
import 'package:shoppingcart/app/Base/base_repository.dart';
import 'package:shoppingcart/app/Network/dio_exception.dart';
import 'package:shoppingcart/app/Network/generic_convert.dart';
import 'package:shoppingcart/app/constant/api_const.dart';

class ProductRepo extends BaseRepository {
  Future getProducts() async {
    try {
      Response response = await super.getDio().get(
            APIConst.get_products,
            // data: json.encode({"UserName": userName, "Password": passowrd}),
            options: Options(
              //Api Headers
              headers: await getApiHeaders(false),
            ),
          );
      if (response.statusCode == 200) {
        final recordList = Generics(response.data).getAsList<ProductModel>((p0) => ProductModel.fromJson(p0));
        return returnApiResult(true, recordList);
      } else {
        return returnApiResult(false, null);
      }
      //return reponse with master response model class
    } on DioException catch (e) {
      DioExceptions.fromDioError(e).toString();
    }
  }
}
