import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/controllers/products_controller.dart';
import 'package:emart_seller/services/store_services.dart';
import 'package:emart_seller/views/products_screen/add_product.dart';
import 'package:emart_seller/views/products_screen/product_details.dart';
import 'package:emart_seller/views/widgets/loading_indicator.dart';
import 'package:emart_seller/views/widgets/text_style.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductsController());
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await controller.getCategories();
          controller.populateCategoryList();
          Get.to(() => const AddProduct());
        },
        backgroundColor: purpleColor,
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        backgroundColor: white,
        automaticallyImplyLeading: false,
        title: boldText(text: products, color: fontGrey, size: 16.0),
        actions: [
          Center(
            child: normalText(
                text:
                    intl.DateFormat('EEE MMM d, ' 'yy').format(DateTime.now()),
                color: purpleColor),
          ),
          10.widthBox,
        ],
      ),
      body: StreamBuilder(
          stream: StoreServices.getProducts(currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return loadingIndicator();
            } else {
              var data = snapshot.data!.docs;

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: List.generate(
                      data.length,
                      (index) => Card(
                        child: ListTile(
                          onTap: () {
                            Get.to(() => ProductDetails(
                                  data: data[index],
                                ));
                          },
                          leading: Image.network(
                            data[index]['p_imgs'][0],
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                          title: boldText(
                              text: "${data[index]['p_name']}",
                              color: fontGrey),
                          subtitle: Row(
                            children: [
                              normalText(
                                  text: "\$${data[index]['p_price']}",
                                  color: darkGrey),
                              10.widthBox,
                              boldText(
                                  text: data[index]['is_featured'] == true
                                      ? "Featured"
                                      : '',
                                  color: green,
                                  size: 16.0),
                            ],
                          ),
                          trailing: VxPopupMenu(
                              arrowSize: 0.0,
                              menuBuilder: () => Column(
                                    children: List.generate(
                                      popUpMenuTitles.length,
                                      (i) => Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Row(
                                          children: [
                                            Icon(
                                              popUpMenuIcons[i],
                                              color: data[index]
                                                              ['featured_id'] ==
                                                          currentUser!.uid &&
                                                      i == 0
                                                  ? green
                                                  : purpleColor,
                                            ),
                                            5.widthBox,
                                            normalText(
                                                text:
                                                    data[index]['featured_id'] ==
                                                                currentUser!
                                                                    .uid &&
                                                            i == 0
                                                        ? 'Remove feature'
                                                        : popUpMenuTitles[i],
                                                color: darkGrey)
                                          ],
                                        ).onTap(() {
                                          switch (i) {
                                            case 0:
                                              if (data[index]['is_featured'] ==
                                                  true) {
                                                controller.removeFeatured(
                                                    data[index].id);
                                                VxToast.show(context,
                                                    msg: "Removed");
                                              } else {
                                                controller.addFeatured(
                                                    data[index].id);
                                                VxToast.show(context,
                                                    msg: "Added");
                                              }
                                              break;
                                            case 1:
                                              break;
                                            case 2:
                                              controller.deleteProduct(
                                                  data[index].id);
                                              VxToast.show(context,
                                                  msg: "Product Deleted");
                                              break;
                                            default:
                                          }
                                        }),
                                      ),
                                    ),
                                  ).box.white.rounded.width(200).make(),
                              clickType: VxClickType.singleClick,
                              child: const Icon(Icons.more_vert_rounded)),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }
          }),
      // body: Padding(
      //   padding: const EdgeInsets.all(8.0),
      //   child: SingleChildScrollView(
      //     physics: const BouncingScrollPhysics(),
      //     child: Column(
      //       children: List.generate(
      //         20,
      //         (index) => Card(
      //           child: ListTile(
      //             onTap: () {
      //               Get.to(() => const ProductDetails());
      //             },
      //             leading: Image.asset(
      //               imgShoes,
      //               width: 100,
      //               height: 100,
      //               fit: BoxFit.cover,
      //             ),
      //             title: boldText(text: "Product Title", color: fontGrey),
      //             subtitle: Row(
      //               children: [
      //                 normalText(text: "\$40", color: darkGrey),
      //                 10.widthBox,
      //                 boldText(text: "Featured", color: green, size: 16.0),
      //               ],
      //             ),
      //             trailing: VxPopupMenu(
      //                 arrowSize: 0.0,
      //                 menuBuilder: () => Column(
      //                       children: List.generate(
      //                         popUpMenuTitles.length,
      //                         (index) => Padding(
      //                           padding: const EdgeInsets.all(12.0),
      //                           child: Row(
      //                             children: [
      //                               Icon(popUpMenuIcons[index]),
      //                               5.widthBox,
      //                               normalText(
      //                                   text: popUpMenuTitles[index],
      //                                   color: darkGrey)
      //                             ],
      //                           ).onTap(() {}),
      //                         ),
      //                       ),
      //                     ).box.white.rounded.width(200).make(),
      //                 clickType: VxClickType.singleClick,
      //                 child: const Icon(Icons.more_vert_rounded)),
      //           ),
      //         ),
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}
