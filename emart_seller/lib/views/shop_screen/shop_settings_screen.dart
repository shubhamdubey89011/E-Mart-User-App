import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/controllers/profile_controller.dart';
import 'package:emart_seller/views/widgets/custom_textfield.dart';
import 'package:emart_seller/views/widgets/loading_indicator.dart';
import 'package:emart_seller/views/widgets/text_style.dart';
import 'package:get/get.dart';

class ShopSettings extends StatelessWidget {
  const ShopSettings({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();
    return Obx(
      () => Scaffold(
        backgroundColor: purpleColor,
        appBar: AppBar(
          title: boldText(text: shopSettings, size: 16.0),
          actions: [
            controller.isLoading.value
                ? loadingIndicator(circleColor: white)
                : TextButton(
                    onPressed: () async {
                      controller.isLoading(true);
                      await controller.updateShop(
                        shopname: controller.shopNameController.text,
                        shopaddress: controller.shopAddressController.text,
                        shopmobile: controller.shopMobileController.text,
                        shopwebsite: controller.shopWebsiteController.text,
                        shopdesc: controller.shopDescController.text,
                      );
                      // ignore: use_build_context_synchronously
                      VxToast.show(context, msg: "Shop Updated Successfully.");
                    },
                    child: normalText(text: save))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              customTextfield(
                  label: shopName,
                  hint: nameHint,
                  controller: controller.shopNameController,
                  inputType: TextInputType.name),
              10.heightBox,
              customTextfield(
                  label: address,
                  hint: shopAddressHint,
                  controller: controller.shopAddressController,
                  inputType: TextInputType.streetAddress),
              10.heightBox,
              customTextfield(
                  label: mobile,
                  hint: shopMobileHint,
                  controller: controller.shopMobileController,
                  inputType: TextInputType.phone),
              10.heightBox,
              customTextfield(
                  label: website,
                  hint: shopWebsiteHint,
                  controller: controller.shopWebsiteController,
                  inputType: TextInputType.name),
              10.heightBox,
              customTextfield(
                  isDesc: true,
                  label: description,
                  hint: shopDescHint,
                  controller: controller.shopDescController,
                  inputType: TextInputType.multiline),
            ],
          ),
        ),
      ),
    );
  }
}
