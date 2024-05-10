//import 'package:flutter/foundation.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/consts/list.dart';
import 'package:emart_app/controllers/product_controller.dart';
import 'package:emart_app/views/category_screen/category_details.dart';
import 'package:get/get.dart';
//import 'package:emart_app/consts/strings.dart';
//import 'package:emart_app/widgets_common/bg_widget.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter/widgets.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(imgBackground), fit: BoxFit.fill),
        ),
        child: Scaffold(
          appBar: AppBar(
            title: categories.text.fontFamily(bold).white.make(),
          ),
          body: Container(
            padding: const EdgeInsets.all(12),
            child: GridView.builder(
                shrinkWrap: true,
                itemCount: 9,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    mainAxisExtent: 200),
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Image.asset(
                        categoryImages[index],
                        height: 120,
                        width: 200,
                        fit: BoxFit.cover,
                      ),
                      categoryList[index]
                          .text
                          .color(darkFontGrey)
                          .fontFamily(bold)
                          .align(TextAlign.center)
                          .make(),
                    ],
                  )
                      .box
                      .white
                      .clip(Clip.antiAlias)
                      .outerShadowSm
                      .rounded
                      .make()
                      .onTap(() {
                    controller.getSubCategories(categoryList[index]);
                    Get.to(() => CategoryDetails(title: categoryList[index]));
                  });
                }),
          ),
        ),
      ),
    );
  }
}
