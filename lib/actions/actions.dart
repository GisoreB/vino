import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/enums/enums.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Future<CartItemsRecord?> createCartItemFirestore(
  BuildContext context, {
  String? foodName,
  DocumentReference? userRef,
  String? foodPicture,
  int? quantity,
  double? price,
  String? size,
  String? type,
  DocumentReference? foodRef,
  required int? redeemedPoints,
}) async {
  CartItemsRecord? createdCartItem;

  var cartItemsRecordReference = CartItemsRecord.collection.doc();
  await cartItemsRecordReference.set(createCartItemsRecordData(
    name: foodName,
    pictureUrl: foodPicture,
    type: type,
    size: size,
    price: price,
    quantity: quantity,
    foodRef: foodRef,
    userId: userRef,
    consumedPoints: redeemedPoints,
  ));
  createdCartItem = CartItemsRecord.getDocumentFromData(
      createCartItemsRecordData(
        name: foodName,
        pictureUrl: foodPicture,
        type: type,
        size: size,
        price: price,
        quantity: quantity,
        foodRef: foodRef,
        userId: userRef,
        consumedPoints: redeemedPoints,
      ),
      cartItemsRecordReference);
  if (redeemedPoints! > 0) {
    await FFAppState().myRewardData!.update({
      ...mapToFirestore(
        {
          'availablePoints': FieldValue.increment(-(redeemedPoints!)),
          'history': FieldValue.arrayUnion([
            getRewardHistoryFirestoreData(
              createRewardHistoryStruct(
                title: 'Redeemed for ${foodName}',
                points: 0 - (redeemedPoints!),
                date: getCurrentTimestamp,
                clearUnsetFields: false,
              ),
              true,
            )
          ]),
        },
      ),
    });
  }

  return null;
}

Future updateCartItemFirestore(
  BuildContext context, {
  required CartItemsRecord? cartItem,
  required FoodsRecord? foodItem,
  required int? points,
}) async {
  await cartItem!.reference.update({
    ...createCartItemsRecordData(
      size: cartItem?.size,
      price: cartItem!.price + foodItem!.price,
      quantity: (int previousQuantity) {
        return ++previousQuantity;
      }(cartItem!.quantity),
    ),
    ...mapToFirestore(
      {
        'consumedPoints': FieldValue.increment(points!),
      },
    ),
  });
  if (points! > 0) {
    await FFAppState().myRewardData!.update({
      ...mapToFirestore(
        {
          'availablePoints': FieldValue.increment(-(points!)),
          'history': FieldValue.arrayUnion([
            getRewardHistoryFirestoreData(
              createRewardHistoryStruct(
                title: 'Consumed for ${foodItem?.name}',
                points: 0 - (points!),
                date: getCurrentTimestamp,
                clearUnsetFields: false,
              ),
              true,
            )
          ]),
        },
      ),
    });
  }
}

Future<CartItemsRecord?> cartIItemForFood(
  BuildContext context, {
  required List<CartItemsRecord>? cartItemsList,
  FoodsRecord? food,
}) async {
  return cartItemsList
      ?.where((e) => e.foodRef == food?.reference)
      .toList()
      ?.firstOrNull;
}

Future goToHome(BuildContext context) async {
  context.goNamed(
    HomePageWidget.routeName,
    extra: <String, dynamic>{
      '__transition_info__': TransitionInfo(
        hasTransition: true,
        transitionType: PageTransitionType.fade,
        duration: Duration(milliseconds: 0),
      ),
    },
  );
}
