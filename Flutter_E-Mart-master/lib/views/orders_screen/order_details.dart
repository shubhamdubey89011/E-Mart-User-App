import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/views/orders_screen/components/order_place_details.dart';
import 'package:intl/intl.dart' as intl;
import 'package:emart_app/views/orders_screen/components/order_status.dart';

class OrderDetails extends StatelessWidget {
  final dynamic data;
  const OrderDetails({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Order Details".text.fontFamily(semibold).make(),
      ),
      body: Column(
        children: [
          orderStatus(
            color: redColor,
            icon: Icons.done,
            title: "Placed",
          ),
          orderStatus(
            color: redColor,
            icon: Icons.thumb_up,
            title: "Confirmed",
          ),
          orderStatus(
            color: redColor,
            icon: Icons.bike_scooter,
            title: "On Delivery",
          ),
          orderStatus(
            color: redColor,
            icon: Icons.done_all_rounded,
            title: "Delivered",
          ),
          10.heightBox,
          Column(
            children: [
              orderPlaceDetails(
                d1: data['order_code'],
                d2: data['shipping_method'],
                title1: "Order Code",
                title2: "Shipping Method",
              ),
              orderPlaceDetails(
                d1: intl.DateFormat()
                    .add_yMd()
                    .format((data['order_date'].toDate())),
                d2: data['payment_method'],
                title1: "Order Date",
                title2: "Payment Method",
              ),
              orderPlaceDetails(
                d1: "Unpaid",
                d2: "Order Placed",
                title1: "Payment Status",
                title2: "Delivery Status",
              ),
            ],
          ).box.shadowMd.color(whiteColor).make(),
          10.heightBox,
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    "Shipping Address".text.fontFamily(semibold).make(),
                    "${data['order_by_name']}".text.make(),
                    "${data['order_by_email']}".text.make(),
                    "${data['order_by_address']}".text.make(),
                    "${data['order_by_city']}".text.make(),
                    "${data['order_by_state']}".text.make(),
                    "${data['order_by_phone']}".text.make(),
                    "${data['order_by_postalcode']}".text.make(),
                  ],
                ),
                SizedBox(
                  width: 130,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      "Total Amount".text.fontFamily(semibold).make(),
                      "${data['total_amount']}"
                          .text
                          .color(redColor)
                          .fontFamily(bold)
                          .make(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
