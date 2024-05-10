import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controllers/product_controller.dart';
import 'package:emart_app/services/firestore_services.dart';
import 'package:emart_app/views/category_screen/item_details.dart';
import 'package:get/get.dart';
//import 'package:emart_app/widgets_common/bg_widget.dart';
//import 'package:flutter/material.dart';

class CategoryDetails extends StatelessWidget {
  final String? title;
  const CategoryDetails({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductController>();

    return Container(
      decoration: const BoxDecoration(
        image:
            DecorationImage(image: AssetImage(imgBackground), fit: BoxFit.fill),
      ),
      child: Scaffold(
          appBar: AppBar(
            title: title!.text.fontFamily(bold).white.make(),
          ),
          body: StreamBuilder(
              stream: FirestoreServices.getProducts(title),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(redColor),
                  );
                } else if (snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: "No Products Found!".text.color(darkFontGrey).make(),
                  );
                } else {
                  var data = snapshot.data!.docs;
                  return Container(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            child: Row(
                                children: List.generate(
                                    controller.subcat.length,
                                    (index) => "${controller.subcat[index]}"
                                        .text
                                        .size(12)
                                        .fontFamily(bold)
                                        .color(darkFontGrey)
                                        .makeCentered()
                                        .box
                                        .white
                                        .rounded
                                        .size(120, 60)
                                        .margin(const EdgeInsets.symmetric(
                                            horizontal: 4))
                                        .make())),
                          ),
                          20.heightBox,
                          Expanded(
                            child: GridView.builder(
                                physics: const BouncingScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: data.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisExtent: 250,
                                        mainAxisSpacing: 8,
                                        crossAxisSpacing: 8),
                                itemBuilder: (context, index) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Image.network(
                                        data[index]['p_imgs'][0],
                                        height: 150,
                                        width: 200,
                                        fit: BoxFit.cover,
                                      ),
                                      "${data[index]['p_name']}"
                                          .text
                                          .fontFamily(semibold)
                                          .color(darkFontGrey)
                                          .make(),
                                      10.heightBox,
                                      "${data[index]['p_price']}"
                                          .numCurrency
                                          .text
                                          .color(redColor)
                                          .fontFamily(bold)
                                          .size(16)
                                          .make(),
                                    ],
                                  )
                                      .box
                                      .margin(const EdgeInsets.symmetric(
                                          horizontal: 4))
                                      .white
                                      .roundedSM
                                      .outerShadowSm
                                      .padding(const EdgeInsets.all(12))
                                      .make()
                                      .onTap(() {
                                    controller.checkIfFav(data[index]);
                                    Get.to(() => ItemDetails(
                                        title: "${data[index]['p_name']}",
                                        data: data[index]));
                                  });
                                }),
                          )
                        ]),
                  );
                }
              })),
    );
  }
}
