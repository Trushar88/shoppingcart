import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoppingcart/Models/product_model.dart';

const String appName = "shoppingcart"; //AppName
const String appVerison = "0.0.1"; // AppVersion

SharedPreferences? sharedPreferences;
List<ProductModel> productsList = [];
List<ProductModel> cartProductsList = [];
