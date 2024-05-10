import 'package:emart_seller/const/const.dart';

class StoreServices {
  static getProfile(uid) {
    return firestore
        .collection(vendorsCollection)
        .where('id', isEqualTo: currentUser!.uid)
        .get();
  }

  static getOrders(uid) {
    return firestore
        .collection(ordersCollection)
        .where('vendors', arrayContains: uid)
        .snapshots();
  }

  static getProducts(uid) {
    return firestore
        .collection(productsCollections)
        .where('vendor_id', isEqualTo: uid)
        .snapshots();
  }

  // static getPopularProducts(uid) {
  //   return firestore
  //       .collection(productsCollections)
  //       .where('vendor_id', isEqualTo: uid)
  //       .orderBy('p_wishlist'.length);
  // }
}
