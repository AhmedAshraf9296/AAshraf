import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kanzalloshop/Model/products_model.dart';
import 'package:kanzalloshop/View/widgets/theme.dart';
import 'package:kanzalloshop/routes/routes.dart';

class CartController extends GetxController {
  var productsMap = {}.obs;

  get productSubTotal =>
      productsMap.entries.map((e) => e.key.price * e.value).toList();

  get productTotal => productsMap.entries
      .map((e) => e.key.price * e.value)
      .toList()
      .reduce((value, element) => value + element)
      .toStringAsFixed(2);

  void addProductToCart(ProductsModel productsModel) {
    if (productsMap.containsKey(productsModel)) {
      productsMap[productsModel] += 1;
      Get.snackbar(
        "",
        "Product Added Successfully to Cart",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: mainColor,
        colorText: Colors.white,
        duration: const Duration(seconds: 1)
      );
    } else {
      productsMap[productsModel] = 1;
    }
  }

  void removeOneProductFromCart(ProductsModel productsModel) {
    if (productsMap.containsKey(productsModel) &&
        productsMap[productsModel] == 1) {
      productsMap.removeWhere((key, value) => key == productsModel);
    } else {
      productsMap[productsModel] -= 1;
    }
  }

  void removeProductsFromCart(ProductsModel productsModel) {
    productsMap.removeWhere((key, value) => key == productsModel);
  }

  void clearAllProductsInCart() {
    Get.defaultDialog(
      title: "Clean your Cart",
      titleStyle: const TextStyle(
        fontSize: 13,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      middleText: "Are you sure to clear your cart ?",
      middleTextStyle: const TextStyle(
        fontSize: 13,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      backgroundColor: Colors.grey.shade300,
      radius: 10,
      textCancel: "No ",
      cancelTextColor: Colors.black,
      textConfirm: "Yes",
      confirmTextColor: Colors.black,
      onCancel: () {
        Get.toNamed(Routes.cartScreen);
      },
      onConfirm: () {
        productsMap.clear();
        Get.back();
      },
      buttonColor: Get.isDarkMode ? greenColor : Colors.pinkAccent.shade200,
    );
  }

  int quantity() {
    if(productsMap.isEmpty){
      return 0;
    }
    else{
      return productsMap.entries
          .map((e) => e.value)
          .toList()
          .reduce((value, element) => value + element);
    }
  }
}
