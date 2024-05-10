import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controllers/cart_controller.dart';
import 'package:emart_app/views/cart_screen/payment_method.dart';
import 'package:emart_app/widgets_common/common_buttons.dart';
import 'package:emart_app/widgets_common/customtextfield_widget.dart';
import 'package:get/get.dart';

class ShippingScreen extends StatelessWidget {
  const ShippingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Shipping Info"
            .text
            .fontFamily(semibold)
            .color(darkFontGrey)
            .make(),
      ),
      bottomNavigationBar: SizedBox(
        child: commonButtons(
          onPress: () {
            if (controller.addressController.text.length > 10) {
              Get.to(() => const PaymentMethods());
            } else {
              VxToast.show(context, msg: "Please fill the details.");
            }
          },
          color: redColor,
          textColor: whiteColor,
          title: "Continue",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            customTextField(
              hint: "Address",
              isPass: false,
              title: "Address",
              controller: controller.addressController,
            ),
            customTextField(
              hint: "City",
              isPass: false,
              title: "City",
              controller: controller.cityController,
            ),
            customTextField(
              hint: "State",
              isPass: false,
              title: "State",
              controller: controller.stateController,
            ),
            customTextField(
              hint: "Postal Code",
              isPass: false,
              title: "Postal Code",
              controller: controller.postalcodeController,
            ),
            customTextField(
              hint: "Phone",
              isPass: false,
              title: "Phone",
              controller: controller.phoneController,
            ),
          ],
        ),
      ),
    );
  }
}
